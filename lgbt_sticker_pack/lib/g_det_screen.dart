import 'dart:developer';

import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lgbt_sticker_pack/g_set_screen.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GDetScreen extends StatefulWidget {
  final bool isGFree;
  final List<int> gInds;
  final String gName;

  const GDetScreen({
    super.key,
    required this.isGFree,
    required this.gInds,
    required this.gName,
  });

  @override
  State<GDetScreen> createState() => _GDetScreenState();
}

class _GDetScreenState extends State<GDetScreen> {
  RxBool gSelected = false.obs;
  RxBool gLoad = true.obs;
  RxBool gBought = true.obs;

  int get packId {
    if (widget.gName == 'Gays') {
      return 0;
    } else if (widget.gName == 'Lesbians') {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!widget.isGFree) {
        final gPrefs = await SharedPreferences.getInstance();
        gBought.value = gPrefs.getBool(packId.toString()) ?? false;
      }
      await SharedPreferenceAppGroup.setAppGroup('group.lgbtPack');
      final curG = await SharedPreferenceAppGroup.getInt('pack_type') ?? 0;
      gSelected.value = curG == packId;

      gLoad.value = false;
    });
  }

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
            widget.gName,
            style: TextStyle(
              fontFamily: 'Pop',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const GSetScreen());
                },
                child: Image.asset(
                  'gassets/images/set.png',
                  height: 24,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.all(32).copyWith(bottom: 8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('gassets/images/card_bg.png'),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: 30).copyWith(bottom: 64),
                  itemCount: widget.gInds.length,
                  itemBuilder: (context, index) => Image.asset(
                    'gassets/stickers/${widget.gInds[index]}.png',
                    fit: BoxFit.fitHeight,
                    height: 200,
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 28,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (!gLoad.value) {
                    if (!gBought.value) {
                      gLoad.value = true;
                      final pwlsGay = await Apphud.paywalls();
                      print(pwlsGay?.paywalls.first.products!);

                      final purGay = await Apphud.purchase(
                        product: pwlsGay?.paywalls.first.products!.first,
                      );
                      if (purGay.error == null) {
                        final gPrefs = await SharedPreferences.getInstance();
                        await gPrefs.setBool(packId.toString(), true);
                        gBought.value = true;
                      }

                      gLoad.value = false;
                    } else if (gBought.value && !gSelected.value) {
                      gLoad.value = true;
                      try {
                        await SharedPreferenceAppGroup.setAppGroup(
                            'group.lgbtPack');
                        await SharedPreferenceAppGroup.setInt(
                            'pack_type', packId);
                      } catch (e) {
                        log(e.toString());
                      }
                      gSelected.value = true;
                      gLoad.value = false;
                    }
                  }
                },
                child: Obx(
                  () => Container(
                    height: 46,
                    margin: EdgeInsets.symmetric(horizontal: 44)
                        .copyWith(bottom: 22),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 12,
                            spreadRadius: 5)
                      ],
                      color: gSelected.value
                          ? Colors.white
                          : Color.fromRGBO(120, 83, 224, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => gLoad.value
                          ? CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              gBought.value
                                  ? gSelected.value
                                      ? 'Selected'
                                      : 'Select'
                                  : 'Buy 1.99\$',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Pop',
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: gSelected.value
                                    ? Color.fromRGBO(8, 17, 32, 1)
                                    : Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
