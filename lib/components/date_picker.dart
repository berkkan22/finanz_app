import 'package:finanz_app/core/globals.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final void Function(int) callback;
  final int time;
  const DatePicker({Key? key, required this.callback, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            callback(time - dayInMicroSeconds);
          },
        ),
        const SizedBox(width: 16),
        TextButton(
          child: Text(
            formatter.format(
              DateTime.fromMicrosecondsSinceEpoch(time),
            ),
            style: const TextStyle(fontSize: 20),
          ),
          onPressed: () async {
            DateTime? newSelectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.fromMicrosecondsSinceEpoch(time),
              firstDate: DateTime(2000),
              lastDate: DateTime(2030),
            );

            if (newSelectedDate != null) {
              callback(newSelectedDate.microsecondsSinceEpoch);
            }
          },
          onLongPress: () {
            callback(DateTime.now().microsecondsSinceEpoch);
          },
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            callback(time + dayInMicroSeconds);
          },
        ),
      ],
    );
  }
}
