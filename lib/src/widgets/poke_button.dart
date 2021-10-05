import 'package:flutter/material.dart';

class PokeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PokeButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: child,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.teal[300]!,
              Colors.teal[400]!,
            ]),
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
