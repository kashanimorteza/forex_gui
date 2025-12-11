//--------------------------------------------------------------------------------- [location]
// lib/tools/tools.dart

//--------------------------------------------------------------------------------- [Description]
// Basic meythods

//--------------------------------------------------------------------------------- [Import]
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mkpanel_gui/consts/general.dart';

//--------------------------------------------------------------------------------- [Methods]
//--------------------[bytesToMegabytes]
String formatBytes(int bytes) {
  if (bytes == 0) return "0";

  if (bytes < 1024 * 1024) {
    double kb = bytes / 1024;
    return "${kb.toStringAsFixed(1)}K";
  }

  if (bytes < 1024 * 1024 * 1024) {
    double mb = bytes / (1024 * 1024);
    return "${mb.toStringAsFixed(1)}M";
  }

  double gb = bytes / (1024 * 1024 * 1024);
  return "${gb.toStringAsFixed(1)}G";
}

//--------------------[GetOS]
OSLists GetOS() {
  OSLists os = OSLists.mac;
  if (kIsWeb) {
    os = OSLists.chrome;
  } else {
    if (Platform.isMacOS) {
      os = OSLists.mac;
    } else if (Platform.isLinux) {
      os = OSLists.linux;
    } else if (Platform.isWindows) {
      os = OSLists.windows;
    } else if (Platform.isFuchsia) {
      os = OSLists.chrome;
    } else if (Platform.isIOS) {
      os = OSLists.ios;
    } else if (Platform.isAndroid) {
      os = OSLists.android;
    }
  }
  return os;
}

//--------------------[GetDevice]
DeviceLists GetDevice(context) {
  DeviceLists device = DeviceLists.desktop;
  double maxWidth = MediaQuery.of(context).size.width;

  if (maxWidth < 600) {
    device = DeviceLists.mobile;
  } else if (maxWidth >= 600 && maxWidth < 1200) {
    device = DeviceLists.tablet;
  } else {
    device = DeviceLists.desktop;
  }

  return device;
}

//--------------------------------------------------------------------------------- [Text]
//--------------------------------[build_text_1]
Widget build_text_1({String title = 'Text', Color color = Colors.blue, FontWeight fontWeight = FontWeight.bold}) {
  return Text(title, style: TextStyle(color: color, fontWeight: fontWeight));
}

//--------------------------------------------------------------------------------- [AppBar]
//--------------------------------[build_waite_1]
AppBar build_appbar_1({
  String title = 'AppBar',
  Color backgroundColor = Colors.blue,
  Color foregroundColor = Colors.white,
}) {
  return AppBar(
    title: Text(title),
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
  );
}

//--------------------[generate_AppBar]
AppBar generate_AppBar(String title, Color backgroundColor, Color foregroundColor) {
  AppBar obj = AppBar(
    title: Text(title),
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
  );
  return obj;
}

//--------------------------------------------------------------------------------- [FloatingActionButton]
//--------------------------------[build_btn_FloatingActionButton_1]
FloatingActionButton build_btn_FloatingActionButton_1(context, const_btn_models model, VoidCallback onPressed) {
  Icon buttonIcon;

  switch (model) {
    case const_btn_models.add:
      buttonIcon = const Icon(Icons.add);
      break;
    case const_btn_models.edit:
      buttonIcon = const Icon(Icons.edit);
      break;
    case const_btn_models.delete:
      buttonIcon = const Icon(Icons.delete);
      break;
    default:
      buttonIcon = const Icon(Icons.help);
  }

  return FloatingActionButton(
    backgroundColor: Colors.green,
    onPressed: onPressed,
    child: buttonIcon,
  );
}

//--------------------------------[build_waite_1]
FloatingActionButton generate_btn_FloatingActionButton(context, const_btn_models model, VoidCallback onPressed) {
  Icon buttonIcon;

  switch (model) {
    case const_btn_models.add:
      buttonIcon = const Icon(Icons.add);
      break;
    case const_btn_models.edit:
      buttonIcon = const Icon(Icons.edit);
      break;
    case const_btn_models.delete:
      buttonIcon = const Icon(Icons.delete);
      break;
    default:
      buttonIcon = const Icon(Icons.help); // Default icon if the model doesn't match known types
  }

  return FloatingActionButton(
    onPressed: onPressed,
    child: buttonIcon,
  );
}

