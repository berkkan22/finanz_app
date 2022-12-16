import 'package:finanz_app/components/date_picker.dart';
import 'package:finanz_app/components/keyboard_key.dart';
import 'package:finanz_app/components/scrollable_row_chips.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:finanz_app/state_notifier/calculation_notifier.dart';
import 'package:finanz_app/state_notifier/chart_notifier.dart';
import 'package:finanz_app/state_notifier/transaktion_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTransaktionPage extends StatefulWidget {
  final List<Konten> kontenList;
  final List<Kategorie> kategorieList;

  const AddTransaktionPage(
      {Key? key, required this.kontenList, required this.kategorieList})
      : super(key: key);

  @override
  State<AddTransaktionPage> createState() => _AddTransaktionPageState();
}

class _AddTransaktionPageState extends State<AddTransaktionPage> {
  List<bool> selectedKontoBool = [];
  List<Konten> selectedKonto = [];
  List<bool> selectedKategorieBool = [];
  List<Kategorie> selectedKategorie = [];
  int betrag = 0;
  int tabBarIndex = 0;

  bool isCalculationDone = true;

  int time = DateTime.now().microsecondsSinceEpoch;

  @override
  void initState() {
    for (var konto in widget.kontenList) {
      // if (konto.isHauptKonto) {
      //   selectedKonto.add(true);
      // } else {
      selectedKontoBool.add(false);
      selectedKonto.add(konto);
      // }
    }

    for (Kategorie kategorie in widget.kategorieList) {
      selectedKategorieBool.add(false);
      selectedKategorie.add(kategorie);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as VorgangsType;

    // debugPrint(args.toString());
    return DefaultTabController(
      length: 2,
      initialIndex: tabBarIndex,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TAB? Einnahmen, ausgaben
            // Datum like =>    < September 30, 2022 >
            // From account list of the accounts main account is selected
            TabBar(
              onTap: (index) {
                setState(() {
                  tabBarIndex = index;
                });
              },
              tabs: const [
                Text(
                  "Einnahme",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Ausgabe",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DatePicker(
              callback: (newTime) {
                setState(() {
                  time = newTime;
                });
              },
              time: time,
            ),
            // const Divider(thickness: 2),
            const TextField(
              decoration: InputDecoration(hintText: "Name"),
            ),
            const SizedBox(height: 16),
            const Text(
              "Vom Account:",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 8),
            ScrollableRowOfChips(
              chipListKonten: widget.kontenList,
              selected: selectedKontoBool,
              callback: (list) {
                setState(() {
                  selectedKontoBool = list;
                });
              },
            ),
            Consumer(
              builder: (context, watch, child) {
                final calcState = watch(calculationNotifierProvider);

                if (calcState is CalculationInitialState) {
                  return Text(
                    "0€",
                    style: TextStyle(
                        fontSize: 30,
                        color: tabBarIndex == 0 ? Colors.green : Colors.red),
                  );
                } else if (calcState is CalculationLoadedState) {
                  return Text(
                    "${calcState.mathFormula}€",
                    style: TextStyle(
                        fontSize: 30,
                        color: tabBarIndex == 0 ? Colors.green : Colors.red),
                  );
                } else {
                  return const Text("UNKNOWN Error");
                }
              },
            ),
            ScrollableRowOfChips(
              chipListKategorie: selectedKategorie,
              selected: selectedKategorieBool,
              callback: (list) {
                setState(() {
                  selectedKategorieBool = list;
                });
              },
            ),
            // SizedBox(
            //   height: 50,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: Kategorie.values.length,
            //     itemBuilder: (context, index) {
            //       return Row(
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               setState(() {
            //                 selectedKategorie[index] =
            //                     !selectedKategorie[index];
            //                 for (var i = 0; i < selectedKategorie.length; i++) {
            //                   if (selectedKategorie[i] && index != i) {
            //                     selectedKategorie[i] = false;
            //                   }
            //                 }
            //               });
            //               print(selectedKategorie);
            //             },
            //             child: Chip(
            //               backgroundColor: selectedKategorie[index]
            //                   ? Colors.amber
            //                   : Colors.transparent,
            //               shape: const RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(20),
            //                   topRight: Radius.circular(20),
            //                   bottomLeft: Radius.circular(20),
            //                   bottomRight: Radius.circular(20),
            //                 ),
            //               ),
            //               side: const BorderSide(color: Colors.black, width: 2),
            //               label: Text(Kategorie.values[index].name.toString()),
            //             ),
            //           ),
            //           const SizedBox(width: 16),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      padding: const EdgeInsets.all(0),
                      children: [
                        KeyboardKey(
                          text: "/",
                          onPress: () {
                            context
                                .read(calculationNotifierProvider.notifier)
                                .addToInput("/");
                            setState(() {
                              isCalculationDone = false;
                            });
                          },
                        ),
                        const KeyboardKey(text: "7"),
                        const KeyboardKey(text: "8"),
                        const KeyboardKey(text: "9"),
                        KeyboardKey(
                          text: "*",
                          onPress: () {
                            context
                                .read(calculationNotifierProvider.notifier)
                                .addToInput("*");
                            setState(() {
                              isCalculationDone = false;
                            });
                          },
                        ),
                        const KeyboardKey(text: "4"),
                        const KeyboardKey(text: "5"),
                        const KeyboardKey(text: "6"),
                        KeyboardKey(
                          text: "-",
                          onPress: () {
                            context
                                .read(calculationNotifierProvider.notifier)
                                .addToInput("-");
                            setState(() {
                              isCalculationDone = false;
                            });
                          },
                        ),
                        const KeyboardKey(text: "1"),
                        const KeyboardKey(text: "2"),
                        const KeyboardKey(text: "3"),
                        KeyboardKey(
                          text: "+",
                          onPress: () {
                            context
                                .read(calculationNotifierProvider.notifier)
                                .addToInput("+");
                            setState(() {
                              isCalculationDone = false;
                            });
                          },
                        ),
                        KeyboardKey(
                          widget: const Icon(Icons.delete_forever),
                          onPress: () {
                            context
                                .read(calculationNotifierProvider.notifier)
                                .deleteAll();
                          },
                        ),
                        const KeyboardKey(text: "0"),
                        const KeyboardKey(text: ","),
                      ],
                    ),
                  ),
                  // Column(
                  //   children: const [
                  //     KeyboardKey(text: "/"),
                  //     KeyboardKey(text: "*"),
                  //     KeyboardKey(text: "-"),
                  //     KeyboardKey(text: "+"),
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     const KeyboardKey(text: "7"),
                  //     const KeyboardKey(text: "4"),
                  //     const KeyboardKey(text: "1"),
                  //     KeyboardKey(
                  //       widget: const Icon(Icons.delete_forever),
                  //       onPress: () {
                  //         context
                  //             .read(calculationNotifierProvider.notifier)
                  //             .deleteAll();
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // Column(
                  //   children: const [
                  //     KeyboardKey(text: "8"),
                  //     KeyboardKey(text: "5"),
                  //     KeyboardKey(text: "2"),
                  //     KeyboardKey(text: "0"),
                  //   ],
                  // ),
                  // Column(
                  //   children: const [
                  //     KeyboardKey(text: "9"),
                  //     KeyboardKey(text: "6"),
                  //     KeyboardKey(text: "3"),
                  //     KeyboardKey(text: ","),
                  //   ],
                  // ),
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
                        onPress: () {},
                      ),
                      isCalculationDone
                          ? KeyboardKey(
                              widget: const Icon(Icons.check),
                              onPress: () {
                                Transaktion transaktion = Transaktion(
                                  name: null,
                                  datum:
                                      DateTime.fromMicrosecondsSinceEpoch(time),
                                  betrag: context
                                      .read(
                                          calculationNotifierProvider.notifier)
                                      .equals(),
                                  vorgangsType: VorgangsType.ueberweisung,
                                  transaktionsType: tabBarIndex == 0
                                      ? TransaktionsType.einnahme
                                      : TransaktionsType.ausgabe,
                                  // FIXME: fehler mit konto nicht gefunden
                                  vonKontoId: selectedKontoBool.contains(true)
                                      ? selectedKonto[selectedKontoBool
                                                  .indexOf(true)]
                                              .id ??
                                          -1
                                      : -1,
                                  kategorie: selectedKategorieBool
                                          .contains(true)
                                      ? selectedKategorie[
                                          selectedKategorieBool.indexOf(true)]
                                      : null,
                                );
                                context
                                    .read(transaktionNotifierProvider.notifier)
                                    .addTransaktion(transaktion);
                                context
                                    .read(calculationNotifierProvider.notifier)
                                    .setInit();

                                context
                                    .read(chartProviderNotifier.notifier)
                                    .getTotalAmount();

                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            )
                          : KeyboardKey(
                              text: "gleich",
                              onPress: () {
                                context
                                    .read(calculationNotifierProvider.notifier)
                                    .equals();

                                setState(() {
                                  isCalculationDone = true;
                                });
                              },
                            ),
                    ],
                  ),
                ],
              ),
            ),
            // Name beschreibung?
          ],
        ),
      ),
    );
  }
}
