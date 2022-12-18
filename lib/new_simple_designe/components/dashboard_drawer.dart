import 'package:flutter/material.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {},
          ),
          ListTile(
            title: const Text('Delete Transaktion'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Arbeitszeiten'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Goldkurs'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Spenden (Zekat) rechner'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