//--------------------------------------------------------------------------------- [Text Field]
//--------------------[build_text_field_1]
Widget build_text_field_1({
  required String lable,
  required TextEditingController controller,
  double? with_size = 120,
  double? hight_size = 40,
}) {
  return SizedBox(
    width: with_size,
    height: hight_size,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: lable,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}

//--------------------[buildTextField]
Widget buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
  );
}

//--------------------[buildDataRows1]
List<DataRow> buildDataRows1(Map<String, dynamic> data) {
  return data.entries.map((entry) {
    return DataRow(
      cells: [
        DataCell(Text(entry.key)),
        DataCell(Text(entry.value.toString())),
      ],
    );
  }).toList();
}

//--------------------[buildDataRows]
List<DataRow> buildDataRows(Map<String, dynamic> data) {
  return data.entries.map((entry) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            entry.key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blueGrey[800],
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              entry.value.toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }).toList();
}

//--------------------------------------------------------------------------------- [Waite]
//--------------------------------[build_waite_1]
Widget build_waite_1() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

//--------------------------------------------------------------------------------- [Notification]
//--------------------------------[bul_not_1]
void bul_not_1(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error : Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(message),
        ],
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: Duration(seconds: isError ? 3 : 2),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

//--------------------------------[build_notification_2]
void build_notification_2(BuildContext context, data) {
  data['status'] ? bul_not_1(context, data['data'].toString(), isError: false) : bul_not_1(context, data['data'].toString(), isError: true);
}

//--------------------------------------------------------------------------------- [UI]
//--------------------------------[build_Row_1]
Widget build_Row_1({
  required String lable,
  required dynamic controller,
  double size_lable = 150,
}) {
  return Container(
    child: Row(
      children: [
        Container(width: size_lable, child: Text(lable, style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
          child: switch (controller) {
            ValueNotifier<bool>() => ValueListenableBuilder<bool>(
                valueListenable: controller,
                builder: (context, value, _) => Align(alignment: Alignment.centerLeft, child: Switch(value: value, onChanged: (bool newValue) => controller.value = newValue)),
              ),
            ValueNotifier<int>() => ValueListenableBuilder<int>(
                valueListenable: controller,
                builder: (context, value, _) => TextField(controller: TextEditingController(text: value.toString()), onChanged: (val) => controller.value = int.tryParse(val) ?? 0),
              ),
            _ => SizedBox(child: TextField(controller: controller)),
          },
        ),
      ],
    ),
  );
}

//--------------------------------[build_Row_2]
Widget build_Row_2(String label, String? value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 100,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Text(
          value ?? 'N/A',
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    ],
  );
}

//--------------------------------[build_Row_3] :
Widget build_Row_3(String label, dynamic controller) {
  return Container(
    child: switch (controller) {
      ValueNotifier<bool>() => ValueListenableBuilder<bool>(
          valueListenable: controller,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Text(value ? 'On' : 'Off', style: TextStyle(color: value ? Colors.green : Colors.grey, fontSize: 14.0)),
                    SizedBox(width: const_widget_padding),
                    Switch(value: value, onChanged: (bool newValue) => controller.value = newValue),
                  ],
                ),
              ],
            );
          },
        ),
      ValueNotifier<int>() => ValueListenableBuilder<int>(
          valueListenable: controller,
          builder: (context, value, _) {
            return TextField(
              controller: TextEditingController(text: value.toString()),
              decoration: InputDecoration(labelText: label),
              keyboardType: TextInputType.number,
              onChanged: (val) => controller.value = int.tryParse(val) ?? 0,
            );
          },
        ),
      TextEditingController() => TextField(controller: controller, decoration: InputDecoration(labelText: label)),
      _ => const SizedBox(), // Default case for unhandled controller types
    },
  );
}

// This is good for add items
Widget build_Row_33(String label, dynamic controller) {
  return Container(
    child: switch (controller) {
      ValueNotifier<bool>() => ValueListenableBuilder<bool>(
          valueListenable: controller,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Text(value ? 'On' : 'Off', style: TextStyle(color: value ? Colors.green : Colors.grey, fontSize: 14.0)),
                    SizedBox(width: const_widget_padding),
                    Switch(value: value, onChanged: (bool newValue) => controller.value = newValue),
                  ],
                ),
              ],
            );
          },
        ),
      TextEditingController() => TextField(controller: controller, decoration: InputDecoration(labelText: label)),
      _ => const SizedBox(), // Default case for unhandled controller types
    },
  );
}

