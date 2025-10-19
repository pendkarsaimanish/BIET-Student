import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:biet/features/performance/screen/performance_page.dart';
import 'package:biet/features/community/screen/community_page.dart';
import 'package:biet/features/results/screen/results_page.dart';
import 'package:biet/features/auth/screen/profile_page.dart';
import 'package:biet/features/home/screen/home_page.dart';
import 'package:flutter/material.dart';

final items = [
  CurvedNavigationBarItem(child: Icon(Icons.menu_book), label: "Results"),
  CurvedNavigationBarItem(
    child: Icon(Icons.school_outlined),
    label: "Performance",
  ),
  CurvedNavigationBarItem(child: Icon(Icons.home), label: "Home"),
  CurvedNavigationBarItem(
    child: Icon(Icons.diversity_1_outlined),
    label: "Community",
  ),
  CurvedNavigationBarItem(child: Icon(Icons.face), label: "Profile"),
];

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 2;

  final screens = [
    ResultsPage(),
    PerformancePage(),
    HomePage(),
    CommunityPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 200),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeOut,
        buttonBackgroundColor: Colors.blue[100],
        onTap: (index) => setState(() {
          this.index = index;
        }),
        index: index,
        items: items,
      ),
    );
  }
}
