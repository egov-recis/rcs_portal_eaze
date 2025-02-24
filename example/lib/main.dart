import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/dependencies.dart';
import 'package:rcs_portal_eaze/ui/home_screen.dart';
import 'package:rcs_portal_eaze_example/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Dependencies().initialize();
    return GetMaterialApp(
      home: PortalEazeHomeScreen(uniqueCode: "test123"),
    );
  }
}
