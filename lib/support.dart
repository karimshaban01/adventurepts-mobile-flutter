import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => SupportState();
}

class SupportState extends State<Support> {
  final List<Map<String, dynamic>> supportItems = [
    {
      'title': 'Customer Support',
      'icon': Icons.headset_mic,
      'description': 'Contact our 24/7 customer support team',
      'action': 'tel:+1234567890',
    },
    {
      'title': 'Email Support',
      'icon': Icons.email,
      'description': 'Send us an email for detailed inquiries',
      'action': 'mailto:support@example.com',
    },
    {
      'title': 'FAQs',
      'icon': Icons.question_answer,
      'description': 'Find answers to common questions',
      'items': [
        {
          'question': 'How do I track my parcel?',
          'answer': 'You can track your parcel using the tracking number provided in your shipping confirmation email.',
        },
        {
          'question': 'What are your delivery hours?',
          'answer': 'We deliver Monday to Friday from 9 AM to 6 PM.',
        },
        {
          'question': 'How do I report a problem?',
          'answer': 'You can contact our customer support team via phone or email.',
        },
      ],
    },
  ];

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Support',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'How can we help you today?',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...supportItems.map((item) {
            if (item['items'] != null) {
              // FAQs section
              return ExpansionTile(
                leading: Icon(item['icon']),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                children: (item['items'] as List).map<Widget>((faq) {
                  return ExpansionTile(
                    title: Text(faq['question']),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(faq['answer']),
                      ),
                    ],
                  );
                }).toList(),
              );
            } else {
              // Contact options
              return Card(
                child: ListTile(
                  leading: Icon(item['icon']),
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  onTap: () => _launchUrl(item['action']),
                ),
              );
            }
          }).toList(),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Hours',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Monday - Friday: 9:00 AM - 6:00 PM'),
                  Text('Saturday: 10:00 AM - 4:00 PM'),
                  Text('Sunday: Closed'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}