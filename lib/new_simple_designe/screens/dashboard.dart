import 'package:flutter/material.dart';

import '../components/dashboard_drawer.dart';
import '../components/konten_and_unterkonten.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      drawer: const DashboardDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: const [
                    KontenAndUnterkonten(),
                    SizedBox(height: 20),
                    // FinanzInfoCard(),
                    // const SizedBox(height: 20),
                    // TransactionsCard(), // Only show the last 5 transactions
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
