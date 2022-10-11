import 'package:finanz_app/components/pieChart.dart';
import 'package:finanz_app/core/globals.dart';
import 'package:flutter/material.dart';

void main() => runApp(const InfoCard());

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: primary2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  text: "Insgesamt: ",
                  style: TextStyle(
                    fontSize: 18,
                    color: white,
                  ),
                  children: [
                    TextSpan(
                      text: '6000,25€',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Einnahmen: ",
                        style: TextStyle(color: white, fontSize: 14),
                      ),
                      const Text(
                        "6000,25€",
                        style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Ausgabe: ",
                        style: TextStyle(color: white, fontSize: 14),
                      ),
                      const Text(
                        "150,25€",
                        style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // ? Dont work container with green/red gets streched out
              // SizedBox(
              //   width: 200,
              //   child: Table(
              //     defaultVerticalAlignment:
              //         TableCellVerticalAlignment.middle,
              //     children: [
              //       TableRow(
              //         children: [
              //           TableCell(

              //             child: Container(
              //               width: 10,
              //               height: 10,
              //               color: Colors.green,
              //             ),
              //           ),
              //           const Text(
              //             "Einnahmen: ",
              //             style: TextStyle(color: white, fontSize: 12),
              //           ),
              //           const Text(
              //             "6000,25€",
              //             style: TextStyle(
              //                 color: white,
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          const Positioned(
            right: 16,
            top: 8,
            width: 130,
            height: 130,
            child: Chart(),
          ),
          Positioned(
            top: -8,
            right: -16,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.zoom_out_map_rounded,
                color: second,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
