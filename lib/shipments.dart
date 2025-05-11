import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Shipments extends StatefulWidget {
  const Shipments({super.key});

  @override
  State<Shipments> createState() => ShipmentsState();
}

class ShipmentsState extends State<Shipments> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> parcels = []; // This will store your parcels
  List<Map<String, dynamic>> filteredParcels = [];

  @override
  void initState() {
    super.initState();
    // TODO: Fetch parcels from API
    // For now, using dummy data
    parcels = [
      {
        'id': '1',
        'sender': 'John Doe',
        'receiver': 'Jane Smith',
        'status': 'In Transit',
        'weight': '2.5kg',
      },
      // Add more dummy data as needed
    ];
    filteredParcels = parcels;
  }

  void _filterParcels(String query) {
    setState(() {
      filteredParcels = parcels.where((parcel) {
        return parcel['sender'].toLowerCase().contains(query.toLowerCase()) ||
            parcel['receiver'].toLowerCase().contains(query.toLowerCase()) ||
            parcel['id'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showQRCode(String parcelId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('QR Code for Parcel #$parcelId'),
        content: SizedBox(
          width: 200,
          height: 200,
          child: QrImageView(
            data: parcelId,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _printParcel(String parcelId) {
    // TODO: Implement printing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Printing parcel #$parcelId')),
    );
  }

  void _viewParcelDetails(String parcelId) {
    // TODO: Navigate to parcel details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing details for parcel #$parcelId')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipments'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search parcels',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterParcels('');
                  },
                ),
              ),
              onChanged: _filterParcels,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredParcels.length,
              itemBuilder: (context, index) {
                final parcel = filteredParcels[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    title: Text('Parcel #${parcel['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From: ${parcel['sender']}'),
                        Text('To: ${parcel['receiver']}'),
                        Text('Status: ${parcel['status']}'),
                        Text('Weight: ${parcel['weight']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () => _viewParcelDetails(parcel['id']),
                          tooltip: 'View Details',
                        ),
                        IconButton(
                          icon: const Icon(Icons.print),
                          onPressed: () => _printParcel(parcel['id']),
                          tooltip: 'Print',
                        ),
                        IconButton(
                          icon: const Icon(Icons.qr_code),
                          onPressed: () => _showQRCode(parcel['id']),
                          tooltip: 'Show QR Code',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}