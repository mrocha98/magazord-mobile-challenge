import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

mixin ToastMixin<T extends StatefulWidget> on State<T> {
  static const _toastDuration = Duration(seconds: 5);

  static const _toastPosition = MotionToastPosition.top;

  void showSuccess(String message) {
    MotionToast.success(
      title: const Text('SUCCESS'),
      description: Text(message),
      toastDuration: _toastDuration,
      position: _toastPosition,
    ).show(context);
  }

  void showError(String message) {
    MotionToast.error(
      title: const Text('ERROR'),
      description: Text(message),
      toastDuration: _toastDuration,
      position: _toastPosition,
    ).show(context);
  }

  void showWarning(String message) {
    MotionToast.warning(
      title: const Text('WARNING'),
      description: Text(message),
      toastDuration: _toastDuration,
      position: _toastPosition,
    ).show(context);
  }

  void showInfo(String message) {
    MotionToast.info(
      title: const Text('INFO'),
      description: Text(message),
      toastDuration: _toastDuration,
      position: _toastPosition,
    ).show(context);
  }
}
