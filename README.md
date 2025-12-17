<!--------------------------------------------------------------------------------- Description -->
# Forex Gui
    GUI for forex

<!--------------------------------------------------------------------------------- Install  -->
<br><br>

## Install

Get source  
```bash
git clone git@github.com:kashanimorteza/forex_gui.git
cd ./forex_gui
```

flutter pub get




<!--------------------------------------------------------------------------------- Install  -->
<br><br>

## Release

Release web
```bash
flutter build web --base-href /c9db34f6-24ea-4468-9746-fe17efc3b77d/
rsync -avz /Volumes/data/projects/forex_gui/build/web/* root@91.107.131.70:/var/www/forex_gui/
```

Release macos
```bash
flutter config --enable-macos-desktop
flutter build macos
```