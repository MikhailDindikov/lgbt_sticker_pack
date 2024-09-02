import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lgbt_sticker_pack/g_hello_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Apphud.start(apiKey: 'app_JDA6RZSEChm8jiKxpaghEHQ457kL6B');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const LgbtStickerPackApp());
}

class LgbtStickerPackApp extends StatelessWidget {
  const LgbtStickerPackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LgbtStickerPack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GHelloScreen(),
    );
  }
}
