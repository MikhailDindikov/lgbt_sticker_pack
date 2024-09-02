import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GSysScreen extends StatefulWidget {
  final String gSysScreen;
  const GSysScreen({super.key, required this.gSysScreen});

  @override
  State<GSysScreen> createState() => _GSysScreenState();
}

class _GSysScreenState extends State<GSysScreen> {
  late WebViewController controllerWGay;

  @override
  void initState() {
    String llllWGay = '';
    if (widget.gSysScreen == 'Privacy Policy') {
      llllWGay =
          'https://docs.google.com/document/d/1nDu6rbgcOvtkRhkX4dqHzhNHTS2nOQu5IPJUfGKjYxM/edit?usp=sharing';
    } else if (widget.gSysScreen == 'Terms of Use') {
      llllWGay =
          'https://docs.google.com/document/d/1uaKOCVTBZPzLbNVOCXH7OwFEBbXlDqNheItGDFRfyhc/edit?usp=sharing';
    } else {
      llllWGay = 'https://form.jotform.com/242455485861465';
    }

    controllerWGay = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(llllWGay));
    super.initState();
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
          title: Text(
            widget.gSysScreen,
            style: TextStyle(
              fontFamily: 'Popin',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: 24,
              width: 24,
              alignment: Alignment.center,
              child: Image.asset(
                'gassets/images/back.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(30).copyWith(bottom: 8),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: WebViewWidget(
                        controller: controllerWGay,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
