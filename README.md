# androidArchitecture

- Reference docs for web: https://flutter.dev/docs/get-started/web
- Reference on how to write documentation: https://dart.dev/guides/language/effective-dart/documentation

# Run
## from Intellij or Android Studio
Make sure the flutter binaries are set to the beta channel: 
- open preferences/languages and frameworks/flutter
- `flutter packages pub run build_runner   watch` (remember to run it again every time you edit pubspec.yaml because it will drop automatically)
- pick `chrome (web)` from the device drop down
- hit run or debug and a new chrome window should open
- if pressing `ctrl+s` all files are immediately saved and a hot restart is triggered (you can also do that by pressing the floppy disk icon to save all). Note that if the IDE auto-saves all files it won't trigger a hot restart. Note also that this is an opt-in on the preferences/languagues and frameworks/flutter
- By default the hot reload shortcut is `ctrl+\`
 

## from command line 
- `flutter packages pub run build_runner watch`
- `flutter run -d chrome --web-port 5000` where port 5000 was specified as authorized for google sign in on https://console.developers.google.com/apis/credentials/oauthclient/  then click on Credentials / OAUTH 2.0 client ids and then click edit.
- press `r` on console for hot reloading or `R` for hot restart

# Build and deploy
- `flutter build web`