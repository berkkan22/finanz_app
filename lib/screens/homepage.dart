import 'package:finanz_app/components/floatingButton.dart';
import 'package:finanz_app/components/infoCard.dart';
import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:finanz_app/screens/add_transaktion_page.dart';
import 'package:finanz_app/screens/konten_consumer.dart';
import 'package:finanz_app/screens/transaktion_consumer.dart';
import 'package:finanz_app/state_notifier/chart_notifier.dart';
import 'package:finanz_app/state_notifier/transaktion_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:custom_floating_action_button/custom_floating_action_button.dart';

import '../state_notifier/konten_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read(kontenNotifierProvider.notifier).getFromDB();
    context.read(transaktionNotifierProvider.notifier).getFromDB();
    context.read(chartProviderNotifier.notifier).getTotalAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFloatingActionButton(
      body: Scaffold(
        key: _globalKey,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Delete Konten'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  context.read(kontenNotifierProvider.notifier).deletedAll();
                },
              ),
              ListTile(
                title: const Text('Delete Transaktion'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  context
                      .read(transaktionNotifierProvider.notifier)
                      .deletedAll();
                },
              ),
              ListTile(
                title: const Text('Dashboard'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Arbeitszeiten'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Goldkurs'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Spenden (Zekat) rechner'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        // appBar: AppBar(
        //   title: const Text("Finanz App"),
        //   leading: IconButton(
        //     onPressed: () {
        //       // REMOVE_LATER: Dummy function to deleted Hive Boxes
        //       context.read(kontenNotifierProvider.notifier).deletedAll();
        //       context.read(transaktionNotifierProvider.notifier).deletedAll();
        //     },
        //     icon: const Icon(Icons.menu),
        //   ),
        // ),
        body: Container(
          // color: primary, // Status bar color
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: Stack(
                      children: [
                        Container(
                          // padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          height: 285,
                          decoration: const BoxDecoration(
                            // color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment(0, -1),
                              end: Alignment(0, 1.6),
                              colors: <Color>[
                                primary,
                                white,
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _globalKey.currentState?.openDrawer();
                                },
                                icon: const Icon(Icons.menu),
                                color: white,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Liste der Konten",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: second,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const KontenConsumer(),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          alignment: const Alignment(0, 0.99),
                          child: const InfoCard(),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TransaktionConsumer(),
                  //     Container(
                  //       // padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  //       color: const Color(0xFFf6f7f1),
                  //       child: SingleChildScrollView(
                  //         child: Column(
                  //           children: [
                  //             const KontenConsumer(),
                  //             const SizedBox(height: 16),
                  //             // TODO: Einnhamen und ausgaben insgesamt
                  //             Container(
                  //               padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  //               child: const InfoCard(),
                  //             ),
                  //             const SizedBox(height: 16),
                  //             const TransaktionConsumer(),
                  //             // TODO: show only 5 transaktion you can clap out and on tab ob title you can see everythin
                  //             const SizedBox(height: 100),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                ],
              ),
            ),
          ),
        ),
      ),
      // TODO: dismiss after pressed
      options: [
        FloatingButton(
          title: "Überweisung",
          icon: const Icon(Icons.arrow_forward_rounded),
          onPress: () {
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
                    child: Wrap(
                      children: [
                        AddTransaktionPage(
                            kontenList: context
                                .read(kontenNotifierProvider.notifier)
                                .getKonten()),
                      ],
                    ),
                  );
                });
            // Navigator.pushNamed(
            //   context,
            //   "/addTransaktionPage",
            //   arguments: VorgangsType.ueberweisung,
            // );
          },
        ),
        FloatingButton(
          title: "Transfer",
          icon: const Icon(Icons.compare_arrows_rounded),
          onPress: () {
            // Navigator.pushNamed(
            //   context,
            //   "/addTransaktionPage",
            //   arguments: VorgangsType.transfer,
            // );
          },
        ),
        FloatingButton(
          title: "Dauerauftrag",
          icon: const Icon(Icons.loop_rounded),
          onPress: () {
            Navigator.pushNamed(
              context,
              "/addTransaktionPage",
              arguments: VorgangsType.dauerauftrag,
            );
          },
        ),
      ],
      type: CustomFloatingActionButtonType.verticalUp,
      spaceFromBottom: 16,
      openFloatingActionButton: const Icon(Icons.add),
      closeFloatingActionButton: const Icon(Icons.close),
      barrierDismissible: true,
    );
  }
}
