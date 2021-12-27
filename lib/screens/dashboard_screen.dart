import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/home.png",
                  height: 24,
                  width: 24,
                  color: selectedIndex == 0
                      ? Colors.deepOrange
                      : Colors
                          .grey, // this color is used for because we don't have active and inactive icon
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(fontSize: 8),
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/talk.png",
                  height: 24,
                  width: 24,
                  color: selectedIndex == 1 ? Colors.deepOrange : null,
                ),
                title: const Text(
                  "Talk to Astrologer",
                  style: TextStyle(fontSize: 8),
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/ask.png",
                  height: 24,
                  width: 24,
                  color: selectedIndex == 2 ? Colors.deepOrange : null,
                ),
                title: const Text(
                  "Ask Question",
                  style: TextStyle(fontSize: 8),
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/reports.png",
                  height: 24,
                  width: 24,
                  color: selectedIndex == 3 ? Colors.deepOrange : null,
                ),
                title: const Text(
                  "Reports",
                  style: const TextStyle(fontSize: 8),
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/talk.png",
                  height: 24,
                  width: 24,
                  color: selectedIndex == 4 ? Colors.deepOrange : null,
                ),
                title: const Text(
                  "Chat with Astrologer",
                  style: TextStyle(fontSize: 8),
                )),
          ]),
    );
  }
}
