const visualizerScriptSrc = document.currentScript.src;
const visualizerScriptDir = visualizerScriptSrc.substr(0, visualizerScriptSrc.lastIndexOf("/"));

class Visualizer {
    constructor(options = {}) {
        this.options = options;    
        this.isInitialized = false;
        this.isInitializing = false;
    }

    loadImage(src) {
        if (src) {
            src = src.replace(/url\(["']?/, '').replace(/["']?\)$/, '');
        }
        return new Promise((resolve, reject) => {
            const image = new Image();

            image.onload = () => {
                const svgWidth = image.width * 2; // render 2x size to support retina displays
                const svgHeight = image.height * 2;

                if (svgWidth === 0 || svgHeight === 0) { reject('Invalid Image dimensions'); return; }

                const canvas = document.createElement('canvas');
                canvas.width = svgWidth;
                canvas.height = svgHeight;
                const ctx = canvas.getContext('2d');

                ctx.clearRect(0, 0, svgWidth, svgHeight);
                ctx.drawImage(image, 0, 0, svgWidth, svgHeight);

                createImageBitmap(canvas)
                    .then(bitmap => resolve(bitmap))
                    .catch(e => {
                        console.error("Failed to load image: " + src, e);
                        resolve(null);
                    });

            };

            image.onerror = (e) => {
                console.error("Failed to load image: " + src, e);
                resolve(null);
            };

            image.src = src;
        });
    }


    //method updated so it uses flat CSS variables array
    getCssProperty(specificCssProperty, generalCssProperty, fallback) {
        if (this.styleObj == null) return fallback;
        return this.styleObj.find(s => s.key === specificCssProperty)?.value
                || this.styleObj.find(s => s.key === generalCssProperty)?.value
                || fallback;
    }    

    async loadImages() {
        let statusError = this.loadImage(this.getCssProperty("--status-error-image-face-liveness", "--status-error-image",
            `${visualizerScriptDir}/Images/Status=Error, Background=Fill.svg`));

        let statusSuccess = this.loadImage(this.getCssProperty("--status-success-image-face-liveness", "--status-success-image",
            `${visualizerScriptDir}/Images/Status=Success, Background=Fill.svg`));

        let statusWaiting = this.loadImage(this.getCssProperty("--status-waiting-image-face-liveness", "--status-waiting-image",
            `${visualizerScriptDir}/Images/Status=Waiting, Background=Transparent.svg`));

        let images = {};
        images.statusError = await statusError;
        images.statusSuccess = await statusSuccess;
        images.statusWaiting = await statusWaiting;
        
        return images;
    }


    async init() {
        if (this.isInitialized) return;
        this.isInitializing = true;
        
        this.worker = new Worker(visualizerScriptDir + '/zenid-visualizer-worker.js');
        this.drawing = false;
        this.styleObj = [];
        this.oldCanvas = null;
        this.canvasClone = null;
        this.offscreen = null;
        

        let rootStyle = window.getComputedStyle(document.documentElement);

        // Create flat array from CSS variables, due to we need to pass it to worker, i.e. other thread
        let toImport = ["--primary-color-card-outline", "--primary-color", "--contrast-color-card-outline", "--contrast-color", "--primary-color-face-oval", "--contrast-color-face-oval", "--camera-overlay-color-face-oval", "--camera-overlay-color", "--max-height-percent-face-oval", "--max-width-percent-face-oval", "--line-width-face-oval","--camera-overlay-color-card-outline","--camera-overlay-color","--line-width-card-outline","--corner-radius-percent-card-outline", "--contrast-color-photo-outline","--line-width-photo-outline","--corner-radius-percent-photo-outline","--status-error-image-face-liveness","--status-error-image","--status-success-image-face-liveness","--status-success-image","--status-waiting-image-face-liveness", "--status-waiting-image","--checkbox-area-width-percent-face-liveness","--checkbox-area-distance-from-top-percent-face-liveness","--checkbox-margin-percent-face-liveness"]
        for (let i = 0; i < toImport.length; i++) {
            let key = toImport[i];
            let value = rootStyle.getPropertyValue(key);
            this.styleObj.push({key: key, value: value});
        }
        
        let images = await this.loadImages(); 
        
        this.worker.postMessage({type: "init", options: this.options, visualizerScriptDir: visualizerScriptDir, rootStyle: this.styleObj, images: images}, Object.values(images));
        this.isInitialized = true;
    }

    async drawOverlay(canvas, age, renderCommands, renderingStats) {
        if (!this.isInitialized) {
            if (!this.isInitializing) await this.init();
            else return;
        }
        
        if (this.drawing) {
            //console.log("Skipping draw request because previous drawing is not yet complete.");
            return;
        }

        this.drawing = true;
       
        if (renderingStats) renderingStats.begin();

        const hasSameSize = this.canvasClone && this.canvasClone.width == canvas.width && this.canvasClone.height == canvas.height;
        if (this.oldCanvas !== canvas || !hasSameSize) {
            this.canvasClone = document.createElement('canvas');
            this.canvasClone.width = canvas.width;
            this.canvasClone.height = canvas.height;
            this.oldCanvas = canvas;
            
            this.offscreen = this.canvasClone.transferControlToOffscreen();
            
            this.worker.postMessage({
                type: "setCanvas",
                canvas: this.offscreen
            }, [this.offscreen]);
        }
        
        this.worker.postMessage({
            type: "draw",
            age: age,
            renderCommands: renderCommands,
            visualizerScriptDir: visualizerScriptDir, 
            rootStyle: this.styleObj,
        });

        this.worker.onmessage = (e) => {
            if (e.data.status === "drawn") {
                this.drawing = false;

                requestAnimationFrame(() => {
                    let context = canvas.getContext("2d");
                    context.clearRect(0, 0, canvas.width, canvas.height);
                    context.drawImage(this.canvasClone, 0, 0, canvas.width, canvas.height);
                });
            } else if (e.data.status === "error") {
                // Handle the error received from the worker
                console.error('Worker error:', e.data.message);
                if (e.data.stack) {
                    console.error('Stack trace:', e.data.stack);
                }
                this.drawing = false;
                if (renderingStats) renderingStats.end();
            }
        };
    }

    clearCanvas(param) {
        this.worker.postMessage({type: "clear", param: param});
    }
}
