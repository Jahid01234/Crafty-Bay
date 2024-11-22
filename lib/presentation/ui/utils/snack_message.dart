import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message,[ bool isError = false]){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating, // for use show margin
          margin: const EdgeInsets.all(20),
          backgroundColor: isError? Colors.red : null,
          content: Text(message)
      )
  );

}