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
flutter build web --base-href /
rsync -avz /Volumes/data/projects/xray_gui/build/web/* root@91.99.220.194:/root/xray_gui/
```

Release macos
```bash
flutter config --enable-macos-desktop
flutter build macos
```