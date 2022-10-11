import 'package:finanz_app/state_notifier/calculation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardKey extends StatelessWidget {
  final String? text;
  final Widget? widget;
  final void Function()? onPress;
  const KeyboardKey({Key? key, this.text, this.widget, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress ??
          () {
            context
                .read(calculationNotifierProvider.notifier)
                .addToInput(text!);
          },
      child: text == null ? widget : Text(text!),
    );
  }
}
