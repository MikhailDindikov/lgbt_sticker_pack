import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:lgbt_sticker_pack/g_det_screen.dart';
import 'package:lgbt_sticker_pack/g_set_screen.dart';

class GMainScreen extends StatefulWidget {
  const GMainScreen({super.key});

  @override
  State<GMainScreen> createState() => _GMainScreenState();
}

class _GMainScreenState extends State<GMainScreen> {
  RxInt _curPack = 0.obs;
  final _packController = PageController();

  @override
  void initState() {
    super.initState();

    _packController.addListener(() {
      if (_packController.page != null) {
        _curPack.value = (_packController.page! + 0.49).toInt();
      }
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
        body: SafeArea(
          child: SizedBox(
            height: Get.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
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
                ),
                SizedBox(
                  height: 480,
                  width: Get.width,
                  child: PageView(
                    controller: _packController,
                    children: [
                      GMainCard(
                        isGFree: true,
                        gInds: [5, 6, 7, 8, 9, 16],
                        gName: 'Gays',
                      ),
                      GMainCard(
                        isGFree: true,
                        gInds: [10, 11, 12, 13, 17, 18],
                        gName: 'Lesbians',
                      ),
                      GMainCard(
                        isGFree: false,
                        gInds: [1, 2, 3, 4, 14, 15],
                        gName: 'Single',
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: (Get.height - 480) / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => AnimatedContainer(
                          height: 5,
                          width: _curPack.value == 0 ? 31 : 5,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: _curPack.value == 0
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Obx(
                        () => AnimatedContainer(
                          height: 5,
                          width: _curPack.value == 1 ? 31 : 5,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: _curPack.value == 1
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Obx(
                        () => AnimatedContainer(
                          height: 5,
                          width: _curPack.value == 2 ? 31 : 5,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: _curPack.value == 2
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ],
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

class GMainCard extends StatelessWidget {
  final bool isGFree;
  final List<int> gInds;
  final String gName;
  const GMainCard({
    super.key,
    required this.isGFree,
    required this.gInds,
    required this.gName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => GDetScreen(isGFree: isGFree, gInds: gInds, gName: gName));
      },
      child: Container(
        height: 480,
        width: Get.width - 60,
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.only(left: 17, right: 17, top: 29, bottom: 57),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('gassets/images/card_bg.png'),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gName,
                  style: TextStyle(
                    fontFamily: 'Pop',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(8, 17, 32, 1),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      gInds.length.toString(),
                      style: TextStyle(
                        fontFamily: 'Pop',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(8, 17, 32, 1),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      'gassets/images/st.png',
                      height: 27,
                      width: 27,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 53,
                      width: 53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(120, 83, 224, 1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        isGFree ? 'FREE' : 'BUY',
                        style: TextStyle(
                          fontFamily: 'Pop',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 176,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'gassets/stickers/${gInds[0]}.png',
                      fit: BoxFit.fitHeight,
                      height: 176,
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    child: Image.asset(
                      'gassets/stickers/${gInds[1]}.png',
                      fit: BoxFit.fitHeight,
                      height: 176,
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    child: Image.asset(
                      'gassets/stickers/${gInds[2]}.png',
                      fit: BoxFit.fitHeight,
                      height: 176,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(120, 83, 224, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'View all',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pop',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
