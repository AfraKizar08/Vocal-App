import 'package:flutter/material.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);

  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool _isProfilePrivate = true;
  bool _isLastSeenVisible = false; // New privacy option for Last Seen status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
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
              'Privacy Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Control your profile visibility. You can make your profile private and control the visibility of your Last Seen status.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // Profile Privacy Switch
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                tileColor: Colors.deepPurple.withOpacity(0.1),
                title: const Text(
                  'Make Profile Private',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                subtitle: const Text(
                  'When enabled, only you can view your profile.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                value: _isProfilePrivate,
                onChanged: (value) {
                  setState(() {
                    _isProfilePrivate = value;
                  });
                },
                secondary: const Icon(
                  Icons.lock,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Last Seen Visibility Switch
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                tileColor: Colors.deepPurple.withOpacity(0.1),
                title: const Text(
                  'Show Last Seen',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                subtitle: const Text(
                  'When enabled, your Last Seen status will be visible to others.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                value: _isLastSeenVisible,
                onChanged: (value) {
                  setState(() {
                    _isLastSeenVisible = value;
                  });
                },
                secondary: const Icon(
                  Icons.visibility,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Save Settings Button
            ElevatedButton(
              onPressed: () {
                // Save privacy settings
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Privacy settings updated!')));
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
                'Save Settings',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
