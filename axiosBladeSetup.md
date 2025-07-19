# 🔐 Laravel + Axios: Dynamic CSRF Token Setup

This guide shows how to configure **Axios** in a Laravel project using a **dynamic CSRF token** to securely make AJAX requests. It ensures Laravel's CSRF protection works seamlessly with frontend JavaScript.

---

## 📦 Technologies Used

- Laravel (Blade templating)
- Axios (JavaScript HTTP client)
- HTML5 & JavaScript (Vanilla)
- Laravel’s built-in CSRF protection

---

## 🚀 Getting Started

### 1. Include Axios in Your Laravel Project

Download the Axios library and place it in your Laravel public directory:

```
public/assets/scripts/axios.min.js
```

You can get the Axios minified file from:

👉 https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js

Then include it in your Blade layout file (usually layouts/app.blade.php or similar):
```
<script src="{{ asset('assets/scripts/axios.min.js') }}"></script>
```

### 2. Add the CSRF Token to Your Blade File
Include the CSRF meta tag in the <head> of your main layout file:
```
<meta name="csrf-token" content="{{ csrf_token() }}">
```

### 3. Configure Axios to Use CSRF Token
Right after loading Axios, configure it with the CSRF token and X-Requested-With header:
```
<script>
    axios.defaults.headers.common['X-CSRF-TOKEN'] = document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute('content');

    axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
</script>
```

---
## Final Structure
Here’s what the final setup looks like in your layout file:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Laravel Axios CSRF</title>
    <script src="{{ asset('assets/scripts/axios.min.js') }}"></script>
</head>
<body>

    {{-- Your HTML content --}}

    <script>
        axios.defaults.headers.common['X-CSRF-TOKEN'] = document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute('content');
        axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
    </script>
</body>
</html>
```

### Example Usage
You can now send secure POST requests like this:
```
axios.post('/api/submit', {
    name: 'Fahim Hossain Munna',
    email: 'fahim@example.com'
})
.then(response => {
    console.log(response.data);
})
.catch(error => {
    console.error(error.response);
});
```

---

## Author

Fahim Hossain Munna
Full Stack Developer @ Razinsoft Ltd
Instructor @ Creative IT Institute
Studying CSE @ Habibullah Bahar University (NU)


