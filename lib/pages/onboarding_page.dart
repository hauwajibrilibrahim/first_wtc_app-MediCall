import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _activeIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      "title": "Welcome to MediCall",
      "description":
          "We help you make ambulance requests for emergency and other purposes",
      "image": "assets/onboardingscr.png",
    },
    {
      "title": "Get emergency medical help fast",
      "description":
          "Wherever you are. Need urgent help? We’ll connect you to the nearest available ambulance.",
      "image": "assets/onboardingscr.png",
    },
    {
      "title": "Meet world class respondents",
      "description":
          "Wherever you are. Need urgent help? We’ll connect you to world class respondents",
      "image": "assets/onboardingscr.png",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_activeIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: _activeIndex == index ? 14 : 8,
      decoration: BoxDecoration(
        color: _activeIndex == index ? Colors.blue : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() => _activeIndex = index);
              },
              itemCount: _pages.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Page indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (index) => _buildIndicator(index),
                        ),
                      ),
                      Image.asset(_pages[index]["image"]!, height: 250),
                      const SizedBox(height: 40),
                      Text(
                        _pages[index]["title"]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.aDLaMDisplay(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _pages[index]["description"]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.k2d(
                          fontSize: 18
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                if (_activeIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                if (_activeIndex > 0) const SizedBox(width: 16),
                Expanded(
                  flex: _activeIndex > 0 ? 2 : 1,
                  child: ElevatedButton(
                    onPressed: _onNextPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _activeIndex == _pages.length - 1 ? "Get Started" : "Next",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
