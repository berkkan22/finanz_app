import 'package:finanz_app/components/transaktion.dart';
import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:finanz_app/state_notifier/transaktion_notifier.dart';
import 'package:flutter/material.dart';

class TransaktionPage extends StatelessWidget {
  final List<Transaktion>? transaktionsList;
  final transaktionState;

  const TransaktionPage({
    Key? key,
    required this.transaktionState,
    this.transaktionsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: primary2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Letzen Transaktionen",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
              ),
              // TODO: vllt. elevatedbutton oder textbutton
              IconButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                constraints: const BoxConstraints(),
                // TODO: add ripple effect
                highlightColor: Colors.red,
                splashRadius: 20,
                onPressed: () {
                  debugPrint("Show more");
                },
                icon: const Icon(
                  Icons.zoom_out_map_rounded,
                  color: second,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          transaktionState is TransaktionInitialState
              ? const Text(
                  "Es stehen noch keine Transaktionen an!",
                  style: TextStyle(
                    color: white,
                  ),
                )
              : transaktionState is TransaktionLoadingState
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      // TODO: height anpassen weil es zum ende hin weniger wird
                      height: transaktionsList!.length <= 4
                          ? 20 + (70 * transaktionsList!.length).toDouble()
                          : 370,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transaktionsList!.length <= 4
                            ? transaktionsList!.length
                            : 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TransaktionTile(
                                transaktion: transaktionsList![index],
                                index: index,
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

// ExpansionPanelList(
//   children: [
//     ExpansionPanel(
//       canTapOnHeader: true,
//       headerBuilder: (context, isOpen) {
//         return const TransaktionTile();
//       },
//       body: const Text("World"),
//       isExpanded: _isOpen[0],
//     ),
//   ],
//   expansionCallback: (i, isOpen) => setState(() {
//     _isOpen[i] = !isOpen;
//   }),
// ),


// GridView.builder(
//   shrinkWrap: true,
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 1,
//     childAspectRatio: 5,
//     // mainAxisSpacing: 10.0,
//     // crossAxisSpacing: 10.0,
//   ),
//   itemCount: 10,
//   itemBuilder: (context, index) {
//     return ExpansionPanel(headerBuilder: headerBuilder, body: body)
//   },
// );