import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:js' as js;
import 'package:flutter/material.dart';

class KakaoMap extends StatefulWidget {
  final double latitude;
  final double longitude;

  const KakaoMap({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  _KakaoMapState createState() => _KakaoMapState();
}

class _KakaoMapState extends State<KakaoMap> {
  late final String viewId;

  @override
  void initState() {
    super.initState();
    viewId = 'kakao-map-${UniqueKey().toString()}';
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      final mapElement = html.DivElement()
        ..id = this.viewId
        ..style.width = '100%'
        ..style.height = '100%';

      return mapElement;
    });

    // Kakao Maps SDK 로드
    html.window.onLoad.listen((_) {
      initializeMap();
    });
  }

  void initializeMap() {
    final container = html.document.getElementById(viewId);
    if (container == null) {
      print('Map container not found');
      return;
    }

    // JavaScript 함수 호출
    js.context.callMethod('initKakaoMap', [
      viewId,
      widget.latitude,
      widget.longitude,
      3 // zoom level
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: HtmlElementView(viewType: viewId),
    );
  }
}
