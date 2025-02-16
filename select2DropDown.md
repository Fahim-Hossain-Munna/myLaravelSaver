###1st step 

```
<div class="modal fade" id="createCity" style="overflow: hidden"> // modal parent div contimize (add overflow hidden(optional))
```

###2nd step

```
$(document).ready(function() {
            $('.select2Modal').select2({
                dropdownParent: $('#createCity .modal-content')
            });
});
```

---
**NOTE**

This code works when the Select2 search is not working inside a Bootstrap modal.

---