//--------------------------------------------------------------------------------- [Button]
//--------------------------------[build_btn_1] : General button
Widget build_btn_1({
  String lable = 'Run',
  Function()? action,
  Color color_text = Colors.white,
  Color color_background = Colors.blue,
  double? padding_horizontal = 15,
  double? padding_vertical = 15,
  double? border_adius = 8,
  double? with_size = 0,
  double? hight_size = 0,
}) {
  return ElevatedButton(
    child: Text(lable, style: TextStyle(color: color_text)),
    onPressed: action,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(with_size!, hight_size!),
      backgroundColor: color_background,
      padding: EdgeInsets.symmetric(horizontal: padding_horizontal!, vertical: padding_vertical!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(border_adius!)),
    ),
  );
}

//--------------------------------[build_btn_2] : General button 2
Widget build_btn_2<T>({
  String lable = 'Run',
  void Function(T)? action,
  Color color_text = Colors.white,
  Color color_background = Colors.blue,
  double? padding_horizontal = 15,
  double? padding_vertical = 15,
  double? border_adius = 8,
  double? with_size = 0,
  double? hight_size = 0,
  T? value, // Add value parameter
}) {
  return ElevatedButton(
    child: Text(lable, style: TextStyle(color: color_text)),
    onPressed: action != null ? () => action(value!) : null, // Call action with value
    style: ElevatedButton.styleFrom(
      minimumSize: Size(with_size!, hight_size!),
      backgroundColor: color_background,
      padding: EdgeInsets.symmetric(horizontal: padding_horizontal!, vertical: padding_vertical!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(border_adius!)),
    ),
  );
}

//--------------------------------------------------------------------------------- [Icon]
//--------------------------------[build_icon_1]
Icon build_icon_1({bool isAccepted = false, double size = 25}) {
  return Icon(
    isAccepted ? Icons.check_circle : Icons.cancel,
    color: isAccepted ? Colors.green : Colors.red,
    size: size,
  );
}

//--------------------------------------------------------------------------------- [Header]
//--------------------------------[build_header_1]
Widget build_header_1({
  String text = 'Header',
  Color backgroundColor = Colors.green,
  Color textColor = Colors.white,
  double paddingTop = 5,
  double paddingBottom = 5,
  double marginTop = 5,
  double marginBottom = 5,
}) {
  return Container(
    color: backgroundColor,
    margin: EdgeInsets.only(
      top: marginTop,
      bottom: marginBottom,
    ),
    padding: EdgeInsets.only(
      top: paddingTop,
      bottom: paddingBottom,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ],
    ),
  );
}

//--------------------------------[build_header_2]
Widget build_header_2({
  String title = 'Header',
  Color backgroundColor = Colors.green,
  Color textColor = Colors.white,
  double paddingTop = 5,
  double paddingBottom = 5,
  double marginTop = 5,
  double marginBottom = 5,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
    child: Center(child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor))),
  );
}

//--------------------------------[build_header_2]
//Header with add button
Widget build_header_3({
  String title = 'Header',
  Color backgroundColor = Colors.green,
  Color textColor = Colors.white,
  double paddingTop = 5,
  double paddingBottom = 5,
  double marginTop = 5,
  double marginBottom = 5,
  Widget? leftButton, // New parameter for the button
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
    child: Row(
      children: [
        if (leftButton != null) leftButton,
        Expanded(
          child: Center(child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor))),
        ),
      ],
    ),
  );
}

