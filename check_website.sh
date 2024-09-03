#!/bin/bash

# Список вебсайтів для перевірки
websites=("https://google.com" "https://facebook.com" "https://twitter.com")

# Назва файлу логів
log_file="website_status.log"

# Очистка файлу логів перед початком
> "$log_file"

# Функція для перевірки доступності сайту
check_website() {
    local url=$1
    # Використовуємо curl для перевірки статусу сайту
    # -L для слідування переадресаціям
    # -s для тихого режиму (без виводу прогресу)
    # -o /dev/null для відкидання вмісту відповіді
    # -w "%{http_code}" для отримання лише HTTP статус-коду
    status=$(curl -L -s -o /dev/null -w "%{http_code}" "$url")
    
    if [ "$status" -eq 200 ]; then
        echo "$url is UP" >> "$log_file"
    else
        echo "$url is DOWN" >> "$log_file"
    fi
}

# Перевірка кожного сайту
for site in "${websites[@]}"; do
    check_website "$site"
done

echo "Результати перевірки записано у файл $log_file"
