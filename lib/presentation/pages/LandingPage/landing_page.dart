import 'package:bankapp/presentation/components/CustomLoginButton.dart';
import 'package:flutter/material.dart';
import '../../components/CustomSignButton.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true, // Extend background to AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // No shadow
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/BgBlue.webp'), // WebP background
            fit: BoxFit.cover, // Covers entire screen
          ),
        ),
        child: Container(
          color: Color(0xffA01B29).withOpacity(0.4), // Blue overlay
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Text("Get Better\nWith Money.",
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Recta-Bold',
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Text(
                      "Manage your finances like a pro. Save, invest and track your expenses.",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'PlusJakartaSans',
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight * 0.02), // Adds bottom spacing
                  child: Column(
                    children: [
                      BuildCustomLoginButton(context, 'Login', '/login'),
                      SizedBox(height: 10),
                      BuildCustomSignButton(context, 'Sign Up', '/signup'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
