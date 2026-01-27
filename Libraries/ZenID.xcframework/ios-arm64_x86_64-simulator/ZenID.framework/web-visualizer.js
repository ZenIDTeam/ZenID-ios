// When flattened: both web-visualizer.js and zenid-log.js are at same level
// When structured: web-visualizer.js is in js/, zenid-log.js is also in js/
// So "./zenid-log.js" works for both cases
import { zenidLog } from "./zenid-log.js";

/**
 * Implementation of visualizer using HTML Canvas
 */
export class VisualizerImplementation {
    options;
    canvas = null;
    ctx = null;
    container;
    styleObj = [];
    images = { statusSuccess: null, statusError: null, statusWaiting: null };
    isInitialized = false;
    resizeObserver = null;
    visualizerScriptDir = '';
    /**
     * Create a new visualizer implementation
     */
    constructor(container, options = {}) {
        this.container = container;
        this.options = {
            font: options.font || "24px sans-serif",
            drawText: options.drawText !== undefined ? options.drawText : true,
            highQualityRendering: options.highQualityRendering !== undefined ?
                options.highQualityRendering : true,
            ...options
        };
        // iOS: Detect asset path based on whether files are flattened or structured
        // This differs from WebSDK which assumes dist/ folder structure
        const currentScriptUrl = import.meta.url;
        const jsIndex = currentScriptUrl.lastIndexOf('/js/');

        if (jsIndex !== -1) {
            // Structured: web-visualizer.js is in js/ folder, assets are in assets/images/
            const bundleBasePath = currentScriptUrl.substring(0, jsIndex);
            this.visualizerScriptDir = `${bundleBasePath}/assets/images/`;
        } else {
            // Flattened: all files are at framework root
            const bundleBasePath = currentScriptUrl.substring(0, currentScriptUrl.lastIndexOf('/'));
            this.visualizerScriptDir = `${bundleBasePath}/`;
        }
    }
    /**
     * Initialize the visualizer with a container
     */
    async init() {
        if (this.isInitialized)
            return;
        // Get container element
        const containerElement = this.getContainerElement(this.container);
        // Look for an existing canvas in the container, reuse it if found
        const existingCanvas = containerElement.querySelector('canvas');
        if (existingCanvas) {
            zenidLog.info("Using existing canvas element");
            this.canvas = existingCanvas;
        }
        else {
            // Create a new canvas if none found
            zenidLog.info("Creating new canvas element");
            this.canvas = document.createElement('canvas');
            this.canvas.style.position = 'absolute';
            this.canvas.style.top = '0';
            this.canvas.style.left = '0';
            this.canvas.style.width = '100%';
            this.canvas.style.height = '100%';
            this.canvas.style.pointerEvents = 'none';
            this.canvas.style.zIndex = '9999'; // Ensure it's on top of other elements
            containerElement.appendChild(this.canvas);
        }
        // Set canvas size
        this.resizeCanvas();
        // Set up resize observer
        this.setupResizeObserver(containerElement);
        // Get 2D context
        const context = this.canvas.getContext('2d');
        if (!context) {
            throw new Error('Could not get canvas context');
        }
        this.ctx = context;
        // Load CSS variables
        this.loadCssVariables();
        // Load status images for liveness checks
        await this.loadStatusImages();
        this.isInitialized = true;
    }
    renderText(isOn) {
        this.options.drawText = isOn;
    }
    getWidth() {
        return this.canvas?.width || 0;
    }
    getHeight() {
        return this.canvas?.height || 0;
    }
    /**
     * Draw overlay based on render commands
     */
    drawOverlay(verifier, commands) {
        if (!this.isInitialized || !this.canvas || !this.ctx) {
            zenidLog.error('Visualizer not initialized. Call init() first.');
            return;
        }
        // Ensure the canvas is properly sized before drawing
        this.resizeCanvas();
        // Use direct rendering
        try {
            const ctx = this.ctx;
            const canvas = this.canvas;
            // Clear canvas
            this.clearCanvas();
            ctx.save();
            ctx.imageSmoothingEnabled = true;
            if (this.options.highQualityRendering) {
                ctx.imageSmoothingQuality = "high";
            }
            // Check if using declarative command format (JSON)
            const isDeclarativeCommandFormat = commands.startsWith("[");
            if (isDeclarativeCommandFormat) {
                this.drawOverlayDeclarative(ctx, Date.now(), JSON.parse(commands));
            }
            else {
                this.drawOverlayLegacy(ctx, Date.now(), commands);
            }
            ctx.restore();
        }
        catch (error) {
            zenidLog.error('Error drawing overlay:', error);
        }
    }
    /**
     * Clean up visualizer resources
     */
    cleanup() {
        // Clear canvas
        this.clearCanvas();
        // Clean up resize observer
        if (this.resizeObserver) {
            this.resizeObserver.disconnect();
            this.resizeObserver = null;
        }
        // Remove canvas from DOM
        if (this.canvas && this.canvas.parentNode) {
            this.canvas.parentNode.removeChild(this.canvas);
            this.canvas = null;
        }
        this.ctx = null;
        this.isInitialized = false;
    }
    /**
     * Clear the canvas
     */
    clearCanvas() {
        if (!this.ctx || !this.canvas)
            return;
        this.ctx.setTransform(1, 0, 0, 1, 0, 0);
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        this.ctx.beginPath();
    }
    /**
     * Get container element from IVisualContainer
     */
    getContainerElement(container) {
        // Check if container has getElement method
        if ('getElement' in container && typeof container.getElement === 'function') {
            return container.getElement();
        }
        // Otherwise, try to use container directly as HTMLElement
        if (container instanceof HTMLElement) {
            return container;
        }
        throw new Error('Container must be an HTMLElement or have a getElement() method');
    }
    /**
     * Resize canvas to match container size
     */
    resizeCanvas() {
        if (!this.canvas || !this.container)
            return;
        // Get the container element for accurate dimensions
        const containerElement = this.getContainerElement(this.container);
        // Get the computed style of the container
        const containerWidth = containerElement.clientWidth;
        const containerHeight = containerElement.clientHeight;
        // Only resize if dimensions have changed
        if (this.canvas.width !== containerWidth || this.canvas.height !== containerHeight) {
            this.canvas.width = containerWidth;
            this.canvas.height = containerHeight;
            //console.log("Canvas resized to:", this.canvas.width, "x", this.canvas.height);
            zenidLog.info(`Canvas resized to: ${this.canvas.width} x ${this.canvas.height}`);
        }
    }
    /**
     * Set up resize observer
     */
    setupResizeObserver(element) {
        if ('ResizeObserver' in window) {
            this.resizeObserver = new ResizeObserver(() => {
                this.resizeCanvas();
            });
            this.resizeObserver.observe(element);
        }
        else {
            // Fallback for browsers without ResizeObserver
            const windowObj = window;
            windowObj.addEventListener('resize', () => {
                this.resizeCanvas();
            });
        }
    }
    /**
     * Load CSS variables from document root
     */
    loadCssVariables() {
        const rootStyle = window.getComputedStyle(document.documentElement);
        const cssVars = [
            "--primary-color-card-outline", "--primary-color",
            "--contrast-color-card-outline", "--contrast-color",
            "--primary-color-face-oval", "--contrast-color-face-oval",
            "--camera-overlay-color-face-oval", "--camera-overlay-color",
            "--max-height-percent-face-oval", "--max-width-percent-face-oval",
            "--line-width-face-oval", "--camera-overlay-color-card-outline",
            "--line-width-card-outline", "--corner-radius-percent-card-outline",
            "--contrast-color-photo-outline", "--line-width-photo-outline",
            "--corner-radius-percent-photo-outline", "--problem-color-face-oval",
            "--problem-color", "--checkbox-area-width-percent-face-liveness",
            "--checkbox-area-distance-from-top-percent-face-liveness",
            "--checkbox-margin-percent-face-liveness", "--status-error-image-face-liveness",
            "--status-error-image", "--status-success-image-face-liveness",
            "--status-success-image", "--status-waiting-image-face-liveness",
            "--status-waiting-image"
        ];
        for (const key of cssVars) {
            const value = rootStyle.getPropertyValue(key);
            this.styleObj.push({ key, value });
        }
    }
    /**
     * Load status images for checkboxes
     */
    async loadStatusImages() {
        try {
            // Try to load images from CSS variables first
            let errorImageSrc = this.getCssProperty("--status-error-image-face-liveness", "--status-error-image", `${this.visualizerScriptDir}Status=Error, Background=Fill.svg`);
            let successImageSrc = this.getCssProperty("--status-success-image-face-liveness", "--status-success-image", `${this.visualizerScriptDir}Status=Success, Background=Fill.svg`);
            let waitingImageSrc = this.getCssProperty("--status-waiting-image-face-liveness", "--status-waiting-image", `${this.visualizerScriptDir}Status=Waiting, Background=Transparent.svg`);
            // Load the images
            this.images.statusError = await this.loadImage(errorImageSrc);
            this.images.statusSuccess = await this.loadImage(successImageSrc);
            this.images.statusWaiting = await this.loadImage(waitingImageSrc);
            // If failed to load from URLs, create placeholder images
            if (!this.images.statusError)
                this.images.statusError = await this.createStatusImage("red");
            if (!this.images.statusSuccess)
                this.images.statusSuccess = await this.createStatusImage("green");
            if (!this.images.statusWaiting)
                this.images.statusWaiting = await this.createStatusImage("gray");
        }
        catch (error) {
            zenidLog.error('Failed to load status images:', error);
            // Create fallback images
            this.images.statusSuccess = await this.createStatusImage("green");
            this.images.statusError = await this.createStatusImage("red");
            this.images.statusWaiting = await this.createStatusImage("gray");
        }
    }
    // Helper methods for loading and creating images
    async loadImage(src) {
        if (!src)
            return null;
        // Clean the src if it's a CSS url()
        const cleanedSrc = src.replace(/url\(["']?/, '').replace(/["']?\)$/, '');
        return new Promise((resolve) => {
            const image = new Image();
            image.onload = () => {
                const svgWidth = image.width * 2; // render 2x size to support retina displays
                const svgHeight = image.height * 2;
                if (svgWidth === 0 || svgHeight === 0) {
                    zenidLog.error('Invalid Image dimensions for', cleanedSrc);
                    resolve(null);
                    return;
                }
                const canvas = document.createElement('canvas');
                canvas.width = svgWidth;
                canvas.height = svgHeight;
                const ctx = canvas.getContext('2d');
                if (!ctx) {
                    resolve(null);
                    return;
                }
                ctx.clearRect(0, 0, svgWidth, svgHeight);
                ctx.drawImage(image, 0, 0, svgWidth, svgHeight);
                createImageBitmap(canvas)
                    .then(bitmap => resolve(bitmap))
                    .catch(e => {
                    console.error("Failed to load image: " + cleanedSrc, e);
                    resolve(null);
                });
            };
            image.onerror = (e) => {
                zenidLog.error("Failed to load image: " + cleanedSrc, e);
                resolve(null);
            };
            image.src = cleanedSrc;
        });
    }
    async createStatusImage(color) {
        try {
            const canvas = document.createElement('canvas');
            canvas.width = 48;
            canvas.height = 48;
            const ctx = canvas.getContext('2d');
            if (!ctx)
                return null;
            ctx.fillStyle = color;
            ctx.beginPath();
            ctx.arc(24, 24, 20, 0, Math.PI * 2);
            ctx.fill();
            if (color === "green") {
                // Add checkmark for success
                ctx.beginPath();
                ctx.moveTo(12, 24);
                ctx.lineTo(20, 32);
                ctx.lineTo(36, 16);
                ctx.strokeStyle = "white";
                ctx.lineWidth = 4;
                ctx.stroke();
            }
            else if (color === "red") {
                // Add X for error
                ctx.beginPath();
                ctx.moveTo(16, 16);
                ctx.lineTo(32, 32);
                ctx.moveTo(32, 16);
                ctx.lineTo(16, 32);
                ctx.strokeStyle = "white";
                ctx.lineWidth = 4;
                ctx.stroke();
            }
            return await createImageBitmap(canvas);
        }
        catch (error) {
            zenidLog.error('Failed to create status image:', error);
            return null;
        }
    }
    // Helper methods for styling and drawing
    /**
     * Get CSS property value with fallback
     */
    getCssProperty(specificCssProperty, generalCssProperty, fallback) {
        if (this.styleObj.length === 0)
            return fallback;
        if (specificCssProperty) {
            const specificStyle = this.styleObj.find(s => s.key === specificCssProperty);
            if (specificStyle && specificStyle.value) {
                return specificStyle.value;
            }
        }
        if (generalCssProperty) {
            const generalStyle = this.styleObj.find(s => s.key === generalCssProperty);
            if (generalStyle && generalStyle.value) {
                return generalStyle.value;
            }
        }
        return fallback;
    }
    /**
     * Draw overlay using legacy command format
     */
    drawOverlayLegacy(context, age, commandString) {
        const commandLines = commandString.split("\n");
        for (const commandLine of commandLines) {
            if (commandLine === "")
                continue;
            const tokens = commandLine.split(";");
            context.save();
            const commandType = tokens[0];
            if (commandType && commandType in this.commands) {
                const command = this.commands[commandType];
                if (command) {
                    command(context, age, tokens);
                }
            }
            context.restore();
        }
    }
    /**
     * Draw overlay using declarative JSON format
     */
    drawOverlayDeclarative(context, age, declarativeRenderData) {
        if (typeof declarativeRenderData === "string") {
            declarativeRenderData = JSON.parse(declarativeRenderData);
        }
        for (const widget of declarativeRenderData) {
            context.save();
            const widgetType = widget.type;
            if (widgetType && widgetType in this.widgets) {
                const widgetFunc = this.widgets[widgetType];
                if (widgetFunc) {
                    widgetFunc(context, age, widget);
                }
            }
            context.restore();
        }
    }
    /**
     * Parse color from tokens
     */
    parseColor(tokens, i, alphaScale = 1) {
        return {
            r: parseInt(tokens[i + 0]),
            g: parseInt(tokens[i + 1]),
            b: parseInt(tokens[i + 2]),
            a: parseInt(tokens[i + 3]) / 255 * alphaScale,
            toString() {
                return `rgba(${this.r}, ${this.g}, ${this.b}, ${this.a})`;
            }
        };
    }
    /**
     * Parse position from tokens
     */
    parsePosition(tokens, i) {
        return {
            x: this.round(parseFloat(tokens[i])),
            y: this.round(parseFloat(tokens[i + 1]))
        };
    }
    /**
     * Parse CSS color
     */
    parseCssColor(input) {
        if (input.substr(0, 1) === "#") {
            const collen = (input.length - 1) / 3;
            const fact = [17, 1, 0.062272][collen - 1];
            return [
                Math.round(parseInt(input.substr(1, collen), 16) * fact),
                Math.round(parseInt(input.substr(1 + collen, collen), 16) * fact),
                Math.round(parseInt(input.substr(1 + 2 * collen, collen), 16) * fact)
            ];
        }
        else {
            return input.split("(")[1].split(")")[0].split(",").map(x => +x);
        }
    }
    /**
     * Parse age alpha for fading effects (disabled - always returns full opacity)
     */
    parseAgeAlpha(tokens, i, age) {
        // Fading removed - always return full opacity
        return 1;
    }
    /**
     * Draw a rounded corner path
     */
    roundedCornerPath(context, rect, cornerRadius, lines = true) {
        const radius = cornerRadius;
        const x = rect.x;
        const y = rect.y;
        const width = rect.width;
        const height = rect.height;
        context.beginPath();
        context.moveTo(x + radius, y);
        if (lines) {
            context.lineTo(x + width - radius, y);
        }
        else {
            context.moveTo(x + width - radius, y);
        }
        context.arcTo(x + width, y, x + width, y + radius, radius);
        if (lines) {
            context.lineTo(x + width, y + height - radius);
        }
        else {
            context.moveTo(x + width, y + height - radius);
        }
        context.arcTo(x + width, y + height, x + width - radius, y + height, radius);
        if (lines) {
            context.lineTo(x + radius, y + height);
        }
        else {
            context.moveTo(x + radius, y + height);
        }
        context.arcTo(x, y + height, x, y + height - radius, radius);
        if (lines) {
            context.lineTo(x, y + radius);
        }
        else {
            context.moveTo(x, y + radius);
        }
        context.arcTo(x, y, x + radius, y, radius);
    }
    // Utility functions
    round(x) {
        return Math.max(Math.trunc(x), 1);
    }
    clamp01(x) {
        return Math.min(Math.max(x, 0), 1);
    }
    easeOutExpo(t) {
        return 1 - Math.pow(2, -8 * t);
    }
    ageAlpha(t) {
        return 1 - this.clamp01(this.easeOutExpo(t / 3000));
    }
    // Widget definitions for declarative rendering
    widgets = {
        legacy_commands: (context, age, widget) => {
            this.drawOverlayLegacy(context, age, widget.commands);
        },
        centered_face_mask: (context, age, widget) => {
            const hasProblem = widget.has_problem;
            const colors = {
                base_problem: this.getCssProperty("--problem-color-face-oval", "--problem-color", "#df3251"),
                base00: this.getCssProperty("--primary-color-face-oval", "--primary-color", "#3251DF"),
                base_contrast: this.getCssProperty("--contrast-color-face-oval", "--contrast-color", "#FFFFFF"),
                background_camera_overlay: this.getCssProperty("--camera-overlay-color-face-oval", "--camera-overlay-color", "rgba(0, 0, 0, 0.5)"),
            };
            const maxEllipseHeightPercent = parseFloat(this.getCssProperty(null, "--max-height-percent-face-oval", "0.65"));
            const maxEllipseWidthPercent = parseFloat(this.getCssProperty(null, "--max-width-percent-face-oval", "0.75"));
            const lineWidth = parseInt(this.getCssProperty(null, "--line-width-face-oval", "3"));
            const canvas = context.canvas;
            const twoPi = 2 * Math.PI;
            const centerX = canvas.width / 2;
            const centerY = canvas.height / 2;
            const radiusY = Math.min(canvas.width, canvas.height * maxEllipseHeightPercent) / 2;
            const radiusX = radiusY * maxEllipseWidthPercent;
            // Background
            context.fillStyle = colors.background_camera_overlay;
            context.fillRect(0, 0, canvas.width, canvas.height);
            // Hole
            context.globalCompositeOperation = "destination-out";
            context.fillStyle = "white";
            context.beginPath();
            context.ellipse(centerX, centerY, radiusX + lineWidth * 2, radiusY + lineWidth * 2, 0, 0, twoPi);
            context.fill();
            context.globalCompositeOperation = "source-over";
            // Border
            context.strokeStyle = colors.base_contrast;
            context.lineWidth = lineWidth;
            context.beginPath();
            context.ellipse(centerX, centerY, radiusX + lineWidth * 2, radiusY + lineWidth * 2, 0, 0, twoPi);
            context.stroke();
            if (hasProblem) {
                // Border problem
                context.strokeStyle = colors.base_problem;
                context.lineWidth = lineWidth;
                context.beginPath();
                context.ellipse(centerX, centerY, radiusX, radiusY, 0, 0, twoPi);
                context.stroke();
            }
            else {
                // Border 2
                context.strokeStyle = colors.base00;
                context.lineWidth = lineWidth;
                context.beginPath();
                context.ellipse(centerX, centerY, radiusX + lineWidth / 2, radiusY + lineWidth / 2, 0, 0, twoPi);
                context.stroke();
            }
        },
        card_outline: (context, age, widget) => {
            // Fading removed - always use full opacity
            let fadeAlpha = 1;
            const colors = {
                base00: this.getCssProperty("--primary-color-card-outline", "--primary-color", "#3251DF"),
                base_contrast: this.getCssProperty("--contrast-color-card-outline", "--contrast-color", "#FFFFFF"),
                background_camera_overlay: this.getCssProperty("--camera-overlay-color-card-outline", "--camera-overlay-color", "rgba(0, 0, 0, 0.5)"),
            };
            const lineWidth = parseInt(this.getCssProperty(null, "--line-width-card-outline", "5"));
            const cornerRadiusPercent = parseFloat(this.getCssProperty(null, "--corner-radius-percent-card-outline", "0.03"));
            const canvas = context.canvas;
            const rect = widget.rect;
            const cornerRadius = Math.max(rect.width, rect.height) * cornerRadiusPercent;
            const getFadedColor = (color) => {
                if (fadeAlpha === 1)
                    return color;
                const parsedColor = this.parseCssColor(color);
                if (parsedColor.length === 3)
                    parsedColor.push(1);
                parsedColor[3] = parsedColor[3] * fadeAlpha;
                return `rgba(${parsedColor.join(",")})`;
            };
            // Background
            context.fillStyle = getFadedColor(colors.background_camera_overlay);
            context.fillRect(0, 0, canvas.width, canvas.height);
            context.globalCompositeOperation = "destination-out";
            this.roundedCornerPath(context, rect, cornerRadius);
            context.fillStyle = getFadedColor(colors.base_contrast);
            context.fill();
            context.globalCompositeOperation = "source-over";
            // Actual outline
            this.roundedCornerPath(context, rect, cornerRadius);
            context.strokeStyle = getFadedColor(colors.base_contrast);
            context.lineWidth = lineWidth;
            context.stroke();
        },
        photo_outline: (context, age, widget) => {
            const colors = {
                base00: this.getCssProperty("--contrast-color-photo-outline", "--contrast-color", "#FFFFFF"),
            };
            const lineWidth = parseInt(this.getCssProperty(null, "--line-width-photo-outline", "5"));
            const cornerRadiusPercent = parseFloat(this.getCssProperty(null, "--corner-radius-percent-photo-outline", "0.03"));
            context.strokeStyle = colors.base00;
            context.lineWidth = lineWidth;
            const cornerRadius = Math.max(widget.rect.width, widget.rect.height) * cornerRadiusPercent;
            this.roundedCornerPath(context, widget.rect, cornerRadius);
            context.stroke();
        },
        face_liveness_checkboxes: (context, age, widget) => {
            // Controls the size of the checkboxes.
            const checkboxZoneWidthPercent = parseFloat(this.getCssProperty(null, "--checkbox-area-width-percent-face-liveness", "0.6"));
            // Controls the vertical position of the checkboxes.
            const checkboxZoneDistanceFromTopPercent = parseFloat(this.getCssProperty(null, "--checkbox-area-distance-from-top-percent-face-liveness", "0.05"));
            // Controls the size of the checkboxes and the separation between the checkboxes.
            const checkboxMarginPercent = parseFloat(this.getCssProperty(null, "--checkbox-margin-percent-face-liveness", "0.15"));
            const canvas = context.canvas;
            const regionWidth = Math.min(canvas.width, canvas.height) * checkboxZoneWidthPercent;
            const margin = (canvas.width - regionWidth) / 2;
            const checkboxWidth = Math.trunc(regionWidth / widget.totalCount);
            // Check if placeAtBottom is specified in the widget, default to true for hologram (bottom position)
            const placeAtBottom = widget.placeAtBottom ?? false;
            const top = placeAtBottom
                ? canvas.height * 0.9 - checkboxWidth // Place at bottom (90% from top minus checkbox height)
                : canvas.height * checkboxZoneDistanceFromTopPercent; // Place at top (5% from top)
            for (let i = 0; i < widget.totalCount; i++) {
                const tl = { x: margin + i * checkboxWidth, y: top };
                const m = Math.trunc(checkboxWidth * checkboxMarginPercent);
                const rect = {
                    x: tl.x + m,
                    y: tl.y + m,
                    width: checkboxWidth - m * 2,
                    height: checkboxWidth - m * 2
                };
                if (widget.failed && i === widget.passedCount) {
                    if (this.images.statusError) {
                        context.drawImage(this.images.statusError, rect.x, rect.y, rect.width, rect.height);
                    }
                }
                else if (i < widget.passedCount) {
                    if (this.images.statusSuccess) {
                        context.drawImage(this.images.statusSuccess, rect.x, rect.y, rect.width, rect.height);
                    }
                }
                else {
                    if (this.images.statusWaiting) {
                        context.drawImage(this.images.statusWaiting, rect.x, rect.y, rect.width, rect.height);
                    }
                }
            }
        }
    };
    // Command definitions for legacy rendering
    commands = {
        line: (context, age, tokens) => {
            const v1 = this.parsePosition(tokens, 1);
            const v2 = this.parsePosition(tokens, 3);
            context.beginPath();
            context.lineWidth = parseInt(tokens[9]);
            context.strokeStyle = this.parseColor(tokens, 5, this.parseAgeAlpha(tokens, 10, age)).toString();
            context.lineCap = "square";
            context.moveTo(v1.x, v1.y);
            context.lineTo(v2.x, v2.y);
            context.stroke();
        },
        rectangle: (context, age, tokens) => {
            const thickness = tokens[9];
            const color = this.parseColor(tokens, 5);
            if (thickness === "-1") {
                context.fillStyle = color.toString();
                context.fillRect(this.round(parseFloat(tokens[1])), this.round(parseFloat(tokens[2])), this.round(parseFloat(tokens[3])), this.round(parseFloat(tokens[4])));
            }
            else {
                context.lineWidth = parseInt(thickness);
                context.strokeStyle = color.toString();
                context.strokeRect(this.round(parseFloat(tokens[1])), this.round(parseFloat(tokens[2])), this.round(parseFloat(tokens[3])), this.round(parseFloat(tokens[4])));
            }
        },
        point: (context, age, tokens) => {
            const location = this.parsePosition(tokens, 1);
            const color = this.parseColor(tokens, 3);
            const size = parseInt(tokens[7]);
            context.fillStyle = color.toString();
            context.fillRect(location.x, location.y, size, size);
        },
        text: (context, age, tokens) => {
            if (!this.options.drawText)
                return;
            const text = tokens[1];
            const horizontalAlignment = tokens[4];
            const verticalAlignment = tokens[5];
            const location = this.parsePosition(tokens, 2);
            // Use specified font, or calculate dynamic font size if not specified
            if (this.options.font) {
                context.font = this.options.font;
            }
            else {
                // Dynamic font size based on canvas size
                const canvasSize = Math.min(context.canvas.width, context.canvas.height);
                const baseFontSize = Math.max(16, Math.min(32, canvasSize / 25));
                const fontFamily = "system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif";
                context.font = `${baseFontSize}px ${fontFamily}`;
            }
            context.textAlign = horizontalAlignment;
            if (verticalAlignment === "center") {
                context.textBaseline = "middle";
            }
            else {
                context.textBaseline = verticalAlignment;
            }
            const color = this.parseColor(tokens, 6);
            // Enable better text rendering
            context.save();
            context.fillStyle = color.toString();
            // Check if text is white (255,255,255) - use enhanced rendering
            const isWhiteText = color.r === 255 && color.g === 255 && color.b === 255;
            if (isWhiteText) {
                // Enhanced rendering for white text - multiple shadows
                context.shadowColor = 'rgba(0, 0, 0, 1)';
                context.shadowOffsetX = 0;
                context.shadowOffsetY = 0;
                // Draw text with multiple shadow layers
                context.shadowBlur = 3;
                context.fillText(text, location.x, location.y);
                context.shadowBlur = 6;
                context.fillText(text, location.x, location.y);
                context.shadowBlur = 9;
                context.fillText(text, location.x, location.y);
            }
            else {
                // Original rendering for non-white text
                context.shadowColor = 'rgba(0, 0, 0, 0.5)';
                context.shadowBlur = 3;
                context.shadowOffsetX = 1;
                context.shadowOffsetY = 1;
                context.fillText(text, location.x, location.y);
            }
            // Reset shadow and add outline for all text
            context.shadowColor = 'transparent';
            context.shadowBlur = 0;
            context.shadowOffsetX = 0;
            context.shadowOffsetY = 0;
            context.strokeStyle = "rgba(0, 0, 0, 0.3)";
            context.lineWidth = 1;
            context.lineJoin = 'round';
            context.miterLimit = 2;
            context.strokeText(text, location.x, location.y);
            context.restore();
        },
        circle: (context, age, tokens) => {
            const center = this.parsePosition(tokens, 1);
            const radius = this.round(parseFloat(tokens[3]));
            const thickness = tokens[8];
            const color = this.parseColor(tokens, 4, this.parseAgeAlpha(tokens, 9, age));
            if (thickness === "-1") {
                context.beginPath();
                context.fillStyle = color.toString();
                context.arc(center.x, center.y, radius, 0, 2 * Math.PI);
                context.fill();
            }
            else {
                context.beginPath();
                context.strokeStyle = color.toString();
                context.lineWidth = parseInt(thickness);
                context.arc(center.x, center.y, radius, 0, 2 * Math.PI);
                context.stroke();
            }
        },
        ellipse: (context, age, tokens) => {
            const center = this.parsePosition(tokens, 1);
            const radiusX = this.round(parseFloat(tokens[3]));
            const radiusY = this.round(parseFloat(tokens[4]));
            const rotation = parseFloat(tokens[5]); // radians
            const thickness = tokens[10];
            const color = this.parseColor(tokens, 6, this.parseAgeAlpha(tokens, 11, age));
            if (thickness === "-1") {
                context.beginPath();
                context.fillStyle = color.toString();
                context.ellipse(center.x, center.y, radiusX, radiusY, rotation, 0, 2 * Math.PI);
                context.fill();
            }
            else {
                context.beginPath();
                context.strokeStyle = color.toString();
                context.lineWidth = parseInt(thickness);
                context.ellipse(center.x, center.y, radiusX, radiusY, rotation, 0, 2 * Math.PI);
                context.stroke();
            }
        },
        triangle: (context, age, tokens) => {
            const a = this.parsePosition(tokens, 1);
            const b = this.parsePosition(tokens, 3);
            const c = this.parsePosition(tokens, 5);
            const color = this.parseColor(tokens, 7);
            const thickness = tokens[11];
            if (thickness === "-1") {
                context.globalCompositeOperation = "lighter";
                context.beginPath();
                context.fillStyle = color.toString();
                context.moveTo(a.x, a.y);
                context.lineTo(b.x, b.y);
                context.lineTo(c.x, c.y);
                context.fill();
                context.globalCompositeOperation = "source-over";
            }
            else {
                context.beginPath();
                context.lineWidth = parseInt(thickness);
                context.strokeStyle = color.toString();
                context.lineCap = "butt";
                context.moveTo(a.x, a.y);
                context.lineTo(b.x, b.y);
                context.lineTo(c.x, c.y);
                context.lineTo(a.x, a.y);
                context.stroke();
            }
        }
    };
}
//# sourceMappingURL=web-visualizer.js.map