//--------------------------------------------------------------------------------- [Icon_Button]
//--------------------------------[build_icon_btn_1]
Widget build_icon_btn_1({
  required const_btn_models model,
  required onPressed,
  String? type = 'background',
  Color backColor = Colors.green,
  Color iconColor = Colors.white,
  double size = 25,
  double borderRadius = 20,
}) {
  Icon icon;
  switch (model) {
    case const_btn_models.add:
      icon = Icon(Icons.add, color: iconColor, size: size);
      break;
    case const_btn_models.edit:
      icon = Icon(Icons.edit, color: iconColor, size: size);
      break;
    case const_btn_models.delete:
      icon = Icon(Icons.delete, color: iconColor, size: size);
      break;
    case const_btn_models.save:
      icon = Icon(Icons.save, color: iconColor, size: size);
      break;
    case const_btn_models.refresh:
      icon = Icon(Icons.refresh, color: iconColor, size: size);
      break;
    case const_btn_models.clear:
      icon = Icon(Icons.clear, color: iconColor, size: size);
      break;
    default:
      icon = Icon(Icons.help, color: iconColor, size: size);
  }

  if (type == "simple") {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
    );
  } else {
    return Container(
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}

//--------------------------------------------------------------------------------- [Action]
//--------------------------------[build_action_1]
Widget build_action_1({required onUpdate(value), required onDelete(value), required var value}) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => onUpdate(value),
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(value),
      ),
    ],
  );
}

//--------------------------------------------------------------------------------- [DropDown:ist]
//--------------------------------[bul_drp_list]
//Good for reload list
Widget bul_drp_list<T>({
  required String lable,
  required List<T> data,
  required Function(int) onChange,
  int? selected_id = 1,
}) {
  return DropdownButtonFormField<int>(
    initialValue: selected_id,
    items: data.map<DropdownMenuItem<int>>((T item) {
      item = (item as dynamic);
      return DropdownMenuItem<int>(value: (item as dynamic).id ?? 0, child: Text((item as dynamic).name, style: TextStyle(fontSize: 14)));
    }).toList(),
    onChanged: (int? newValue) => newValue != null ? onChange(newValue) : null,
    decoration: InputDecoration(
      labelText: lable,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400)),
      filled: true,
      fillColor: Colors.white,
    ),
    isExpanded: true,
  );
}

//--------------------------------[build_dropdownlist_1]
Widget build_dropdownlist_1<T>({
  required Function(int) onChange,
  required List<T> data,
  required int selected_id,
  required int Function(T) getId,
  required String Function(T) getName,
  double height = 30,
  double width = 110,
}) {
  return Container(
    height: height,
    width: width,
    child: FutureBuilder<List<T>>(
      future: Future.value(data),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<int>(
            initialValue: selected_id,
            items: data.map<DropdownMenuItem<int>>((T item) {
              return DropdownMenuItem<int>(value: getId(item), child: Text(getName(item), style: TextStyle(fontSize: 14)));
            }).toList(),
            onChanged: (int? newValue) {
              if (newValue != null) {
                onChange(newValue);
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400)),
              filled: true,
              fillColor: Colors.white,
            ),
            isExpanded: true,
          );
        } else if (snapshot.hasError) {
          return Container(
            height: 40,
            decoration: BoxDecoration(border: Border.all(color: Colors.red.shade300), borderRadius: BorderRadius.circular(4)),
            child: Center(child: Text('Error loading data', style: TextStyle(color: Colors.red))),
          );
        }
        return Container(
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
        );
      },
    ),
  );
}

//--------------------------------[build_dropdownlist_2] : good for const and enum without id
Widget build_dropdownlist_2<T>({
  required List<T> data,
  required Function(T) onChange,
  required T selected_type,
  double? width_size = 100,
  double? height_size = 40,
}) {
  return SizedBox(
    height: height_size,
    width: width_size,
    child: FutureBuilder<List<T>>(
      future: Future.value(data),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<T>(
            initialValue: (selected_type as dynamic),
            items: data.map<DropdownMenuItem<T>>((T item) {
              return DropdownMenuItem<T>(value: item, child: Text(item.toString().split('.').last));
            }).toList(),
            onChanged: (T? newValue) {
              if (newValue != null) {
                onChange(newValue);
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400)),
              filled: true,
              fillColor: Colors.white,
            ),
            isExpanded: true,
          );
        } else if (snapshot.hasError) {
          return Container(
            height: 40,
            decoration: BoxDecoration(border: Border.all(color: Colors.red.shade300), borderRadius: BorderRadius.circular(4)),
            child: Center(child: Text('Error loading data', style: TextStyle(color: Colors.red))),
          );
        }
        return Container(
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
        );
      },
    ),
  );
}

