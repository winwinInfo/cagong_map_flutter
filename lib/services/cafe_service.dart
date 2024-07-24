import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/cafe.dart';

class CafeService extends ChangeNotifier {
  List<Cafe> _cafes = [];
  List<Cafe> _filteredCafes = [];

  List<Cafe> get cafes => _filteredCafes.isEmpty ? _cafes : _filteredCafes;

  Future<void> loadCafes() async {
    final String response =
        await rootBundle.loadString('assets/cafe_info.json');
    final data = await json.decode(response);
    _cafes = data.map<Cafe>((json) => Cafe.fromJson(json)).toList();
    _filteredCafes = List.from(_cafes);
    notifyListeners();
  }

  void filterCafes(Map<String, dynamic> filters) {
    _filteredCafes = _cafes.where((cafe) {
      bool passFilter = true;

      if (filters.containsKey('hours')) {
        int minHours = int.parse(filters['hours']);
        passFilter = passFilter &&
            (cafe.hoursWeekday >= minHours || cafe.hoursWeekend >= minHours);
      }

      if (filters.containsKey('maxPrice')) {
        int maxPrice = int.parse(filters['maxPrice']);
        passFilter = passFilter && (cafe.price <= maxPrice);
      }

      if (filters.containsKey('minPowerSeats')) {
        int minPowerSeats = int.parse(filters['minPowerSeats']);
        int totalPowerSeats =
            cafe.seatingInfo.fold(0, (sum, seat) => sum + seat.powerCount);
        passFilter = passFilter && (totalPowerSeats >= minPowerSeats);
      }

      return passFilter;
    }).toList();

    notifyListeners();
  }
}
