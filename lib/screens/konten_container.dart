import 'package:finanz_app/components/unterkonten.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:flutter/material.dart';

class KontenContainer extends StatelessWidget {
  final List<Konten> kontenList;

  const KontenContainer({
    Key? key,
    required this.kontenList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      decoration: const BoxDecoration(
        color: Color(0xFF6E21D1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Liste der Konten",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                constraints: const BoxConstraints(),
                // TODO: add ripple effect
                highlightColor: Colors.red,
                splashRadius: 20,
                onPressed: () {
                  debugPrint("Settings");
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.7,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: kontenList.length + 1,
            itemBuilder: (context, index) {
              return Unterkonten(
                konto: index < kontenList.length
                    ? kontenList[index]
                    : Konten(
                        name: "Add Konto",
                        type: KontoType.addButton,
                        insgesamt: 0,
                        isHauptKonto: false,
                        color: Colors.red.value,
                        order: kontenList.length,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class KontenContainer2 extends StatelessWidget {
  final List<Konten> kontenList;

  const KontenContainer2({
    Key? key,
    required this.kontenList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: kontenList.length + 1,
            itemBuilder: (context, index) {
              return Unterkonten2(
                konto: index < kontenList.length
                    ? kontenList[index]
                    : Konten(
                        name: "Add Konto",
                        type: KontoType.addButton,
                        insgesamt: 0,
                        isHauptKonto: false,
                        color: Colors.red.value,
                        order: kontenList.length,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
