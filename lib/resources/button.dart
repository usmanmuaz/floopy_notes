import 'package:floopy_notes/resources/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPress;
  final String name;
  const MyButton({super.key,
  required this.onPress,
  required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration:  BoxDecoration(
          color: pink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(name, style: const TextStyle(color: cyan, fontSize: 15,),),
        ),
      ),
    );
  }
}