# Casino native games
## Хранение и запуск ODR игры

1. Архив с игрой добавить в бандл, и выставить тэг (например идентификатор игры, habanero:SGRainbowmania)
2. Получить ORD архив, разархивировать в отдельную директорию
3. Получить параметры сессии для игры
4. Запустить локальный сервер, указать директорию разархивированной игры и index файл
5. Передать в игру параметр сессии

## Получение и передача параметра сессии

1. Создать сессию игры через /api/casino/create-game-session
2. Из ответа запроса взять game_url
3. Применить к game_url url кодирование 
    1. https%3A%5C%2F%5C%2Fapp-a.insvr.com%5C%2Fgo.ashx%3Fbrandid%3D5785ac9a-8db7-ea11-96d2-281878588c2e%26ifrm%3D1%26keyname%3DSGRainbowmania%26lobbyurl%3Dhttps%253A%252F%252Fsvkzjv.com%252Fcasino%26locale%3Den%26mode%3DReal%26token%3D449bcc71-5c58-4833-9ebe-e042ae38c025%26
4. полученную закодированную урлу передать в параметре запуска локального файла игры

## Игры Habanero

На 20bet этот провайдер доступен под VPN Германия, например. 

ссылка на игры https://habanerosystems.com/article/habanero---device-pack-ios-bundle-pack-for-io-en

1. К урлу сессии нужно добавить параметр &devicepack=1 перед кодированием
2. полученную закодированную урлу передать в параметр startup локального файла игры
    1. https://127.0.0.1:8000/?startup=https%3A\%2F\%2Fapp-a.insvr.com\%2Fgo.ashx%3Fbrandid%3D5785ac9a-8db7-ea11-96d2-281878588c2e%26ifrm%3D1%26keyname%3DSGRainbowmania%26lobbyurl%3Dhttps%253A%252F%252Fsvkzjv.com%252Fcasino%26locale%3Den%26mode%3DReal%26token%3D449bcc71-5c58-4833-9ebe-e042ae38c025%2626devicepack%3D1

## Моменты

- ссылка на локальный сервер должна содержать http:// схему (http://127.0.0.1…)
- Habanero игры должны содержать папку Shared (по инструкции провайдера необходимо выполнить скрипт build.js, но можно вручную вносить папку в игры)
    - добавить папку HBShared архив как ODR файл, выставить тег (например habanero)
    - выполнить скрипт build_habanero.js перед архивацией игр, он заменит путь к директории HBShared в индексных файлах

