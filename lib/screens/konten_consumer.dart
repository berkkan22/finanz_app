import 'package:finanz_app/screens/konten_container.dart';
import 'package:finanz_app/state_notifier/konten_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KontenConsumer extends StatelessWidget {
  const KontenConsumer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final kontenState = watch(kontenNotifierProvider);

        if (kontenState is KontenInit) {
          return const Text(
            "Neu hier? Erstelle ein Konto!",
          );
        } else if (kontenState is KontenLoading) {
          return const CircularProgressIndicator();
        } else if (kontenState is KontenLoaded) {
          // return KontenContainer(kontenList: kontenState.konten);
          return KontenContainer2(kontenList: kontenState.konten);
        } else if (kontenState is KontenError) {
          return Text("ERROR: ${kontenState.errorMessage}");
        } else {
          return const Text("Unknown ERROR");
        }
      },
    );
  }
}
