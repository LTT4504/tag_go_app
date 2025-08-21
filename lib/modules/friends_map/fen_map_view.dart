import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'fen_map_controller.dart';

class FriendsMapView extends GetView<FriendsMapController> {
  const FriendsMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bản đồ bạn bè')),
      body: const Center(child: Text('Friends Map – Coming soon')),
    );
  }
}
