import 'package:flutter/material.dart';

class PokeTag extends StatelessWidget {
  final String type;
  final Color color;

  const PokeTag({
    Key? key,
    required this.type,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
