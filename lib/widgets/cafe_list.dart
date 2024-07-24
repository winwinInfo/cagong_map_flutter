import 'package:flutter/material.dart';
import '../models/cafe.dart';

class CafeList extends StatelessWidget {
  final List<Cafe> cafes;
  final Function(Cafe) onCafeSelected;

  CafeList({required this.cafes, required this.onCafeSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cafes.length,
      itemBuilder: (context, index) {
        final cafe = cafes[index];
        return ListTile(
          title: Text(cafe.name),
          subtitle: Text(cafe.address),
          onTap: () => onCafeSelected(cafe),
        );
      },
    );
  }
}
