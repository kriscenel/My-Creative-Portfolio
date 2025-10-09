import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp>
    with SingleTickerProviderStateMixin {
  bool isDark = false;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Portfolio₊˚⊹♡",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor:
            isDark ? const Color(0xFF0E0E10) : const Color(0xFFFDF6F9),
        cardColor:
            isDark ? const Color(0xFF1E1B20) : Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor:
              isDark ? const Color(0xFF1E1B20) : const Color(0xFFFADADD),
          iconTheme: IconThemeData(
              color: isDark ? Colors.pinkAccent.shade100 : Colors.pinkAccent),
          titleTextStyle: GoogleFonts.fredoka(
            color: isDark ? Colors.pink.shade100 : Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: GoogleFonts.fredokaTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor:
                    isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
                displayColor:
                    isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
              ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("₊˚⊹♡ My Portfolio ₊˚⊹♡"),
          backgroundColor:
              isDark ? const Color(0xFF1E1B20) : const Color(0xFFFADADD),
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                color: isDark ? Colors.white : Colors.pinkAccent,
              ),
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF0E0B10), const Color(0xFF231821)]
                      : [
                          const Color(0xFFFFF5F8),
                          const Color(0xFFFFEAF1),
                          const Color(0xFFFFFDFD)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSectionCard(
                      title: "Profile",
                      icon: Icons.person,
                      iconColor:
                          isDark ? Colors.pinkAccent.shade100 : Colors.pink,
                      child: _buildProfileLayout(context),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionCard(
                      title: "Projects",
                      icon: Icons.palette,
                      iconColor:
                          isDark ? Colors.pinkAccent.shade100 : Colors.pink,
                      child: Column(
                        children: [
                          _buildProjectCard(
                            "𓂃৬ৎ Blog-Japan",
                            "A ReactJS-based website that shares insights, stories, and guides about life and opportunities in Japan.",
                            null,
                          ),
                          _buildProjectCard(
                            "𓂃৬ৎ My Creative Portfolio",
                            "A single-page Flutter portfolio app with dark mode toggle.",
                            "https://github.com/kriscenel/My-Creative-Portfolio",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionCard(
                      title: "Skills",
                      icon: Icons.local_florist,
                      iconColor:
                          isDark ? Colors.greenAccent : Colors.green.shade600,
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 10,
                        children: [
                          _buildSkillChip("Flutter"),
                          _buildSkillChip("Dart"),
                          _buildSkillChip("Java"),
                          _buildSkillChip("ReactJS"),
                          _buildSkillChip("HTML & CSS"),
                          _buildSkillChip("Python"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionCard(
                      title: "Contact",
                      icon: Icons.emoji_nature,
                      iconColor:
                          isDark ? Colors.pinkAccent.shade100 : Colors.pink,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.email,
                                color: Colors.redAccent),
                            title: Text(
                              "kriscenelt@gmail.com",
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black87),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.link,
                                color: Colors.pinkAccent),
                            title: Text(
                              "GitHub: Kriscenel",
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black87),
                            ),
                            onTap: () async {
                              final uri =
                                  Uri.parse("https://github.com/kriscenel");
                              if (!await launchUrl(uri,
                                  mode: LaunchMode.externalApplication)) {
                                throw Exception("Could not launch $uri");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileLayout(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    if (isLargeScreen) {
      return Row(
        children: [
          _buildProfileImage(),
          const SizedBox(width: 30),
          Expanded(child: _buildProfileInfo(false)),
        ],
      );
    } else {
      return Column(
        children: [
          _buildProfileImage(),
          const SizedBox(height: 16),
          _buildProfileInfo(true),
        ],
      );
    }
  }

  Widget _buildProfileImage() {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _NeonGlowBorderPainter(
                    rotation: _controller.value, isDark: isDark),
                size: const Size(180, 180),
              );
            },
          ),
          const CircleAvatar(
            radius: 85,
            backgroundImage: AssetImage("lib/assets/ekai.png"),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(bool isCentered) {
    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "⋆. 𐙚 ˚Kriscenel Tanduyan",
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.pink.shade100 : const Color(0xFFE86A9E)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "⋆౨ৎ˚ BS Information Technology | 3rd Year ⋆౨ৎ˚",
          style: TextStyle(
              color: isDark ? Colors.white : Colors.black87, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          "ᯓ★ I’m learning to trust the process — to grow through what I go through, to let myself bloom slowly, and to find beauty in every small victory along the way ⋆˚꩜｡",
          style: TextStyle(
              color: isDark ? Colors.white : Colors.black87, fontSize: 18),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    final bgColor = isDark ? const Color(0xFF1E1B20) : const Color(0xFFFFE3E8);
    final borderColor =
        isDark ? const Color(0xFFAD769F) : const Color(0xFFE6A9C0);

    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: borderColor, width: 2),
      ),
      elevation: 15,
      shadowColor: isDark
          ? Colors.pinkAccent.withValues(alpha: 0.3)
          : const Color(0xFFF8BBD0).withValues(alpha: 0.6),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A242E) : Colors.white,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFFEABEDB), width: 2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(icon, color: iconColor, size: 36),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.alkatra(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(String title, String desc, String? link) {
    final bgColor = isDark ? const Color(0xFF2B252D) : const Color(0xFFFFF2F2);
    final textColor = isDark ? Colors.white : Colors.black87;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? const Color(0xFFAD769F) : const Color(0xFFEABEDB),
          width: 1.5,
        ),
      ),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: textColor)),
        subtitle: Text(desc, style: TextStyle(color: textColor)),
        trailing: link != null
            ? IconButton(
                icon: const Icon(Icons.link, color: Colors.pink),
                onPressed: () async {
                  final uri = Uri.parse(link);
                  if (!await launchUrl(uri,
                      mode: LaunchMode.externalApplication)) {
                    throw Exception("Could not launch $uri");
                  }
                },
              )
            : null,
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87),
      ),
      backgroundColor:
          isDark ? const Color(0xFF3A2F39) : Colors.pink.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

// Neon glowing circular border
class _NeonGlowBorderPainter extends CustomPainter {
  final double rotation;
  final bool isDark;

  _NeonGlowBorderPainter({required this.rotation, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final neonColor = isDark ? Colors.pinkAccent : Colors.pinkAccent.shade100;

    final sweepGradient = SweepGradient(
      startAngle: 0,
      endAngle: 6.28319,
      colors: [
        neonColor.withValues(alpha: 0.0),
        neonColor.withValues(alpha: 0.0),
        neonColor.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
      transform: GradientRotation(6.28319 * rotation),
    );

    for (double blur in [20, 14, 8]) {
      final paint = Paint()
        ..shader = sweepGradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

      canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    }

    final auraPaint = Paint()
      ..shader = RadialGradient(
        colors: [neonColor.withValues(alpha: 0.15), Colors.transparent],
        stops: const [0.85, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, auraPaint);
  }

  @override
  bool shouldRepaint(covariant _NeonGlowBorderPainter oldDelegate) => true;
}
