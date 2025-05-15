import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController snackbar(
    String title, String message, SnackPosition snackPosition) {
  return Get.snackbar(
    title,
    message,
    snackPosition: snackPosition,
    mainButton: TextButton(
      onPressed: () => Get.back(),
      child: const Text('OK'),
    ),
  );
}
