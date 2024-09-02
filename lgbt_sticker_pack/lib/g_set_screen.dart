import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_composite_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lgbt_sticker_pack/g_sys_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GSetScreen extends StatefulWidget {
  const GSetScreen({super.key});

  @override
  State<GSetScreen> createState() => _GSetScreenState();
}

class _GSetScreenState extends State<GSetScreen> {
  RxBool _gPur = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('gassets/images/bg.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: GestureDetector(
            onTap: Get.back,
            child: Container(
              height: 24,
              width: 24,
              margin: EdgeInsets.only(left: 16),
              alignment: Alignment.center,
              child: Image.asset(
                'gassets/images/back.png',
                height: 24,
              ),
            ),
          ),
          title: Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'Pop',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => GSysScreen(gSysScreen: 'Privacy Policy'));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Pop',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(8, 17, 32, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => GSysScreen(gSysScreen: 'Terms of Use'));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Terms of Use',
                      style: TextStyle(
                        fontFamily: 'Pop',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(8, 17, 32, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => GSysScreen(gSysScreen: 'Support'));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Support',
                      style: TextStyle(
                        fontFamily: 'Pop',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(8, 17, 32, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () async {
                    if (!_gPur.value) {
                      _gPur.value = true;
                      final ApphudComposite restPuG =
                          await Apphud.restorePurchases();

                      bool failPuG = true;

                      if (restPuG.purchases.isNotEmpty) {
                        for (final pu in restPuG.purchases) {
                          if (pu.productId == 'premium') {
                            failPuG = false;
                            final _gayPrefs =
                                await SharedPreferences.getInstance();
                            await _gayPrefs.setBool('2', true);
                            break;
                          }
                        }
                      }

                      if (failPuG) {
                        Get.showSnackbar(GetSnackBar(
                          duration: Duration(milliseconds: 1500),
                          backgroundColor: Colors.white,
                          messageText: Text('Purchase is not found',
                              style: TextStyle(
                                  fontFamily: 'Popin',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color.fromRGBO(8, 17, 32, 1))),
                        ));
                      } else {
                        Get.showSnackbar(GetSnackBar(
                          duration: Duration(milliseconds: 1500),
                          backgroundColor: Colors.white,
                          messageText: Text('Purchase has been restored',
                              style: TextStyle(
                                  fontFamily: 'Popin',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color.fromRGBO(8, 17, 32, 1))),
                        ));
                      }

                      _gPur.value = false;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => _gPur.value
                          ? CupertinoActivityIndicator(
                              color: Color.fromRGBO(8, 17, 32, 1),
                            )
                          : Text(
                              'Restore Purchase',
                              style: TextStyle(
                                fontFamily: 'Pop',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(8, 17, 32, 1),
                              ),
                            ),
                    ),
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
