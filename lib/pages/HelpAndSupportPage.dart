import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Need assistance? We are here to help!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please reach out to us through any of the following channels:',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // Contact Info Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.deepPurple),
                    title: const Text(
                      'Phone: +1 234 567 890',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text('Available Monday to Friday, 9 AM - 6 PM'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.deepPurple),
                    title: const Text(
                      'Email: support@example.com',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text('We reply within 24 hours'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.chat, color: Colors.deepPurple),
                    title: const Text(
                      'Live Chat',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text('Chat with our support agents'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Contact Support Button
            ElevatedButton(
              onPressed: () {
                // Implement contact form or chat feature here
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contacting Support')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Contact Support',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            const SizedBox(height: 40),

            // Additional Information Section
            const Text(
              'Additional Information:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'For urgent requests, please call us directly. Otherwise, you can send an email or use the live chat feature for quicker responses.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),


          ],
        ),
      ),
    );
  }
}
