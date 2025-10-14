import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:taggo/shared/shared.dart';

class DeBouncer {
  int? milliseconds; 
  VoidCallback? action; 

  static Timer? timer; 

  static run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: const Duration(milliseconds: 500).inMilliseconds),
      action, 
    );
  }
}

abstract class BaseController<T> extends GetxController {
  final T repository;
  BaseController(this.repository);

  final isInitialized = false.obs;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  _initData() async {
    await getData();
    isInitialized.value = true;
  }

  Future getData() async {}

  showError(
    String title,
    String message, {
    int duration = 3,
  }) {
    DeBouncer.run(() {
      SnackbarHelper.showSnackbar(
        title,
        message,
        duration: duration,
        backgroundColor: AppColors.supportErrorPrimary,
      );
    });
  }

  showSuccess(
    String title,
    String message, {
    int duration = 3,
  }) {
    DeBouncer.run(() {
      DeBouncer.run(() {
        SnackbarHelper.showSnackbar(
          title,
          message,
          duration: duration,
          backgroundColor: AppColors.supportSuccessPrimary,
        );
      });
    });
  }

  setLoading(bool value) {
    if (value) {
      EasyLoading.show();
    } else {
      EasyLoading.dismiss();
    }
  }
}