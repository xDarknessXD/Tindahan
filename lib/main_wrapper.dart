import 'package:flutter/material.dart';
import 'features/home.dart';
import 'features/inventory.dart';
import 'features/report.dart';
import 'features/scanner.dart';
import 'features/utang.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const InventoryPage(),
    const ScannerPage(),
    const UtangPage(),
    const ReportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(top: 4),
          height: 90, // Fixed height for the white bar
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 223, 223, 223),
              width: 1,
            ), // Invisible border to prevent overflow
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(71, 0, 0, 0),
                blurRadius: 15,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              iconSize: 28,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              selectedItemColor: const Color(0xFF00A34D),
              // unselectedItemColor: Colors.grey,

              // Removes the jumpy text behavior
              selectedFontSize: 10,
              unselectedFontSize: 10,

              showSelectedLabels: true,
              showUnselectedLabels: true,

              selectedIconTheme: const IconThemeData(
              ),

              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),

              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight
                    .bold, // Use FontWeight.normal if only selected should be bold
              ),

              items: [
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.house),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(LucideIcons.package),
                  label: 'Inventory',
                ),

                // --- THE CUSTOM MIDDLE ITEM ---
                BottomNavigationBarItem(
                  label: '',
                  icon: Transform.translate(
                    offset: const Offset(0, 0), // Lift it up
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.only(top: 0), // Lift it up
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A34D), // The POS Green
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // Matches your image "squircle"
                      ),
                      child: const Icon(
                        LucideIcons.scanLine,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),

                // ------------------------------
                const BottomNavigationBarItem(
                  icon: Icon(LucideIcons.handCoins),
                  label: 'Utang',
                ),

                const BottomNavigationBarItem(
                  icon: Icon(LucideIcons.chartColumn),
                  label: 'Report',
                  tooltip: 'Report',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
