import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function onPress;

  const FloatingButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            child: icon,
          ),
        ],
      ),
    );
  }
}
