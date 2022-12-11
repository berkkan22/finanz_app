import 'package:finanz_app/components/pieChart.dart';
import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/state_notifier/chart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const InfoCard());

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final chartState = watch(chartProviderNotifier);

        if (chartState is ChartLoadedState) {
          return Container(
            width: double.infinity,
            height: 160,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: primary2,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 0.1), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Insgesamt: ",
                        style: const TextStyle(
                          fontSize: 18,
                          color: white,
                        ),
                        children: [
                          TextSpan(
                            text: chartState.total[0].toString(),
                            style: const TextStyle(
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
                            Text(
                              chartState.total[1].toString(),
                              style: const TextStyle(
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
                            Text(
                              chartState.total[2].toString(),
                              style: const TextStyle(
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
                Positioned(
                  right: 16,
                  top: 8,
                  width: 130,
                  height: 130,
                  child: chartState.total[1] != 0 || chartState.total[2] != 0
                      ? Chart(data: chartState.total)
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(height: 8),
                              Text(
                                "Keine Daten vorhanden",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
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
        } else if (chartState is ChartErrorState) {
          logger.e("Error: ${chartState.error}");
          return const Text("Ein Fehler ist aufgetreten");
        } else if (chartState is ChartLoadingState) {
          return const CircularProgressIndicator();
        } else {
          return const Text("Es ist ein großer Fehler aufgetreten");
        }
      },
    );
  }
}
