import 'package:flutter/material.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({super.key});

  @override
  State<Vehicles> createState() => VehiclesState();
}

class VehiclesState extends State<Vehicles> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleNumberController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _vehicleCapacityController = TextEditingController();
  
  List<Map<String, dynamic>> vehicles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        vehicles = [
          {
            'id': '1',
            'number': 'ABC123',
            'type': 'Van',
            'capacity': '1000kg',
            'status': 'Available'
          },
          // Add more dummy data as needed
        ];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading vehicles: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showAddVehicleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Vehicle'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _vehicleNumberController,
                decoration: const InputDecoration(
                  labelText: 'Vehicle Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _vehicleTypeController,
                decoration: const InputDecoration(
                  labelText: 'Vehicle Type',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _vehicleCapacityController,
                decoration: const InputDecoration(
                  labelText: 'Capacity (kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter capacity';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addVehicle,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _addVehicle() async {
    if (_formKey.currentState!.validate()) {
      try {
        // TODO: Replace with actual API call
        await Future.delayed(const Duration(seconds: 1));
        
        final newVehicle = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'number': _vehicleNumberController.text,
          'type': _vehicleTypeController.text,
          'capacity': '${_vehicleCapacityController.text}kg',
          'status': 'Available'
        };

        setState(() {
          vehicles.add(newVehicle);
        });

        _vehicleNumberController.clear();
        _vehicleTypeController.clear();
        _vehicleCapacityController.clear();

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vehicle added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding vehicle: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddVehicleDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(vehicle['number']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${vehicle['type']}'),
                        Text('Capacity: ${vehicle['capacity']}'),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: vehicle['status'] == 'Available'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        vehicle['status'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _vehicleTypeController.dispose();
    _vehicleCapacityController.dispose();
    super.dispose();
  }
}