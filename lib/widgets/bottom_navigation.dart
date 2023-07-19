import 'package:flutter/material.dart';
import 'package:money_management/pages/home%20screen/home_sreen.dart';

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, int updatedIndex, Widget? child) {
        return BottomNavigationBar(
          currentIndex: updatedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category'),
          ],
          onTap: (newIndex) {
            HomeScreen.selectedIndex.value = newIndex;
          },
        );
      },
      valueListenable: HomeScreen.selectedIndex,
    );
  }
}
