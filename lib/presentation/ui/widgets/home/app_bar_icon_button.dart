import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  const AppBarIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey.shade200,
        child:  Icon(
          iconData,
          color: Colors.grey,
          size: 18,
        ),
      ),
    );
  }
}