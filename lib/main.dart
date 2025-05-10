import 'package:flutter/material.dart';

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
    Center(child: Text('Dashboard', style: TextStyle(fontSize: 24))),
    Center(child: Text('Shipments', style: TextStyle(fontSize: 24))),
    Center(child: Text('Track Parcel', style: TextStyle(fontSize: 24))),
    Center(child: Text('New Shipment', style: TextStyle(fontSize: 24))),
    Center(child: Text('Vehicles', style: TextStyle(fontSize: 24))),
    Center(child: Text('Help and Support', style: TextStyle(fontSize: 24))),
    Center(child: Text('Logout', style: TextStyle(fontSize: 24))),
    Center(child: Text('QR Code Scanner Page', style: TextStyle(fontSize: 24))), // New QR Page
  ];

  void _onSelectDrawerItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close drawer
  }

  void _openQrPage() {
    setState(() {
      _selectedIndex = 7; // Index of QR page in _pages
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
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: _openQrPage,
            icon: Icon(Icons.qr_code),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: [
            DrawerHeader(
              child: Image.network(
                  'https://avatars.githubusercontent.com/u/94116967?v=4'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              onTap: () => _onSelectDrawerItem(0),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Shipments'),
              onTap: () => _onSelectDrawerItem(1),
            ),
            ListTile(
              leading: Icon(Icons.location_pin),
              title: Text('Track Parcel'),
              onTap: () => _onSelectDrawerItem(2),
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('New Shipment'),
              onTap: () => _onSelectDrawerItem(3),
            ),
            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text('Vehicles'),
              onTap: () => _onSelectDrawerItem(4),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help and Support'),
              onTap: () => _onSelectDrawerItem(5),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _onSelectDrawerItem(6),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
