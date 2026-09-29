# College Library

## Запуск

```bash
flutter pub get
flutter analyze
flutter run
```

## Карта маршрутів

| Шлях | Екран | Захист |
|---|---|---|
| `/catalog?genre=...` | CatalogScreen | — |
| `/catalog/book/:bookId` | BookScreen | — |
| `/catalog/book/:bookId/reserve` | ReserveScreen | потрібен вхід |
| `/my-books` | MyBooksScreen | — |
| `/profile` | ProfileScreen | — |
| `/login?from=...` | LoginScreen | — |
| `/date-picker` | ReturnDateScreen | — |

## Перевірка deep link

Android:

```bash
adb shell am start -a android.intent.action.VIEW -d "library://app/catalog/book/b01" com.example.collegelibrary
```

iOS Simulator:

```bash
xcrun simctl openurl booted "library://app/catalog/book/b01"
```
