# Vet app

This is a vet app developed by Bootfi.

## Create config files
Create `dev.json`, `prod.json` and `testing.json` using the `example_dev.json` structure.
*Then use this*
```
    flutter pub run build_runner --delete --output-conflicts
```
## Generate localizations
```
    flutter gen-l10n
```
## Add app icon for ios and android inside assets/images with the following names:
 - android_app_icon.png
 - ios_app_icon.png

 *Then use*
```dart
    flutter pub run flutter_launcher_icons:main
```

## Replace pull_to_refresh package
 Replace with our own code if there is no updates in the near future.