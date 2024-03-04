import 'dart:async';

import 'package:flutter/material.dart';

mixin LoaderMixin<T extends StatefulWidget> on State<T> {
  var _isOpen = false;

  FutureOr<void> showLoader() async {
    if (_isOpen) return;
    _isOpen = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const SizedBox.square(
            dimension: 60,
            child: CircularProgressIndicator(
              semanticsLabel: 'Loading',
              strokeWidth: 10,
            ),
          ),
        ),
      ),
    );
  }

  void hideLoader() {
    if (_isOpen) {
      _isOpen = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
