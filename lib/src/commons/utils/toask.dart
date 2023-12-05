import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

abstract class Toast {
  static MotionToast success(String message) {
    return MotionToast.success(
      title: const Text('Sucesso'),
      description: Text(message),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromRight,
    );
  }

  static MotionToast error(String error) {
    return MotionToast.error(
      title: const Text('ERROR'),
      description: Text(error),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromRight,
    );
  }
}
