import 'dart:math';

import 'package:finanz_app/core/functions.dart';
import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:finanz_app/state_notifier/chart_notifier.dart';
import 'package:finanz_app/state_notifier/konten_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddKontoPage extends StatefulWidget {
  const AddKontoPage({super.key});

  @override
  State<AddKontoPage> createState() => _AddKontoPageState();
}

class _AddKontoPageState extends State<AddKontoPage> {
  late final TextEditingController _kontoNameController =
      TextEditingController();
  late final TextEditingController _betragController = TextEditingController();
  int? selectedValue;

  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  bool wasColorPicked = false;

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // height: 100,
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Konto hinzufügen",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          DropdownButton(
            value: selectedValue,
            hint: const Text("Kontotyp wählen"),
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text("Konto/Unterkonto"),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text("Goldkonto?"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
              print(selectedValue);
              print(value);
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _kontoNameController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Konto-/Unterkonto Name',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                child: Container(
                  width: 45,
                  height: 45,
                  color: currentColor,
                ),
                onTap: () {
                  showDialog(
                    builder: (context) => AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                        ),
                        // Use Material color picker:
                        //
                        // child: MaterialPicker(
                        //   pickerColor: pickerColor,
                        //   onColorChanged: changeColor,
                        //   showLabel: true, // only on portrait mode
                        // ),
                        //
                        // Use Block color picker:
                        //
                        // child: BlockPicker(
                        //   pickerColor: currentColor,
                        //   onColorChanged: changeColor,
                        // ),
                        //
                        // child: MultipleChoiceBlockPicker(
                        //   pickerColors: currentColors,
                        //   onColorsChanged: changeColors,
                        // ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Fertig'),
                          onPressed: () {
                            setState(() {
                              currentColor = pickerColor;
                              wasColorPicked = true;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    context: context,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            width: 200,
            child: TextField(
              controller: _betragController,
              obscureText: false,
              onChanged: (value) {
                setState(() {
                  value = "$value€";
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Betrag',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              late KontoType kontoType;

              // TODO: make logic to add

              if (selectedValue == null) {
                toastMsg("Bitte wähle ein Kontotypen");
              } else {
                if (selectedValue == 0) {
                  kontoType = KontoType.konto;
                } else if (selectedValue == 1) {
                  kontoType = KontoType.edelmetallKonto;
                }
                if (_kontoNameController.text.isEmpty) {
                  toastMsg("Bitte gebe ein Kontonamen ein");
                } else {
                  if (_betragController.text.isEmpty) {
                    toastMsg("Bitte gebe ein Betrag ein");
                  }

                  // random color
                  Color randomColor = Colors
                      .primaries[Random().nextInt(Colors.primaries.length)];

                  int nextOrderInLine = context
                          .read(kontenNotifierProvider.notifier)
                          .getKontenLength() +
                      1;

                  //  all log messages in one place with new line
                  logger.d(
                      """kontotyp: $selectedValue\nkontoname: ${_kontoNameController.text}\nbetrag: ${_betragController.text}\ncolor: ${currentColor.value}\norder: $nextOrderInLine""");

                  Konten konto = Konten(
                    name: _kontoNameController.text,
                    type: kontoType,
                    isHauptKonto: false,
                    insgesamt: double.parse(_betragController.text),
                    color:
                        wasColorPicked ? currentColor.value : randomColor.value,
                    // TODO: get len of konten
                    order: nextOrderInLine,
                  );

                  context.read(kontenNotifierProvider.notifier).add(konto);
                  context.read(chartProviderNotifier.notifier).getTotalAmount();

                  Navigator.pop(context);
                }
              }
            },
            child: const Text("Hinzufügen"),
          ),
        ],
      ),
    );
  }
}
