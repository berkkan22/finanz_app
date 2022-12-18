import 'package:flutter/material.dart';

import '../../core/globals.dart';
import '../core/styles.dart';

class KontenAndUnterkonten extends StatefulWidget {
  const KontenAndUnterkonten({super.key});

  @override
  State<KontenAndUnterkonten> createState() => _KontenAndUnterkontenState();
}

class _KontenAndUnterkontenState extends State<KontenAndUnterkonten> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Liste der Hauptkonten",
            style: titleStyle,
          ),
          const SizedBox(height: 10),
          const Hauptkonten(),
          const SizedBox(height: 10),
          Text(
            "Liste der Unterkonten",
            style: titleStyle,
          ),
          const SizedBox(height: 10),
          const UnterKonten()
        ],
      ),
    );
  }
}

class Hauptkonten extends StatefulWidget {
  const Hauptkonten({super.key});

  @override
  State<Hauptkonten> createState() => _HauptkontenState();
}

class _HauptkontenState extends State<Hauptkonten> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 16,
        runSpacing: 16,
        children: const [
          KontoButton(
            name: "Hauptkonto",
            value: 9000,
          ),
          KontoButtonAdd(),
        ],
      ),
    );
  }
}

class UnterKonten extends StatefulWidget {
  const UnterKonten({super.key});

  @override
  State<UnterKonten> createState() => _UnterKontenState();
}

class _UnterKontenState extends State<UnterKonten> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 16,
        runSpacing: 16,
        children: const [
          KontoButton(name: "Tagesgeldkonto", value: 3500),
          KontoButton(name: "Urlaub", value: 500),
          KontoButton(name: "Fixkosten", value: 180),
          KontoButton(name: "Auto", value: 1050),
          KontoButtonAdd(),
        ],
      ),
    );
  }
}

class KontoButton extends StatefulWidget {
  final String name;
  final double value;

  const KontoButton({super.key, required this.name, required this.value});

  @override
  State<KontoButton> createState() => _KontoButtonState();
}

class _KontoButtonState extends State<KontoButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: !selected ? Colors.blue : Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () {
          logger.d("KontoButton: ${widget.name}");
          setState(() {
            selected = !selected;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.name),
            Text("${widget.value}€"),
          ],
        ),
      ),
    );
  }
}

class KontoButtonAdd extends StatelessWidget {
  const KontoButtonAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      // TODO: Fix width normaly 120
      width: 130,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // TODO: Fix color normaly Colors.white
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(
              color: Colors.blue,
              width: 3,
            ),
          ),
        ),
        onPressed: () {
          logger.d("Konto hinzufügen");
          addKontoBottomSheet(context);
        },
        child: Row(
          children: const [
            Icon(Icons.add, color: Colors.black),
            Center(
              child: Text(
                "Konto\nhinzufügen",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> addKontoBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: const [
              Text("data"),
            ],
          ),
        ),
      );
    },
  );
}
