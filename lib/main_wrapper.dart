import 'package:flutter/material.dart';
import 'features/home.dart';
import 'features/inventory.dart';
import 'features/report.dart';
import 'features/scanner.dart';
import 'features/utang.dart';

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
    const ReportPage(),
    const UtangPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 85, // Fixed height for the white bar
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: BottomNavigationBar(
              iconSize: 30,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              selectedItemColor: const Color(0xFF00A34D),
              unselectedItemColor: Colors.grey,
              // Removes the jumpy text behavior
              selectedFontSize: 0,
              unselectedFontSize: 0,

              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  label: 'Inventory',
                ),

                // --- THE CUSTOM MIDDLE ITEM ---
                BottomNavigationBarItem(
                  label: 'Scanner',
                  icon: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00A34D), // The POS Green
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Matches your image "squircle"
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                // ------------------------------
                const BottomNavigationBarItem(
                  icon: Icon(Icons.handshake_outlined),
                  label: 'Utang',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Report',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
