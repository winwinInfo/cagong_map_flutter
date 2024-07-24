class Cafe {
  final String id;
  final String name;
  final String address;
  final String message;
  final String openingHours;
  final int hoursWeekday;
  final int hoursWeekend;
  final int price;
  final List<SeatingInfo> seatingInfo;
  final String? videoUrl;
  final int cowork;
  final double latitude;
  final double longitude;

  Cafe({
    required this.id,
    required this.name,
    required this.address,
    required this.message,
    required this.openingHours,
    required this.hoursWeekday,
    required this.hoursWeekend,
    required this.price,
    required this.seatingInfo,
    this.videoUrl,
    required this.cowork,
    required this.latitude,
    required this.longitude,
  });

  factory Cafe.fromJson(Map<String, dynamic> json) {
    return Cafe(
      id: json['ID'].toString(),
      name: json['Name'],
      address: json['Address'],
      message: json['Message'],
      openingHours: json['영업 시간'],
      hoursWeekday: json['Hours_weekday'],
      hoursWeekend: json['Hours_weekend'],
      price: int.parse(json['Price'].replaceAll(RegExp(r'[^0-9]'), '')),
      seatingInfo: _parseSeatingInfo(json),
      videoUrl: json['Video URL'],
      cowork: json['Co-work'],
      latitude: json['Position (Latitude)'],
      longitude: json['Position (Longitude)'],
    );
  }

  static List<SeatingInfo> _parseSeatingInfo(Map<String, dynamic> json) {
    List<SeatingInfo> seatingInfoList = [];
    for (int i = 1; i <= 5; i++) {
      String typeKey = 'Seating Type $i';
      String countKey = 'Seating Count $i';
      String powerKey = 'Power Count $i';

      if (json.containsKey(typeKey) && json[typeKey] != null) {
        seatingInfoList.add(SeatingInfo(
          type: json[typeKey],
          count: json[countKey] ?? 0,
          powerCount: json[powerKey] ?? 0,
        ));
      }
    }
    return seatingInfoList;
  }
}

class SeatingInfo {
  final String type;
  final int count;
  final int powerCount;

  SeatingInfo({
    required this.type,
    required this.count,
    required this.powerCount,
  });
}
