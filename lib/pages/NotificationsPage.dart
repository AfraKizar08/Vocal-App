import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _emailNotifications = true;
  bool _pushNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
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
              'Manage Your Notifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'You can choose the type of notifications you would like to receive. Enable or disable them according to your preferences.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // Email Notifications Switch
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                tileColor: Colors.deepPurple.withOpacity(0.1),
                title: const Text(
                  'Email Notifications',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                subtitle: const Text(
                  'Get notified via email for important updates.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                value: _emailNotifications,
                onChanged: (value) {
                  setState(() {
                    _emailNotifications = value;
                  });
                },
                secondary: const Icon(
                  Icons.email,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Push Notifications Switch
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                tileColor: Colors.deepPurple.withOpacity(0.1),
                title: const Text(
                  'Push Notifications',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                subtitle: const Text(
                  'Receive real-time notifications on your device.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
                secondary: const Icon(
                  Icons.notifications,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Save notifications preferences
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preferences updated!')));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Preferences',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
