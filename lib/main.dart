import 'package:adventurepts/dashboard.dart';
//import 'package:adventurepts/qrcode.dart';
import 'package:adventurepts/shipments.dart';
import 'package:adventurepts/support.dart';
import 'package:adventurepts/track.dart';
import 'package:adventurepts/vehicles.dart';
import 'package:flutter/material.dart';
import 'new.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeDrawerNavigation(),
    );
  }
}

class HomeDrawerNavigation extends StatefulWidget {
  const HomeDrawerNavigation({super.key});

  @override
  State<HomeDrawerNavigation> createState() => _HomeDrawerNavigationState();
}

class _HomeDrawerNavigationState extends State<HomeDrawerNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const Shipments(),
    const Track(),
    const NewItem(),
    const Vehicles(),
    const Support(),
    Center(child: Text('Logout', style: TextStyle(fontSize: 24))),
  ];

  void _onSelectDrawerItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  void _openQrPage() {
    setState(() {
      _selectedIndex = 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: _openQrPage,
            icon: const Icon(Icons.qr_code),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.lightBlue,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                bottom: 16,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.network(
                        'https://avatars.githubusercontent.com/u/94116967?v=4',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Staff Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Arusha Office',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () => _onSelectDrawerItem(0),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Shipments'),
              onTap: () => _onSelectDrawerItem(1),
            ),
            ListTile(
              leading: const Icon(Icons.location_pin),
              title: const Text('Track Parcel'),
              onTap: () => _onSelectDrawerItem(2),
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text('New Shipment'),
              onTap: () => _onSelectDrawerItem(3),
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping),
              title: const Text('Vehicles'),
              onTap: () => _onSelectDrawerItem(4),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help and Support'),
              onTap: () => _onSelectDrawerItem(5),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _onSelectDrawerItem(6),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
