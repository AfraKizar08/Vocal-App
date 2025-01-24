import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocal_app/providers/theme_notifier.dart'; // Import the ThemeNotifier

class ThemePage extends ConsumerStatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends ConsumerState<ThemePage> {
  bool _isDarkMode = false; // Local variable to hold the theme state

  @override
  void initState() {
    super.initState();
    // Get the current theme state from the provider
    _isDarkMode = ref.read(themeProvider).isDarkMode; // Use ref instead of context
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
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
              'Theme Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Customize your app appearance by switching between light and dark modes.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // Dark Mode Switch Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                tileColor: Colors.deepPurple.withOpacity(0.1),
                title: const Text(
                  'Enable Dark Mode',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                subtitle: const Text(
                  'Switch to dark mode for a more comfortable viewing experience at night.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value; // Update local variable only
                  });
                },
                secondary: Icon(
                  _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Save Changes Button
            ElevatedButton(
              onPressed: () {
                // Save theme settings
                ref.read(themeProvider).setTheme(_isDarkMode); // Apply the saved theme
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Theme settings updated!')));
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