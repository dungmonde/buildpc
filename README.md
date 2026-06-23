
## Giới thiệu
Website xây dựng cấu hình PC theo nhu cầu.

## Công nghệ sử dụng
- Backend: Laravel
- Frontend: React
- Style: Tailwind CSS

## Chức năng chính
- Chọn linh kiện theo nhu cầu
- Lọc cấu hình phù hợp
- Hiển thị giá và tương thích

## Cài đặt
```bash
git clone https://github.com/dungmonde/Shopping-Website.git
cd buildpc
composer install
cp .env.example .env
php artisan key:generate
php artisan serve

Nhập Gemini api key vào cuối file env. để sử dụng tính năng AI (biến GEMINI_API_KEY)