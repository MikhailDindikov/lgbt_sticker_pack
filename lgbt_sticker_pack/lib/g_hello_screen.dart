import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lgbt_sticker_pack/g_main_screen.dart';

class GHelloScreen extends StatelessWidget {
  const GHelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('gassets/images/bg.png'),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Get.offAll(() => GMainScreen());
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WELCOME TO\nLGBT STIKER PACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pop',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'gassets/images/onboarding.png',
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(120, 83, 224, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Choose stickers',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Pop',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'WELCOME TO\nLGBT STICKER PACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pop',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
