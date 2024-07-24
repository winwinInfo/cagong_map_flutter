import 'package:flutter/material.dart';

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
    return Center(
      child: Text('카카오 지도는 이 플랫폼에서 지원되지 않습니다.'),
    );
  }
}
