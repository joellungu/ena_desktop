import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'vues/splash.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await GetStorage.init();
  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Presence',
      debugShowCheckedModeBanner: false,
      //localizationsDelegates: ,
      locale: Locale("fr", "FR"),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(), //
    );
  }
}
