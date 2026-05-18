import 'package:flutter/material.dart';
import 'package:flutter_restful_api/app_properties/app_properties_color.dart';
import 'package:flutter_restful_api/app_properties/app_properties_style.dart';

void customSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppPropertyColor.primary,
      content: Text(message, style: lv05TextStyleWhite),
    ),
  );
}
