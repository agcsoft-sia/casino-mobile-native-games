# Casino native games

## Подготовка игр

Игры провайдеров нужно подготовить перед импортом, названия архивов нужно переименовать в идентификаторы игр запроса v3/casino/game. В этом проект две папки с неподготовленныами играми habanero_dirty и pragmaticplay_dirty. Идентификаторы нужно взять из соответствующих таблиц habanero.csv и pragmatic.csv. Название архива с игрой является identifier2 в таблице. В итоге название архива должно равняться identifier (знак ":" будет заменен на "__").

1. запустить скрипт ./scripts/normalize_game_files.rb source_dir table.csv provider
    1. запустить скрипт ./scripts/normalize_game_files.rb pragmaticplay_dirty pragmatic.csv pragmaticplay
    2. запустить скрипт ./scripts/normalize_game_files.rb habanero_dirty habanero.csv habanero
2. перенести созданные директории pragmaticplay и habanero в директорию NativeGames (название директорий соответствует названию провайдера)

## Cоздание meta данных игры

После подготовки игр необходимо создать метаданные о провайдерах и играх 

1. запустить скрип ./scripts/make_games_meta.rb games_folder_name
    1. запустить скрипт ./scripts/make_games_meta.rb NativeGames
2. сгенерированный файл providers.json хранит данные о провайдерах
3. сгенерированный файл games.json хранит данные об играх 

## Импорт игр в проект

1. Запустить скрипт import_games.rb xcodepoj_name games_folder providers_meta games_meta
    1. ./scripts/import_games.rb HTTP5Games.xcodeproj NativeGames providers.json games.json

## Хранение и запуск ODR игры

1. Получить ORD архив, разархивировать в отдельную директорию
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

- ссылка на локальный сервер должна содержать http схему (http://127.0.0.1…)
- Habanero игры должны быть подготовлены, по инструкции провайдера необходимо выполнить скрипт build.js

