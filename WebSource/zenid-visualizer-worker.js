self.onerror = function (e) {
    postMessage({ status: "error", message: e.message, stack: e.error ? e.error.stack : null });
};

importScripts('zenid-visualizer-impl.js');

let visualizer;
let canvas;

onmessage = async function(e) {
    
    if (e.data.type === "init") {
        visualizer = new VisualizerImpl(e.data.options);
        await visualizer.init(e.data.visualizerScriptDir, e.data.rootStyle, e.data.images);
        postMessage({status: "initialized"});
        
    } else if (e.data.type === "draw") {
        if (visualizer === undefined) {
            visualizer = new VisualizerImpl();
            await visualizer.init(e.data.visualizerScriptDir, e.data.rootStyle);
        }
        visualizer.drawOverlay(canvas, e.data.age, e.data.renderCommands, e.data.rootStyle);
        
        postMessage({status: "drawn"});
    } else if (e.data.type === "clear") {
        visualizer.clearCanvas(e.data.param);
    } else if (e.data.type === "setCanvas") {
        canvas = e.data.canvas;
    } 
};

