import 'package:finanz_app/core/globals.dart';
import 'package:finanz_app/models/konten.dart';
import 'package:finanz_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/transaktions_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(KontenAdapter());
  Hive.registerAdapter(TransaktionAdapter());
  Hive.registerAdapter(KontoTypeAdapter());
  Hive.registerAdapter(VorgangsTypeAdapter());
  Hive.registerAdapter(TransaktionsTypeAdapter());
  Hive.registerAdapter(KategorieAdapter());

  await Hive.openBox(hiveKontenBox);
  await Hive.openBox(hiveTransaktionBox);
  await Hive.openBox(hiveKategorieBox);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          "/": (context) => const HomePage(),
          // "/addTransaktionPage": (context) => const AddTransaktionPage(),
          "/transaktionPage": (context) => const TransaktionPage(),
        },
      ),
    );
  }
}





// TODO: Delete singel Konto 
// TODO: Delete singel transaktion
// TODO: Mark Konto as Hauptkonto
// TODO: Hauptkonto are shown on top
// TODO: Change transaktion icon based on kategorie
// TODO: See details of a transaktion (like: date, amount, etc.)
// TODO: add Dauerauftrag and transfer and also make dauertransfer
