# androidArchitecture

- Reference docs for web: https://flutter.dev/docs/get-started/web
- Reference on how to write documentation: https://dart.dev/guides/language/effective-dart/documentation

# Setup
## git ignored files
- download google-services.json from firebase console and put in `android/app`
- write files `lib/secrets.dart` and `web/secrets.json` by hand following instructions in `index.html` and `FirebaseRepository.dart` (TODO move instructions to here)

## Firebase auth
Documentation for web: https://pub.dev/packages/google_sign_in_web
Go to https://console.developers.google.com/apis/credentials for configuration.
Be sure to match the localhost port you find over there in OAUTH 2.0 edit and when running debug builds 
- `flutter run -d chrome --web-hostname localhost --web-port 5000`

Then to actually sign in either open a fresh chrome window not launched by flutter 
   or
See more details at https://stackoverflow.com/questions/59480956/browser-or-app-may-not-be-secure-try-using-a-different-browser-error-with-fl

## Firebase firestore
https://firebase.google.com/docs/firestore/security/rules-structure

### Adding write privileges to /user table
 To add another admin to firebase,
- log in with the desired user
- head to https://console.firebase.google.com/
- go into /authentication/users
- find the 'User UUID' and copy it
- create new entry in db table users, where document id is 'User UUID' and field 'role' is 'admin'

This will match the following rules for firebase:
<code>
    match /section/{document=**}  {
      allow read: if true ;
      allow write: if get(/databases/$(database)/documents/user/$(request.auth.uid)).data.role == "admin";
</code>

# Run
## from Intellij or Android Studio
Make sure the flutter binaries are set to the beta channel: 
- open preferences/languages and frameworks/flutter
- `flutter packages pub run build_runner   watch` (remember to run it again every time you edit pubspec.yaml because it will drop automatically)
- pick `chrome (web)` from the device drop down
- hit run or debug and a new chrome window should open
- if pressing `ctrl+s` all files are immediately saved and a hot restart is triggered (you can also do that by pressing the floppy disk icon to save all). Note that if the IDE auto-saves all files it won't trigger a hot restart. Note also that this is an opt-in on the preferences/languagues and frameworks/flutter
- By default the hot reload shortcut is `ctrl+\`
 
### For allowing login with Google sign in
- drop down the `main.dart` run configuration
- on arguments add `--web-port 5000`
- instead of choosing `chrome (web)` choose `web server (web)`
- instead of hitting debug hit run (to be confirmed)

## from command line 
- `flutter packages pub run build_runner watch`
- `flutter run -d chrome --web-port 5000` where port 5000 was specified as authorized for google sign in on https://console.developers.google.com/apis/credentials/oauthclient/  then click on Credentials / OAUTH 2.0 client ids and then click edit.
- press `r` on console for hot reloading or `R` for hot restart

# Build and deploy
- `flutter build web`