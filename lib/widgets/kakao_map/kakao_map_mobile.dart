import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KakaoMapPlatform extends StatelessWidget {
  final double latitude;
  final double longitude;

  const KakaoMapPlatform({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'about:blank',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _loadHtmlFromAssets(webViewController, context);
      },
      javascriptChannels: <JavascriptChannel>{
        JavascriptChannel(
          name: 'MapCreated',
          onMessageReceived: (JavascriptMessage message) {
            // 지도가 생성된 후 추가 작업을 수행할 수 있습니다.
          },
        ),
      },
    );
  }

  void _loadHtmlFromAssets(
      WebViewController controller, BuildContext context) async {
    String fileText = await DefaultAssetBundle.of(context)
        .loadString('assets/kakao_map.html');
    fileText = fileText.replaceAll('{LATITUDE}', latitude.toString());
    fileText = fileText.replaceAll('{LONGITUDE}', longitude.toString());
    controller.loadUrl(
        Uri.dataFromString(fileText, mimeType: 'text/html', encoding: utf8)
            .toString());
  }
}
