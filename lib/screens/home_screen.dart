import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/kakao_map/kakao_map.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // 태블릿이나 데스크톱 레이아웃
            return Row(
              children: [
                Container(
                  width: 300,
                  child: Sidebar(),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: KakaoMap(
                      latitude: 37.5665,
                      longitude: 126.9780,
                    ),
                  ),
                ),
              ],
            );
          } else {
            // 모바일 레이아웃
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: KakaoMap(
                    latitude: 37.5665,
                    longitude: 126.9780,
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.1,
                  minChildSize: 0.1,
                  maxChildSize: 0.7,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      color: Colors.white,
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Container(
                            height: 40,
                            child: Center(
                              child: Container(
                                width: 50,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Sidebar(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