//--------------------------------[build_dropdownlist_1] : good for data that has name and id
Widget build_dropdownlist_3<T>({
  required String lable,
  required List<T> data,
  required ValueNotifier controller,
  int? selected_id = 1,
  Function(ValueNotifier)? onChange,
}) {
  controller.value = selected_id;
  return DropdownButtonFormField<int>(
    initialValue: selected_id,
    items: data.map<DropdownMenuItem<int>>((T item) {
      item = (item as dynamic);
      return DropdownMenuItem<int>(value: (item as dynamic).id, child: Text((item as dynamic).name, style: TextStyle(fontSize: 14)));
    }).toList(),
    onChanged: (int? newValue) => {controller.value = newValue, if (onChange != null) onChange(controller.value)},
    decoration: InputDecoration(
      labelText: lable,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400)),
      filled: true,
      fillColor: Colors.white,
    ),
    isExpanded: true,
  );
}

//--------------------------------[build_dropdownlist_4] :
//good for const and enum without id
Widget build_dropdownlist_4<T>({
  required String lable,
  required List<T> data,
  required ValueNotifier controller,
  required T selected_type,
  double? width_size = 100,
  double? height_size = 40,
}) {
  return DropdownButtonFormField<T>(
    initialValue: (selected_type as dynamic),
    items: data.map<DropdownMenuItem<T>>((T item) {
      return DropdownMenuItem<T>(value: item, child: Text(item.toString().split('.').last));
    }).toList(),
    onChanged: (T? newValue) => controller.value = newValue,
    decoration: InputDecoration(
      labelText: lable,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400)),
      filled: true,
      fillColor: Colors.white,
    ),
    isExpanded: true,
  );
}

//--------------------------------------------------------------------------------- [Complete]
//--------------------------------[build_base_a] :
Scaffold build_base_1({
  required dynamic appbar,
  required dynamic drawer,
  required dynamic body,
}) {
  SingleChildScrollView b = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(child: body),
    ),
  );
  return Scaffold(appBar: appbar, drawer: drawer, body: b);
}

