import 'package:finanz_app/screens/transaktionen_container.dart';
import 'package:finanz_app/state_notifier/transaktion_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransaktionConsumer extends StatelessWidget {
  const TransaktionConsumer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, watch, child) {
        final transaktionsState = watch(transaktionNotifierProvider);

        if (transaktionsState is TransaktionInitialState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: TransaktionPage(
              transaktionState: transaktionsState,
            ),
          );
        } else if (transaktionsState is TransaktionLoadingState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: TransaktionPage(
              transaktionState: transaktionsState,
            ),
          );
        } else if (transaktionsState is TransaktionLoadedState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: TransaktionPage(
              transaktionState: transaktionsState,
              transaktionsList: transaktionsState.transaktionList,
            ),
          );
        } else if (transaktionsState is TransaktionErrorState) {
          return Text("ERROR: ${transaktionsState.errorMessage}");
        } else {
          return const Text("Unknown ERROR");
        }
      }),
    );
  }
}
