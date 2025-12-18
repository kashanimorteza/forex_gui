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
flutter build web --base-href /57b3e8ae-4aca-4776-9aa1-9ccce396dc6f
rsync -avz /Volumes/data/projects/forex_gui/build/web/* root@91.107.131.70:/var/www/forex_gui/
```

Release macos
```bash
flutter config --enable-macos-desktop
flutter build macos
```