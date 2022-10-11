import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:flutter/material.dart';

class TransaktionTile extends StatelessWidget {
  final Transaktion transaktion;
  final int index;

  const TransaktionTile(
      {Key? key, required this.transaktion, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String formatted = formatter.format(transaktion.datum);

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      width: double.infinity,
      height: 56,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 8),
          const Positioned(
            // TODO: center vertically
            left: 8,
            child: CircleAvatar(
              child: Icon(Icons.home),
            ),
          ),
          Positioned(
            // TODO: center vertically
            left: 56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaktion.name ?? transaktion.kategorie.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                transaktion.vorgangsType == VorgangsType.dauerauftrag
                    ? Row(
                        children: [
                          const Icon(
                            Icons.loop,
                            size: 10,
                          ),
                          Text(
                            transaktion.vonKontoId.toString(),
                          ),
                        ],
                      )
                    : Text(
                        transaktion.vorgangsType == VorgangsType.ueberweisung
                            ? transaktion.vonKontoId.toString()
                            : transaktion.vorgangsType == VorgangsType.transfer
                                ? "${transaktion.vonKontoId} -> ${transaktion.nachKontoId}"
                                : "Error",
                        style: const TextStyle(fontSize: 12, color: grey),
                      ),
              ],
            ),
          ),
          Positioned(
            // TODO: center vertically
            right: 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${transaktion.betrag.toString().replaceAll(".", ",")}€",
                    style: TextStyle(
                        fontSize: 16,
                        color: transaktion.transaktionsType ==
                                TransaktionsType.einnahme
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatted,
                    style: const TextStyle(fontSize: 12, color: grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ListTile(
      //   onTap: () {},
      //   leading: const CircleAvatar(
      //     child: Icon(Icons.home),
      //   ),
      //   // TODO: name of enum
      //   title: Text(transaktion.name ?? transaktion.kategorie.toString()),
      //   subtitle: transaktion.vorgangsType == VorgangsType.ueberweisung
      //       // TODO: get name of konto
      //       ? Text("${transaktion.vonKontoId}")
      //       : Text("${transaktion.vonKontoId} -> ${transaktion.nachKontoId}"),
      //   trailing: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [
      //       Text(
      //         "${transaktion.betrag.toString().replaceAll(".", ",")}€",
      //         style: TextStyle(
      //           color: transaktion.transaktionsType == TransaktionsType.einnahme
      //               ? Colors.green
      //               : Colors.red,
      //         ),
      //       ),
      //       Text(formatted),
      //     ],
      //   ),
      // ),
    );
  }
}
