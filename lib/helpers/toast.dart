import 'package:flutter/material.dart';

appToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(
      milliseconds: 300,
    ),
  ));
}