//--------------------------------[bul_list_list] : Get list and return List
Widget bul_list_list<T_base>({
  required BuildContext context,
  required String title,
  required List<String> data_base,
  required Function(List<String>) action,
  Map<String, dynamic>? fields = const {},
}) {
  final TextEditingController textController = TextEditingController();

  //-----[Add]
  void add() {
    textController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Item'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    data_base = List.from(data_base)..add(textController.text);
                    action(data_base);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add')),
          ],
        );
      },
    );
  }

  //-----[Edit]
  void edit(String item) {
    textController.text = item;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    data_base = List.from(data_base);
                    int index = data_base.indexOf(item);
                    if (index != -1) data_base[index] = textController.text;
                    action(data_base);
                    Navigator.pop(context);
                  }
                },
                child: Text('Update')),
          ],
        );
      },
    );
  }

  //-----[Delete]
  void delete(String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Are you sure you want to delete $item?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  data_base = List.from(data_base)..remove(item);
                  action(data_base);
                  Navigator.pop(context);
                },
                child: Text('Delete')),
          ],
        );
      },
    );
  }

  //-----[return]
  return IntrinsicWidth(
    child: Card(
      child: Column(
        children: [
          //----------Title
          build_header_3(title: title, leftButton: build_icon_btn_1(onPressed: add, model: const_btn_models.add)),
          //----------Data Table
          DataTable(
            columns: [
              DataColumn(label: build_text_1(title: title)),
              DataColumn(label: build_text_1(title: 'Action')),
            ],
            rows: data_base.map((item) {
              return DataRow(
                cells: [
                  build_datacell_1(value: item),
                  DataCell(build_action_1(onUpdate: (val) => edit(item), onDelete: (val) => delete(item), value: item)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

//--------------------------------[bul_list_model] : get models and return model with (add / edit / delete)
Widget bul_list_model<T_base>({
  required BuildContext context,
  required String title,
  required T_base model_base,
  required List<T_base> data_base,
  required Function(String, T_base) action,
  Map<String, dynamic>? fields = const {},
}) {
  var items = null;
  var model = (model_base as dynamic);

//-----[Add]
  void add() {
    if (fields != null) items = fields['add'];
    model.controller_clear();
    model.controllers['id'].text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Add'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                    SizedBox(height: const_widget_padding),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(onPressed: () => {action("add", model), Navigator.pop(context)}, child: Text('Add')),
              ],
            );
          },
        );
      },
    );
  }

//-----[Edit]
  void edit(T_base model1) {
    var model = (model1 as dynamic);
    if (fields != null) items = fields['edit'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Edit'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(onPressed: () => {action("update", model), Navigator.pop(context)}, child: Text('Update')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[Delete]
  void delete(T_base model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Are you sure you want to delete ${(model as dynamic).name}?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(onPressed: () => {action("delete", model), Navigator.pop(context)}, child: Text('Delete')),
          ],
        );
      },
    );
  }

//-----[return]
  if (fields != null) items = fields['list'];
  return IntrinsicWidth(
    child: Card(
      child: Column(
        children: [
          //----------Title
          build_header_3(title: title, leftButton: build_icon_btn_1(onPressed: add, model: const_btn_models.add)),
          //----------header
          DataTable(
            columns: [
              ...model.controllers.keys.where((String key) => (items == null || items.isEmpty || items.containsKey(key))).map((String key) {
                return DataColumn(label: build_text_1(title: items?[key] ?? key));
              }).toList(),
              DataColumn(label: build_text_1(title: 'Action')),
            ],
            //----------rows
            rows: data_base.map((value1) {
              var value = (value1 as dynamic);
              return DataRow(
                cells: [
                  ...model.controllers.keys.where((String key) {
                    bool hasKey = items?.containsKey(key) ?? false;
                    return items == null || items.isEmpty || hasKey;
                  }).map((String key) {
                    return build_datacell_1(value: value.getValueByKey(key).toString());
                  }).toList(),
                  DataCell(build_action_1(onUpdate: (val) => edit(value), onDelete: (val) => delete(value), value: value)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

//--------------------------------[bul_dict_model] : Get model and return structure for update
Widget bul_dict_model<T_base>({
  required String title,
  required T_base model,
  required Function(T_base) action,
  double size_lable = 100,
  Map<String, dynamic>? fields = const {},
}) {
  var data = (model as dynamic);
  var item_list = null;
  if (fields != null) item_list = fields['edit'];
  return IntrinsicWidth(
    child: Column(
      children: [
        Card(
          child: Column(
            children: [
              //----------Title
              build_header_2(title: title),
              //----------Items
              Padding(
                padding: EdgeInsets.all(const_widget_padding),
                child: Column(
                  children: () {
                    if (item_list?.isNotEmpty == true) {
                      return data.controllers.entries.where((entry) => item_list?.containsKey(entry.key) == true).map<Widget>((entry) => build_Row_1(lable: item_list?[entry.key] ?? entry.key, controller: data.controller_get(entry.key), size_lable: size_lable)).toList();
                    } else {
                      return data.controllers.entries.map<Widget>((entry) => build_Row_1(lable: entry.key, controller: data.controller_get(entry.key), size_lable: size_lable)).toList();
                    }
                  }(),
                ),
              ),
            ],
          ),
        ),
        build_icon_btn_1(onPressed: () => action(data), model: const_btn_models.save),
      ],
    ),
  );
}

//--------------------------------[bul_list_com]
//Good for objects that return List
Widget bul_list_com<T_base>({
  required BuildContext context,
  required String title,
  required List<T_base> data_base,
  required Function(String, T_base) action,
  Map<String, dynamic>? fields = const {},
}) {
  var items = null;
  var model = (data_base.first as dynamic);

//-----[Add]
  void add() {
    if (fields != null) items = fields['add'];
    model.controller_clear();
    model.controllers['id'].text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Add'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                    SizedBox(height: const_widget_padding),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(onPressed: () => {action("add", model), Navigator.pop(context)}, child: Text('Add')),
              ],
            );
          },
        );
      },
    );
  }

//-----[Edit]
  void edit(T_base model1) {
    var model = (model1 as dynamic);
    if (fields != null) items = fields['edit'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              title: Text('Edit'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ...model.controllers.entries.where((entry) => items == null || items.isEmpty || items.containsKey(entry.key)).map((entry) => build_Row_3(items?[entry.key] ?? entry.key, model.controller_get(entry.key))).toList(),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(onPressed: () => {action("update", model), Navigator.pop(context)}, child: Text('Update')),
              ],
            );
          },
        );
      },
    );
  }

  //-----[Delete]
  void delete(T_base model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Are you sure you want to delete ${(model as dynamic).name}?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(onPressed: () => {action("delete", model), Navigator.pop(context)}, child: Text('Delete')),
          ],
        );
      },
    );
  }

