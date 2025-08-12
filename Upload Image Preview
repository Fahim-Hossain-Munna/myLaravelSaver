#### Function/Method of Image Preview after upload

##### 1st pass
```
onchange = previewFile(event,previewID)
```


```
var previewFile = (event, previewID) => {
    var reader = new FileReader();
    var file = event.target.files[0];

    if (file.type == "application/pdf") {
        reader.onload = function () {
            var output = document.getElementById(previewID);
            output.src = "/assets/icons/pdf.png";
        };
        reader.readAsDataURL(file);
        return;
    }

    reader.onload = function () {
        var output = document.getElementById(previewID);
        output.src = reader.result;
    };
    reader.readAsDataURL(file);
};
```
