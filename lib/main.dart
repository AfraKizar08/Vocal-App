import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocal_app/pages/favourites_page.dart';
import 'pages/home_page.dart' as home;
import 'pages/profile_page.dart';
import 'pages/search_page.dart';
import 'pages/upload_page.dart';
import 'pages/playlist_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const ProviderScope(child: VocalsOnlyMusicApp()));
}

class VocalsOnlyMusicApp extends StatelessWidget {
  const VocalsOnlyMusicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocals Only Music',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/main': (context) => const MainScreen(),
        '/favourites': (context) => const FavouritesPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    home.HomePage(),
    SearchPage(),
    UploadPage(),
    PlaylistPage(),
    FavouritesPage(),
    ProfilePage(),

  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: 'Playlists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

        ],
      ),
    );
  }
}
