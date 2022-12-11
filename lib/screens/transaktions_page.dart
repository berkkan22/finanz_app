import 'package:finanz_app/state_notifier/transaktion_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/transaktion.dart';
import '../core/globals.dart';

class TransaktionPage extends StatelessWidget {
  const TransaktionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaktionen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: Consumer(
            builder: ((context, watch, child) {
              final transaktionsState = watch(transaktionNotifierProvider);

              if (transaktionsState is TransaktionInitialState) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: const Text(
                    "Es stehen noch keine Transaktionen an!",
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                );
              } else if (transaktionsState is TransaktionLoadingState) {
                return Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: const CircularProgressIndicator());
              } else if (transaktionsState is TransaktionLoadedState) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: transaktionsState.transaktionList.length,
                    itemBuilder: (context, index) {
                      logger.i(
                          "index: ${transaktionsState.transaktionList.length}");
                      return Column(
                        children: [
                          TransaktionTile(
                            transaktion:
                                transaktionsState.transaktionList[index],
                            index: index,
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                  // child: TransaktionContainer(
                  //   transaktionState: transaktionsState,
                  //   transaktionsList: transaktionsState.transaktionList,
                  // ),
                );
              } else if (transaktionsState is TransaktionErrorState) {
                return Text("ERROR: ${transaktionsState.errorMessage}");
              } else {
                return const Text("Unknown ERROR");
              }
            }),
          ),
        ),
      ),
    );
  }
}
