import 'package:flutter/material.dart';

import '../../../core/widgets/custom_bottom_nav.dart';
import '../../journaling/presentation/journaling_page.dart';
import '../../history/presentation/history_page.dart';
import '../../profile/presentation/profile_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;

  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const HomePage(),
    const JournalingPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;
  }

  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF2EEF9),

      body: Stack(
        children: [

          IndexedStack(index: _currentIndex, children: _pages),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
