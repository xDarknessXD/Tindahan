import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  late Animation<double> _headerAnim;
  late Animation<double> _actionsAnim;
  late Animation<double> _alertsAnim;
  late Animation<double> _chartAnim;

  // Custom colors
  final Color primaryColor = const Color(0xFF00A14E);
  final Color primarySoft = const Color(0xFFE8F5E9);
  final Color warningColor = Colors.orange;
  final Color brownSoft = const Color(0xFFF5F0EB);
  final Color brownColor = const Color(0xFF795548);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Staggered intervals for each section to slide in sequentially
    _headerAnim = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic));
    _actionsAnim = CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic));
    _alertsAnim = CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic));
    _chartAnim = CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic));

    // Start the animation on load
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helper to wrap sections in a fade & slide animation
  Widget _buildAnimatedBlock(Widget child, Animation<double> animation, {double slideDistance = 30}) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, slideDistance * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Animated Header
            _buildAnimatedBlock(
              Container(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryColor, const Color.fromARGB(255, 0, 105, 42)],
                  ),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Magandang umaga,", style: TextStyle(color: Colors.white70, fontSize: 12)),
                            Text("Aling Nena's Store 🛍️", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 40, width: 40,
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), shape: BoxShape.circle),
                              child: const Icon(LucideIcons.bell, color: Colors.white, size: 20),
                            ),
                            Positioned(
                              top: 8, right: 8,
                              child: Container(
                                height: 8, width: 8,
                                decoration: BoxDecoration(color: warningColor, shape: BoxShape.circle),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Sales Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("TODAY'S SALES", style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Number Counting Animation
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0.0, end: 4820.50),
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.easeOutExpo,
                                builder: (context, value, child) {
                                  // Formatting the animated number
                                  final whole = value.floor();
                                  final decimal = ((value - whole) * 100).floor().toString().padLeft(2, '0');
                                  // Adding commas for thousands
                                  final formattedWhole = whole.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: "₱$formattedWhole", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                        TextSpan(text: ".$decimal", style: const TextStyle(fontSize: 16, color: Colors.white70)),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: const [
                                    Icon(LucideIcons.arrowUpRight, color: Colors.white, size: 12),
                                    Text(" 12%", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildStatItem("Profit", "₱1,340"),
                              const SizedBox(width: 8),
                              _buildStatItem("Orders", "38"),
                              const SizedBox(width: 8),
                              _buildStatItem("Utang", "₱2,150"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _headerAnim,
              slideDistance: 0, // Header just fades in
            ),

            // 2. Animated Quick Actions
            _buildAnimatedBlock(
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionBtn(LucideIcons.package, "Add Stock", primarySoft, primaryColor),
                        _buildActionBtn(LucideIcons.handCoins, "New Utang", brownSoft, brownColor),
                        _buildActionBtn(LucideIcons.coins, "Pricing", primarySoft, primaryColor),
                        _buildActionBtn(LucideIcons.trendingUp, "Reports", brownSoft, brownColor),
                      ],
                    ),
                  ],
                ),
              ),
              _actionsAnim,
            ),

            // 3. Animated Low Stock Alerts
            _buildAnimatedBlock(
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Low Stock Alerts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("See all", style: TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildAlertItem("Lucky Me Pancit Canton", 3),
                    _buildAlertItem("Coca-Cola Mismo 290ml", 5),
                    _buildAlertItem("Skyflakes Crackers", 2),
                  ],
                ),
              ),
              _alertsAnim,
            ),

            // 4. Animated Weekly Chart Card
            _buildAnimatedBlock(
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("This Week", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                            child: const Text("+18.2%", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [40, 65, 50, 80, 45, 80, 70].map((h) => Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Animated Bar Chart Heights
                                AnimatedBuilder(
                                  animation: _chartAnim,
                                  builder: (context, child) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      // Scale height based on animation progress
                                      height: h.toDouble() * _chartAnim.value, 
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [primaryColor, const Color(0xFF8BC34A)],
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    );
                                  }
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _chartAnim,
            ),
            const SizedBox(height: 100), // BottomNav padding
          ],
        ),
      ),
    );
  }

  // Helper widgets remain mostly the same, added InkWell to Action Btn for touch animation
  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label, Color bg, Color tint) {
    return Column(
      children: [
        Material(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () {}, // Adds ripple effect
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 48, width: 48,
              alignment: Alignment.center,
              child: Icon(icon, color: tint, size: 20),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildAlertItem(String name, int left) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            height: 40, width: 40,
            decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(LucideIcons.triangleAlert, color: Colors.orange, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                Text("Only $left left in stock", style: TextStyle(color: Colors.grey[600], fontSize: 11)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFE8F5E9),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size(60, 32),
              padding: EdgeInsets.zero,
            ),
            child: const Text("Restock", style: TextStyle(color: Color(0xFF105D38), fontSize: 11, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}