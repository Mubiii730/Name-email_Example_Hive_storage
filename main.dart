import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_practice/MainScreen.dart';
//import 'package:hive_practice/Screen_Model.dart';
import 'package:path_provider/path_provider.dart' as path1;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var path = await path1.getApplicationDocumentsDirectory();

  await Hive.initFlutter();
 // Hive.registerAdapter(ScreenModelAdapter());
  // open user hive box
  await Hive.openBox("User Box");
  print(path.path);
  runApp(
    const MaterialApp(
     home: MainScreen())

    );
}
