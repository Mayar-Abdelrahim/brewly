import 'package:brewly/screens/home_screen.dart';
import 'package:brewly/widgets/getting_started_button.dart';
import 'package:flutter/material.dart';
import '../widgets/brewly_brand_badge.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14110F),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // background image
          Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.cover,
          ),

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x33000000),
                  Color(0x22000000),
                  Color(0xCC120D0A),
                  Color(0xF2120D0A),
                ],
                stops: [0.0, 0.4, 0.75, 1.0],
              ),
            ),
          ),


          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrewlyBrandBadge(),
                  const Spacer(),
                  const Text(
                    'Fresh Coffee,\nMade for You',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Browse your favorite drinks and order\nin seconds.',
                    style: TextStyle(
                      color: Color(0xFFD6CEC7),
                      fontSize: 15,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 28),
                  GetStartedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}