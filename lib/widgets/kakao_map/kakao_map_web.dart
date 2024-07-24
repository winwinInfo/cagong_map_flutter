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

      loadKakaoMapScript();
      return mapElement;
    });
  }

  void loadKakaoMapScript() {
    if (html.document.querySelector('script[src*="dapi.kakao.com"]') == null) {
      final script = html.ScriptElement()
        ..src =
            '//dapi.kakao.com/v2/maps/sdk.js?appkey=0263a29ce4d7869fc8090d309d2bc371'
        ..type = 'text/javascript';
      html.document.head!.append(script);
      script.onLoad.listen((_) => initializeMap());
    } else {
      initializeMap();
    }
  }

  void initializeMap() {
    html.window.addEventListener('load', (_) {
      _createMap();
    });
  }

  void _createMap() {
    final container = html.document.getElementById(viewId);
    if (container == null) {
      print('Map container not found');
      return;
    }

    dynamic kakao = js.context['kakao'];
    if (kakao == null) {
      print('Kakao Maps SDK not loaded');
      return;
    }

    final options = js.JsObject.jsify({
      'center':
          js.JsObject.jsify({'lat': widget.latitude, 'lng': widget.longitude}),
      'level': 3
    });

    try {
      kakao['maps'].callMethod('Map', [container, options]);
      print('Map created successfully');
    } catch (e) {
      print('Error creating map: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: viewId);
  }
}