//-----[return]
  if (fields != null) items = fields['list'];
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: Card(
        child: Column(
          children: [
            //----------Title
            build_header_3(title: title, leftButton: build_icon_btn_1(onPressed: add, model: const_btn_models.add)),
            //----------header
            DataTable(
              columns: [
                ...model.controllers.keys.where((String key) => (items == null || items.isEmpty || items.containsKey(key))).map((String key) {
                  return DataColumn(label: build_text_1(title: items?[key] ?? key));
                }).toList(),
                DataColumn(label: build_text_1(title: 'Action')),
              ],
              //----------rows
              rows: data_base.map((value1) {
                var value = (value1 as dynamic);
                return DataRow(
                  cells: [
                    ...model.controllers.keys.where((String key) {
                      bool hasKey = items?.containsKey(key) ?? false;
                      return items == null || items.isEmpty || hasKey;
                    }).map((String key) {
                      return build_datacell_1(value: value.getValueByKey(key).toString());
                    }).toList(),
                    DataCell(build_action_1(onUpdate: (val) => edit(value), onDelete: (val) => delete(value), value: value)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}

//--------------------------------[build_complete_2] :
//Good for config, xray_server
Widget build_complete_2<T_base>({
  required String title,
  required T_base model_base,
  required Function() action,
  double size_lable = 100,
  Map<String, dynamic>? fields = const {},
}) {
  var model = (model_base as dynamic);
  var item_list = null;
  if (fields != null) item_list = fields['edit'];
  return IntrinsicWidth(
    child: Column(
      children: [
        Card(
          child: Column(
            children: [
              //----------Title
              build_header_2(title: title),
              //----------Items
              Padding(
                padding: EdgeInsets.all(const_widget_padding),
                child: Column(
                  children: () {
                    if (item_list?.isNotEmpty == true) {
                      return model.controllers.entries.where((entry) => item_list?.containsKey(entry.key) == true).map<Widget>((entry) => build_Row_1(lable: item_list?[entry.key] ?? entry.key, controller: model.controller_get(entry.key), size_lable: size_lable)).toList();
                    } else {
                      return model.controllers.entries.map<Widget>((entry) => build_Row_1(lable: entry.key, controller: model.controller_get(entry.key), size_lable: size_lable)).toList();
                    }
                  }(),
                ),
              ),
            ],
          ),
        ),
        build_icon_btn_1(onPressed: action, model: const_btn_models.save),
      ],
    ),
  );
}

//--------------------------------[build_complete_3] :
//Good for object - no list - like config, xray_server
Widget build_complete_3<T_base>({
  required String title,
  required T_base model_base,
  required Function() action,
  double size_lable = 150,
  Map<String, String>? item_list = const {},
}) {
  var model = (model_base as dynamic);
  return IntrinsicWidth(
    child: Column(
      children: [
        Card(
          child: Column(
            children: [
              //----------Header
              build_header_2(title: title),
              //----------Items
              Padding(
                padding: EdgeInsets.all(const_widget_padding),
                child: model.controllers.entries.where((entry) => (item_list == null || item_list.isEmpty) ? true : item_list.containsKey(entry.key)).map<Widget>((entry) => build_Row_1(lable: entry.key, controller: model.controller_get(entry.key), size_lable: size_lable)).toList(),
              ),
            ],
          ),
        ),
        build_icon_btn_1(onPressed: action, model: const_btn_models.save),
      ],
    ),
  );
}

//--------------------------------------------------------------------------------- [Data-Cell]
//--------------------------------[build_datacell_1]
build_datacell_1({
  required String value,
}) {
  Widget obj;
  if (value == "true" || value == "True" || value == "True" || value == "false") {
    obj = build_icon_1(isAccepted: bool.parse(value));
  } else if (value == "false" || value == "False") {
    obj = build_icon_1(isAccepted: false);
  } else {
    obj = Text(value);
  }
  return DataCell(obj);
}
