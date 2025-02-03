### Function Call

```
let svgImages = document.querySelectorAll(".chapter-title.active img"); // if active class then action will start
changeSvgImageColor(svgImages, "#F8B91B");
```


### Function Declaration

```
        function changeSvgImageColor(svgImages, svgColor, defaultColor = "#4F4F4F") {
            svgImages.forEach(function(svgImage) {
                var svgPath = svgImage.getAttribute("src");
                var xhr = new XMLHttpRequest();

                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var svgContent = xhr.responseText;

                        const strokeRegex = new RegExp(`stroke="${defaultColor}"`, 'g');
                        const fillRegex = new RegExp(`fill="${defaultColor}"`, 'g');

                        svgContent = svgContent.replace(strokeRegex, `stroke="${svgColor}"`);
                        svgContent = svgContent.replace(fillRegex, `fill="${svgColor}"`);

                        svgImage.src = "data:image/svg+xml;charset=utf-8," + encodeURIComponent(svgContent);
                    }
                };
                xhr.open("GET", svgPath, true);
                xhr.send();
            });
        }
```
