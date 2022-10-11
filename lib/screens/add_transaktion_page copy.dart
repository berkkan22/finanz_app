import 'package:finanz_app/components/keyboard_key.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:finanz_app/state_notifier/calculation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTransaktionPage extends StatefulWidget {
  final List<Konten> kontenList;

  const AddTransaktionPage({Key? key, required this.kontenList})
      : super(key: key);

  @override
  State<AddTransaktionPage> createState() => _AddTransaktionPageState();
}

class _AddTransaktionPageState extends State<AddTransaktionPage> {
  List<bool> selected = [];
  int betrag = 0;

  @override
  void initState() {
    for (var konto in widget.kontenList) {
      if (konto.isHauptKonto) {
        selected.add(true);
      } else {
        selected.add(false);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as VorgangsType;

    // debugPrint(args.toString());
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TAB? Einnahmen, ausgaben
          // Datum like =>    < September 30, 2022 >
          // From account list of the accounts main account is selected

          const SizedBox(height: 8),
          const Divider(thickness: 2),
          const Text(
            "Vom Account:",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.kontenList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // TODO: es sollte nur eins auswaehlbar sein
                        setState(() {
                          selected[index] = !selected[index];
                          for (var i = 0; i < selected.length; i++) {
                            if (selected[i] && index != i) {
                              selected[i] = false;
                            }
                          }
                        });
                        print(selected);
                      },
                      child: Chip(
                        backgroundColor: selected[index]
                            ? Color(widget.kontenList[index].color)
                            : Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        side: const BorderSide(color: Colors.black, width: 2),
                        label: Text(widget.kontenList[index].name.toString()),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                );
              },
            ),
          ),

          Consumer(
            builder: (context, watch, child) {
              final calcState = watch(calculationNotifierProvider);

              if (calcState is CalculationInitialState) {
                return const Text(
                  "0€",
                  style: TextStyle(fontSize: 30),
                );
              } else if (calcState is CalculationLoadedState) {
                return Text(
                  "${calcState.mathFormula}€",
                  style: const TextStyle(
                    fontSize: 30,
                    // color: double.parse(calcState.mathFormula) > 0
                    //     ? Colors.green
                    //     : Colors.red,
                  ),
                );
              } else {
                return const Text("UNKNOWN Error");
              }
            },
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // TODO: es sollte nur eins auswaehlbar sein
                  setState(() {
                    selected[0] = !selected[0];
                    for (var i = 0; i < selected.length; i++) {
                      if (selected[i] && 0 != i) {
                        selected[i] = false;
                      }
                    }
                  });
                  print(selected);
                },
                child: Chip(
                  backgroundColor: selected[0]
                      ? Color(widget.kontenList[0].color)
                      : Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  side: const BorderSide(color: Colors.black, width: 2),
                  label: Text(widget.kontenList[0].name.toString()),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: const [
                    KeyboardKey(text: "/"),
                    KeyboardKey(text: "*"),
                    KeyboardKey(text: "-"),
                    KeyboardKey(text: "+"),
                  ],
                ),
                Column(
                  children: [
                    const KeyboardKey(text: "7"),
                    const KeyboardKey(text: "4"),
                    const KeyboardKey(text: "1"),
                    KeyboardKey(
                      widget: const Icon(Icons.delete_forever),
                      onPress: () {
                        context
                            .read(calculationNotifierProvider.notifier)
                            .deleteAll();
                      },
                    ),
                  ],
                ),
                Column(
                  children: const [
                    KeyboardKey(text: "8"),
                    KeyboardKey(text: "5"),
                    KeyboardKey(text: "2"),
                    KeyboardKey(text: "0"),
                  ],
                ),
                Column(
                  children: const [
                    KeyboardKey(text: "9"),
                    KeyboardKey(text: "6"),
                    KeyboardKey(text: "3"),
                    KeyboardKey(text: ","),
                  ],
                ),
                Column(
                  children: [
                    KeyboardKey(
                      widget: const Icon(Icons.backspace_outlined),
                      onPress: () {
                        context
                            .read(calculationNotifierProvider.notifier)
                            .back();
                      },
                    ),
                    KeyboardKey(
                      widget: const Icon(Icons.speaker_notes_outlined),
                      onPress: () {
                        context
                            .read(calculationNotifierProvider.notifier)
                            .setInit();
                      },
                    ),
                    KeyboardKey(
                      text: "gleich",
                      onPress: () {
                        context
                            .read(calculationNotifierProvider.notifier)
                            .equals();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // betrag je nach dem ob einnahme oder ausgabe grün und rot anzeigen
          // Name beschreibung?
          // kategorie zum auswählen
        ],
      ),
    );
  }
}
