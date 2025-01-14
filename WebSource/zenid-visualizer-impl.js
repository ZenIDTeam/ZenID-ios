function VisualizerImpl(options = {}) {

    const self = this;
    let images = {};
    
    options.font = options.font || "24px sans-serif";

    if (options.drawText == null) {
        options.drawText = true;
    }

    // Used for fading in the outline
    let showOutlineStartDate = null;

    this.drawOverlay = function (canvas, age, renderCommands, rootStyle) {

        self.rootStyle = rootStyle;
        
        const context = canvas.getContext("2d");
        
        context.save();
        clearCanvas(context);
        context.restore();
        context.imageSmoothingEnabled = true;
        context.imageSmoothingQuality = "high";
        const isDeclarativeCommandFormat = renderCommands.startsWith("[");
        if (isDeclarativeCommandFormat) {
            drawOverlayDeclarative(context, age, JSON.parse(renderCommands));
        } else {
            drawOverlayLegacy(context, age, renderCommands);
        }
        
    };

    this.init = async function (visualizerScriptDir, rootStyle, newImages) {
        showOutlineStartDate = null;

        self.rootStyle = rootStyle;
        self.visualizerScriptDir = visualizerScriptDir;
        
        images = newImages;
    }

    //method updated so it uses flat CSS variables array
    function getCssProperty(specificCssProperty, generalCssProperty, fallback) {
        if (self.rootStyle == null) return fallback;
        return self.rootStyle.find(s => s.key === specificCssProperty)?.value 
            || self.rootStyle.find(s => s.key === generalCssProperty)?.value 
            || fallback;
    }

    function drawOverlayLegacy(context, age, commandString) {
        const commandLines = commandString.split("\n");
        for (const commandLine of commandLines) {
            if (commandLine === "") continue;
            const tokens = commandLine.split(";");
            context.save();
            commands[tokens[0]](context, age, tokens);
            context.restore();
        }
        context.imageSmoothingEnabled = true;
    }

    function drawOverlayDeclarative(context, age, declarativeRenderData) {
        if (typeof declarativeRenderData === "string") {
            declarativeRenderData = JSON.parse(declarativeRenderData);
        }
        for (const widget of declarativeRenderData) {
            context.save();
            widgets[widget.type](context, age, widget);
            context.restore();
        }
    }

    function parseColor(tokens, i, alphaScale) {
        if (!alphaScale) alphaScale = 1;
        return {
            r: tokens[i + 0],
            g: tokens[i + 1],
            b: tokens[i + 2],
            a: tokens[i + 3] / 255 * alphaScale,
            toString() {
                return `rgba(${this.r}, ${this.g}, ${this.b}, ${this.a})`
            }
        }
    }

    // Custom rounding function
    const round = x => Math.max(Math.trunc(x), 1);

    const clamp01 = x => Math.min(Math.max(x, 0), 1);

    const easeOutExpo = t => 1 - Math.pow(2, -8 * t);

    const ageAlpha = (t) => 1 - clamp01(easeOutExpo(t / 3000));

    function parsePosition(tokens, i) {
        return {
            x: round(tokens[i]),
            y: round(tokens[i + 1])
        };
    }

    // https://stackoverflow.com/questions/11068240/what-is-the-most-efficient-way-to-parse-a-css-color-in-javascript
    function parseCssColor(input) {
        if (input.substr(0, 1) == "#") {
            var collen = (input.length - 1) / 3;
            var fact = [17, 1, 0.062272][collen - 1];
            return [
                Math.round(parseInt(input.substr(1, collen), 16) * fact),
                Math.round(parseInt(input.substr(1 + collen, collen), 16) * fact),
                Math.round(parseInt(input.substr(1 + 2 * collen, collen), 16) * fact)
            ];
        }
        else return input.split("(")[1].split(")")[0].split(",").map(x => +x);
    }

    function parseAgeAlpha(tokens, i, age) {
        const hasFadeTag = tokens[i] && tokens[i].split("-").some(e => e === "fade");
        if (hasFadeTag) return ageAlpha(age);
        return 1;
    }

    function roundedCornerPath(context, rect, cornerRadius, lines = true) {
        const radius = cornerRadius;
        const x = rect.x;
        const y = rect.y;
        const width = rect.width;
        const height = rect.height;
        context.beginPath();
        context.moveTo(x + radius, y);
        if (lines) {
            context.lineTo(x + width - radius, y);
        } else {
            context.moveTo(x + width - radius, y);
        }
        context.arcTo(x + width, y, x + width, y + radius, radius);
        if (lines) {
            context.lineTo(x + width, y + height - radius);
        } else {
            context.moveTo(x + width, y + height - radius);
        }
        context.arcTo(x + width, y + height, x + width - radius, y + height, radius);
        if (lines) {
            context.lineTo(x + radius, y + height);
        } else {
            context.moveTo(x + radius, y + height);
        }
        context.arcTo(x, y + height, x, y + height - radius, radius);
        if (lines) {
            context.lineTo(x, y + radius);
        } else {
            context.moveTo(x, y + radius);
        }
        context.arcTo(x, y, x + radius, y, radius);
    }


    const widgets = {
        legacy_commands: function (context, age, widget) {
            drawOverlayLegacy(context, age, widget.commands);
        },
        centered_face_mask: function (context, age, widget) {

            const hasProblem = widget.has_problem;
            const colors = {
                base_problem: getCssProperty("--problem-color-face-oval", "--problem-color", "#df3251"),
                base00: getCssProperty("--primary-color-face-oval", "--primary-color", "#3251DF"),
                base_contrast: getCssProperty("--contrast-color-face-oval", "--contrast-color", "#FFFFFF"),
                background_camera_overlay: getCssProperty("--camera-overlay-color-face-oval", "--camera-overlay-color", "rgba(0, 0, 0, 0.5)"),
            }

            const maxEllipseHeightPercent = getCssProperty(null, "--max-height-percent-face-oval", "0.65");
            const maxEllipseWidthPercent = getCssProperty(null, "--max-width-percent-face-oval", "0.75");

            const lineWidth = getCssProperty(null, "--line-width-face-oval", "3");

            const canvas = context.canvas
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
            context.lineWidth = lineWidth
            context.beginPath();
            context.ellipse(centerX, centerY, radiusX + lineWidth * 2, radiusY + lineWidth * 2, 0, 0, twoPi);
            context.stroke();


            if (hasProblem) {
                // Border problem
                context.strokeStyle = colors.base_problem;
                context.lineWidth = lineWidth
                context.beginPath();
                context.ellipse(centerX, centerY, radiusX, radiusY, 0, 0, twoPi);
                context.stroke();
            } else {
                // Border 2
                context.strokeStyle = colors.base00;
                context.lineWidth = lineWidth
                context.beginPath();
                context.ellipse(centerX, centerY, radiusX + lineWidth / 2, radiusY + lineWidth / 2, 0, 0, twoPi);
                context.stroke();
            }        
        },
        card_outline: function (context, age, widget) {
            if (!self.showOutlineStartDate) {
                self.showOutlineStartDate = Date.now();
            }

            const fadeInTimeMs = 350;
            let fadeAlpha = Math.min(1, (Date.now() - self.showOutlineStartDate) / fadeInTimeMs);

            const colors = {
                base00: getCssProperty("--primary-color-card-outline", "--primary-color", "#3251DF"),
                base_contrast: getCssProperty("--contrast-color-card-outline", "--contrast-color", "#FFFFFF"),
                background_camera_overlay: getCssProperty("--camera-overlay-color-card-outline", "--camera-overlay-color", "rgba(0, 0, 0, 0.5)"),
            }

            const lineWidth = getCssProperty(null, "--line-width-card-outline", "5");
            const cornerRadiusPercent = getCssProperty(null, "--corner-radius-percent-card-outline", "0.03");

            const canvas = context.canvas;

            const rect = widget.rect;
            const cornerRadius = Math.max(rect.width, rect.height) * cornerRadiusPercent;

            function getFadedColor(color) {
                if (fadeAlpha === 1) return color;
                const parsedColor = parseCssColor(color);
                if (parsedColor.length === 3) parsedColor.push(1);
                parsedColor[3] = parsedColor[3] * fadeAlpha;
                return `rgba(${parsedColor.join(",")})`
            }

            // Background
            context.fillStyle = getFadedColor(colors.background_camera_overlay);
            context.fillRect(0, 0, canvas.width, canvas.height);

            context.globalCompositeOperation = "destination-out";
            roundedCornerPath(context, rect, cornerRadius);
            context.fillStyle = getFadedColor(colors.base_contrast);

            context.fill();
            context.globalCompositeOperation = "source-over";


            // Actual outline
            roundedCornerPath(context, rect, cornerRadius);
            context.strokeStyle = getFadedColor(colors.base_contrast);
            context.lineWidth = lineWidth;
            context.stroke();
        },
        photo_outline: function (context, age, widget) {

            const colors = {
                base00: getCssProperty("--contrast-color-photo-outline", "--contrast-color", "#FFFFFF"),
            }

            const lineWidth = getCssProperty(null, "--line-width-photo-outline", "5");
            const cornerRadiusPercent = getCssProperty(null, "--corner-radius-percent-photo-outline", "0.03");

            context.strokeStyle = colors.base00;
            context.lineWidth = lineWidth;
            const cornerRadius = Math.max(widget.rect.width, widget.rect.height) * cornerRadiusPercent;
            roundedCornerPath(context, widget.rect, cornerRadius);
            context.stroke();
        },
        face_liveness_checkboxes: async function (context, age, widget) {
            // Controls the size of the checkboxes.
            const checkboxZoneWidthPercent = getCssProperty(null, "--checkbox-area-width-percent-face-liveness", "0.6");
            // Controls the vertical position of the checkboxes.
            const checkboxZoneDistanceFromTopPercent = getCssProperty(null, "--checkbox-area-distance-from-top-percent-face-liveness", "0.05");
            // Controls the size of the checkboxes and the separation between the checkboxes.
            const checkboxMarginPercent = getCssProperty(null, "--checkbox-margin-percent-face-liveness", "0.15");

            const canvas = context.canvas

            const regionWidth = Math.min(canvas.width, canvas.height) * checkboxZoneWidthPercent;
            const margin = (canvas.width - regionWidth) / 2;
            const top = canvas.height * checkboxZoneDistanceFromTopPercent;
            const checkboxWidth = Math.trunc(regionWidth / widget.totalCount);

            for (let i = 0; i < widget.totalCount; i++) {
                const tl = { x: margin + i * checkboxWidth, y: top };
                const m = Math.trunc(checkboxWidth * checkboxMarginPercent);
                const rect = {
                    x: tl.x + m,
                    y: tl.y + m,
                    width: checkboxWidth - m * 2,
                    height: checkboxWidth - m * 2
                }

                if (widget.failed && i === widget.passedCount) {
                    if (images.statusError) {
                        context.drawImage(images.statusError, rect.x, rect.y, rect.width, rect.height);
                    }
                } else if (i < widget.passedCount) {
                    if (images.statusSuccess) {
                        context.drawImage(images.statusSuccess, rect.x, rect.y, rect.width, rect.height);
                    }
                } else {
                    if (images.statusWaiting) {
                        context.drawImage(images.statusWaiting, rect.x, rect.y, rect.width, rect.height);
                    }
                }

            }

        },
    }

    const commands = {
        line(context, age, tokens) {
            const v1 = parsePosition(tokens, 1);
            const v2 = parsePosition(tokens, 3);
            context.beginPath();
            context.lineWidth = tokens[9];
            context.strokeStyle = parseColor(tokens, 5, parseAgeAlpha(tokens, 10, age));
            context.lineCap = "square";
            context.moveTo(v1.x, v1.y);
            context.lineTo(v2.x, v2.y);
            context.stroke();
        },
        rectangle(context, age, tokens) {
            const thickness = tokens[9];
            const color = parseColor(tokens, 5);
            if (thickness === "-1") {
                context.fillStyle = color.toString();
                context.fillRect(
                    round(tokens[1]),
                    round(tokens[2]),
                    round(tokens[3]),
                    round(tokens[4]));
            } else {
                context.lineWidth = thickness;
                context.strokeStyle = color.toString();
                context.strokeRect(
                    round(tokens[1]),
                    round(tokens[2]),
                    round(tokens[3]),
                    round(tokens[4]))
            }
        },
        point(context, age, tokens) {
            /*const location = parsePosition(tokens, 1);
            const color = parseColor(tokens, 3);
            const size = tokens[7];
            context.beginPath();
            context.fillStyle = color.toString();
            context.arc(location.x, location.y, size, 0, 2 * Math.PI);
            context.fill(); <-very slow! */
            
            const location = parsePosition(tokens, 1);
            const color = parseColor(tokens, 3);
            const size = tokens[7];
            context.fillStyle = color.toString();
            context.fillRect(location.x, location.y, size, size);
        },
        text(context, age, tokens) {
            if (!options.drawText) return;
            const text = tokens[1];
            const horizontalAlignment = tokens[4];
            const verticalAlignment = tokens[5];
            const location = parsePosition(tokens, 2);
            context.font = options.font;
            context.textAlign = horizontalAlignment;
            if (verticalAlignment === "center") {
                context.textBaseline = "middle"
            } else {
                context.textBaseline = verticalAlignment;
            }
            const color = parseColor(tokens, 6);
            context.fillStyle = color.toString();
            context.fillText(text, location.x, location.y);
            if (/* draw text outline */ true) {
                context.strokeStyle = "black";
                context.lineWidth = 1;
                context.strokeText(text, location.x, location.y);
            }
        },
        circle(context, age, tokens) {
            const center = parsePosition(tokens, 1);
            const radius = round(tokens[3]);
            const thickness = tokens[8];
            const color = parseColor(tokens, 4, parseAgeAlpha(tokens, 9, age));
            if (thickness === "-1") {
                context.beginPath();
                context.fillStyle = color.toString();
                context.arc(center.x, center.y, radius, 0, 2 * Math.PI);
                context.fill();
            } else {
                context.beginPath();
                context.strokeStyle = color.toString();
                context.lineWidth = thickness;
                context.arc(center.x, center.y, radius, 0, 2 * Math.PI);
                context.stroke();
            }
        },
        ellipse(context, age, tokens) {
            const center = parsePosition(tokens, 1);
            const radiusX = round(tokens[3]);
            const radiusY = round(tokens[4]);
            const rotation = tokens[5]; //radians
            const thickness = tokens[10];
            const color = parseColor(tokens, 6, parseAgeAlpha(tokens, 11, age));
            if (thickness === "-1") {
                context.beginPath();
                context.fillStyle = color.toString();
                context.ellipse(center.x, center.y, radiusX, radiusY, rotation, 0, 2 * Math.PI);
                context.fill();
            } else {
                context.beginPath();
                context.strokeStyle = color.toString();
                context.lineWidth = thickness;
                context.ellipse(center.x, center.y, radiusX, radiusY, rotation, 0, 2 * Math.PI);
                context.stroke();
            }
        },
        triangle(context, age, tokens) {
            const a = parsePosition(tokens, 1);
            const b = parsePosition(tokens, 3);
            const c = parsePosition(tokens, 5);
            const color = parseColor(tokens, 7);
            const thickness = tokens[11];
            if (thickness == "-1") {
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
                context.lineWidth = thickness;
                context.strokeStyle = color.toString();
                context.lineCap = "butt";
                context.moveTo(a.x, a.y);
                context.lineTo(b.x, b.y);
                context.lineTo(c.x, c.y);
                context.lineTo(a.x, a.y);
                context.stroke();
            }

        },
    };
}

function clearCanvas(param) {
    let context = null;
    if (param.clearRect) {
        context = param;
    } else if (param.getContext) {
        context = param.getContext("2d");
    } else {
        throw "param must be canvas or CanvasRenderingContext2D";
    }

    context.setTransform(1, 0, 0, 1, 0, 0);
    const canvas = context.canvas;
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.beginPath();
}
