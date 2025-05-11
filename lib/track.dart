import 'package:flutter/material.dart';

class Track extends StatefulWidget {
  const Track({super.key});

  @override
  State<Track> createState() => TrackState();
}

class TrackState extends State<Track> {
  final _trackingController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _trackingResult;

  Future<void> _trackParcel() async {
    if (_trackingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a tracking ID')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _trackingResult = null;
    });

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      setState(() {
        _trackingResult = {
          'trackingId': _trackingController.text,
          'status': 'In Transit',
          'location': 'Warehouse A',
          'lastUpdate': DateTime.now().toString(),
          'estimatedDelivery': '2024-05-15',
        };
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error tracking parcel: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Parcel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _trackingController,
              decoration: InputDecoration(
                labelText: 'Enter Tracking ID',
                hintText: 'e.g., ABC123456789',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _trackingController.clear(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _trackParcel,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Track Parcel'),
            ),
            const SizedBox(height: 24),
            if (_trackingResult != null) ...[
              const Text(
                'Tracking Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTrackingDetail('Tracking ID', _trackingResult!['trackingId']),
                      _buildTrackingDetail('Status', _trackingResult!['status']),
                      _buildTrackingDetail('Current Location', _trackingResult!['location']),
                      _buildTrackingDetail('Last Update', _trackingResult!['lastUpdate']),
                      _buildTrackingDetail('Estimated Delivery', _trackingResult!['estimatedDelivery']),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }
}