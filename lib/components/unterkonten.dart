import 'dart:math';

import 'package:finanz_app/models/konten.dart';
import 'package:finanz_app/screens/add_konto_page.dart';
import 'package:finanz_app/state_notifier/konten_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Unterkonten extends StatelessWidget {
  final Konten konto;

  const Unterkonten({Key? key, required this.konto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (konto.type != KontoType.addButton) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Color(konto.color),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                konto.name,
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                konto.insgesamt.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else {
      return ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shadowColor:
              MaterialStateProperty.all(Colors.transparent.withOpacity(0.1)),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              return states.contains(MaterialState.pressed)
                  ? Colors.blue
                  : null;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(
                color: Colors.blue,
                width: 3,
              ),
            ),
          ),
        ),
        onPressed: () {
          Konten test = Konten(
            name: "Test",
            type: KontoType.konto,
            insgesamt: 600,
            isHauptKonto: false,
            // TODO: choose your own color or it would be random (not completly random from a definde color list)
            color: Colors
                .primaries[Random().nextInt(Colors.primaries.length)].value,
            // TODO: function to get lenght of the current list
            //? konto.order ist schon die länge die ich von oben übergebe
            order: konto.order,
          );
          context.read(kontenNotifierProvider.notifier).add(test);
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.add, color: Colors.black),
              Text(
                "Konto hinzufügen",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class Unterkonten2 extends StatelessWidget {
  final Konten konto;

  const Unterkonten2({Key? key, required this.konto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (konto.type != KontoType.addButton) {
      return Container(
        // padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(konto.color),
          // TODO: Inner shadow
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0.1, 0.1), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                konto.name,
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                "${konto.insgesamt}€",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shadowColor:
              MaterialStateProperty.all(Colors.transparent.withOpacity(0.1)),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              return states.contains(MaterialState.pressed)
                  ? Colors.blue
                  : null;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(
                color: Colors.blue,
                width: 3,
              ),
            ),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
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
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Wrap(
                      children: const [
                        AddKontoPage(),
                      ],
                    ),
                  ),
                );
              });
          // Konten test = Konten(
          //   name: "Test",
          //   type: KontoType.konto,
          //   insgesamt: 600,
          //   isHauptKonto: false,
          //   // TODO: choose your own color or it would be random (not completly random from a definde color list)
          //   color: Colors
          //       .primaries[Random().nextInt(Colors.primaries.length)].value,
          //   // TODO: function to get lenght of the current list
          //   //? konto.order ist schon die länge die ich von oben übergebe
          //   order: konto.order,
          // );
          // context.read(kontenNotifierProvider.notifier).add(test);
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.add, color: Colors.black),
              Text(
                "Konto ",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }
  }
}
