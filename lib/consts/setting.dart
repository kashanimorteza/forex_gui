// lib/consts/setting.dart

//----------------------------------------------- [ Description ]
// Const about setting are here

//----------------------------------------------- [ Import ]
import 'package:mkpanel_gui/consts/general.dart';
import 'package:mkpanel_gui/tools/drawer.dart';

//----------------------------------------------- [ Map ]
Map<dynamic, dynamic> const_setting = {
  //----------MAC
  OSLists.mac: {
    DeviceLists.desktop: {
      SettingLists.theme: 'desktop_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.tablet: {
      SettingLists.theme: 'tablet_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.mobile: {
      SettingLists.theme: 'mobile_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
  },
  //----------Linux
  OSLists.linux: {
    DeviceLists.desktop: {
      SettingLists.theme: 'desktop_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.tablet: {
      SettingLists.theme: 'tablet_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.mobile: {
      SettingLists.theme: 'mobile_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
  },
  //----------Windows
  OSLists.windows: {
    DeviceLists.desktop: {
      SettingLists.theme: 'desktop_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.tablet: {
      SettingLists.theme: 'tablet_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.mobile: {
      SettingLists.theme: 'mobile_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
  },
  //----------Chrome
  OSLists.chrome: {
    DeviceLists.desktop: {
      SettingLists.theme: 'desktop_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.tablet: {
      SettingLists.theme: 'tablet_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.mobile: {
      SettingLists.theme: 'mobile_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
  },
  //----------IOS
  OSLists.ios: {
    DeviceLists.desktop: {
      SettingLists.theme: 'desktop_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.tablet: {
      SettingLists.theme: 'tablet_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.mobile: {
      SettingLists.theme: 'mobile_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
  },
  //----------Android
  OSLists.android: {
    DeviceLists.desktop: {
      SettingLists.theme: 'desktop_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.tablet: {
      SettingLists.theme: 'tablet_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.mobile: {
      SettingLists.theme: 'mobile_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
  },
  //----------Web
  OSLists.web: {
    DeviceLists.desktop: {
      SettingLists.theme: 'desktop_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.tablet: {
      SettingLists.theme: 'tablet_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
    DeviceLists.mobile: {
      SettingLists.theme: 'mobile_theme',
      SettingLists.drawer: DrawerDesktop(),
    },
  },
};
