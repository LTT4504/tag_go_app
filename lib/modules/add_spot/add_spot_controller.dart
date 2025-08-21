import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/spot_model.dart';

class AddSpotController extends GetxController {
  final nameCtrl = TextEditingController();
  final favCtrl = TextEditingController(); // nhập "latte, matcha"
  final noteCtrl = TextEditingController();
  final isPrivate = true.obs;
  final mood = '😍'.obs;

  double? lat;
  double? lng;

  @override
  void onClose() {
    nameCtrl.dispose();
    favCtrl.dispose();
    noteCtrl.dispose();
    super.onClose();
  }

  Spot buildSpot() {
    final favs = favCtrl.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    return Spot(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameCtrl.text,
      lat: lat ?? 0,
      lng: lng ?? 0,
      favorites: favs,
      mood: mood.value,
      note: noteCtrl.text,
      isPrivate: isPrivate.value,
    );
  }
}
