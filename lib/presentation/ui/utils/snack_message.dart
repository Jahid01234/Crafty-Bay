import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message,[ bool isError = false]){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: isError? Colors.red : null,
          content: Text(message)
      )
  );

}