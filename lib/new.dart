import 'package:flutter/material.dart';

class NewItem extends StatefulWidget{
  const NewItem({super.key});

  @override
  State<NewItem> createState() => NewItemState();
}

class NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderPhoneController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverPhoneController = TextEditingController();
  final TextEditingController parcelWeightController = TextEditingController();
  final TextEditingController parcelDescriptionController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Replace with your API endpoint
        const String apiUrl = 'YOUR_API_ENDPOINT';
        
        final Map<String, dynamic> formData = {
          'sender': {
            'name': senderNameController.text,
            'phone': senderPhoneController.text,
          },
          'receiver': {
            'name': receiverNameController.text,
            'phone': receiverPhoneController.text,
          },
          'parcel': {
            'weight': parcelWeightController.text,
            'description': parcelDescriptionController.text,
          }
        };

        // Add your API call here
        // Example:
        // final response = await http.post(Uri.parse(apiUrl), body: jsonEncode(formData));
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Parcel information submitted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting form: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Parcel'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sender Information
              const Text('Sender Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextFormField(
                controller: senderNameController,
                decoration: const InputDecoration(
                  labelText: 'Sender Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sender name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: senderPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Sender Phone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sender phone';
                  }
                  return null;
                },
              ),
              
              // Receiver Information
              const SizedBox(height: 20),
              const Text('Receiver Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextFormField(
                controller: receiverNameController,
                decoration: const InputDecoration(
                  labelText: 'Receiver Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter receiver name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: receiverPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Receiver Phone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter receiver phone';
                  }
                  return null;
                },
              ),
              
              // Parcel Information
              const SizedBox(height: 20),
              const Text('Parcel Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextFormField(
                controller: parcelWeightController,
                decoration: const InputDecoration(
                  labelText: 'Parcel Weight (kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter parcel weight';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: parcelDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Parcel Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter parcel description';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    senderNameController.dispose();
    senderPhoneController.dispose();
    receiverNameController.dispose();
    receiverPhoneController.dispose();
    parcelWeightController.dispose();
    parcelDescriptionController.dispose();
    super.dispose();
  }
}