# 🚀 ডকার প্রজেক্টের জন্য গ্লোবাল MySQL ও phpMyAdmin সেটআপ নির্দেশিকা

---

## 📌 গ্লোবাল সার্ভিস ও ক্রেডেনশিয়ালস সারসংক্ষেপ

- **phpMyAdmin Web UI**: [http://localhost:8085](http://localhost:8085)
- **পিসি হোস্টের জন্য MySQL Host**: `127.0.0.1` অথবা `localhost` (Port: `3306`)
- **ডকার কনটেইনারের ভেতরে MySQL Host**: `global-mysql` (Port: `3306`)
- **ডাটাবেজ ইউজারনেম (Username)**: `root`
- **ডাটাবেজ পাসওয়ার্ড (Password)**: `password`
- **ডকার শেয়ার্ড নেটওয়ার্কের নাম**: `global_services_network`
- **গ্লোবাল সার্ভিস ফোল্ডার লোকেশন**: `D:\Pippa Projects\global-services`

---

## ⚙️ নতুন যেকোনো ডকার প্রজেক্টকে গ্লোবাল MySQL-এর সাথে কানেক্ট করার উপায়

### ধাপ ১: নতুন প্রজেক্টের `.env` ফাইল আপডেট করুন

আপনার নতুন প্রজেক্টের `.env` ফাইলে (যেমন: `backend/.env` বা মূল `.env`) ডাটাবেজ কানেকশন এভাবে সেট করুন:

```env
DB_CONNECTION=mysql
DB_HOST=global-mysql
DB_PORT=3306
DB_DATABASE=your_new_project_db_name
DB_USERNAME=root
DB_PASSWORD=password
```

---

### ধাপ ২: নতুন প্রজেক্টের `docker-compose.yml` ফাইল আপডেট করুন

আপনার প্রজেক্টের `docker-compose.yml` ফাইলে **২টি জায়গায়** পরিবর্তন করুন:

#### ক) অ্যাপ বা ব্যাকএন্ড সার্ভিসের সাথে `global-services-net` নেটওয়ার্ক যুক্ত করুন:

```yaml
services:
  backend: # আপনার ব্যাকএন্ড বা অ্যাপ কনটেইনারের নাম
    # ...
    env_file:
      - .env
    networks:
      - app-network         # প্রজেক্টের নিজস্ব নেটওয়ার্ক (ঐচ্ছিক)
      - global-services-net # 👈 গ্লোবাল ডাটাবেজ নেটওয়ার্ক কানেক্ট করুন
```

> **⚠️ গুরুত্বপূর্ণ বিষয়**:
> `docker-compose.yml` ফাইলের `environment:` ব্লকে যেন `DB_HOST: mysql` এর মতো কোনো কিছু হার্ডকোড করা **না থাকে**। হার্ডকোড করা থাকলে ডকার `.env` ফাইলের `DB_HOST=global-mysql` পড়তে পারবে না। প্রজেক্টের নিজস্ব যেকোনো `mysql` কনটেইনার ডিলিট করে দিতে পারেন।

#### খ) `docker-compose.yml` ফাইলের নিচে এক্সটার্নাল নেটওয়ার্ক ডিক্লেয়ার করুন:

```yaml
networks:
  app-network:
    driver: bridge
  global-services-net:    # 👈 এই এক্সটার্নাল নেটওয়ার্ক অংশটুকু যুক্ত করুন
    external: true
    name: global_services_network
```

---

### ধাপ ৩: ডাটাবেজ তৈরি এবং মাইগ্রেশন কমান্ড

১. **phpMyAdmin এ ডাটাবেজ তৈরি করুন**:
   - ব্রাউজারে **[http://localhost:8085](http://localhost:8085)** ওপেন করুন।
   - ইউজারনেম `root` এবং পাসওয়ার্ড `password` দিয়ে প্রবেশ করুন।
   - **Databases** ট্যাবে গিয়ে আপনার প্রজেক্টের নামের সাথে মিলিয়ে নতুন ডাটাবেজ (যেমন: `your_new_project_db_name`) তৈরি করুন।

২. **কনটেইনার রান ও মাইগ্রেশন চালু করুন**:
   ```bash
   # প্রজেক্ট কনটেইনার চালুকরণ
   docker compose up -d

   # ডাটাবেজ মাইগ্রেশন রানকরণ
   docker compose exec backend php artisan migrate
   ```

---

## 💡 বিকল্প উপায়: `host.docker.internal` দিয়ে কানেক্ট করা

যদি `docker-compose.yml` এ এক্সটার্নাল নেটওয়ার্ক যোগ করতে না চান:

১. **`.env` ফাইলে লিখবেন**:
   ```env
   DB_HOST=host.docker.internal
   DB_PORT=3306
   DB_DATABASE=your_new_project_db_name
   DB_USERNAME=root
   DB_PASSWORD=password
   ```

২. **`docker-compose.yml` এ ব্যাকএন্ড সার্ভিসের নিচে যুক্ত করবেন**:
   ```yaml
   services:
     backend:
       # ...
       extra_hosts:
         - "host.docker.internal:host-gateway"
   ```

---

## 💡 পিসিতে সরাসরি চলা অ্যাপগুলোর জন্য (Non-Docker Apps)

যদি পিসির টার্মিনালে সরাসরি `php artisan serve` বা Node/Python অ্যাপ চালান:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_new_project_db_name
DB_USERNAME=root
DB_PASSWORD=password
```

---

## 🛠️ গ্লোবাল সার্ভিস বন্ধ ও চালু করার নিয়ম

ফোল্ডার লোকেশন: `D:\Pippa Projects\global-services\`

- **সার্ভিস স্টার্ট করতে**: `start.bat` ফাইলে ডাবল ক্লিক করুন অথবা `docker compose up -d` চালান।
- **সার্ভিস স্টপ করতে**: `stop.bat` ফাইলে ডাবল ক্লিক করুন অথবা `docker compose stop` চালান।
- **স্ট্যাটাস দেখতে**: `status.bat` ফাইলে ডাবল ক্লিক করুন অথবা `docker compose ps` চালান।
