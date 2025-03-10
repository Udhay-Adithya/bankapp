import 'package:bankapp/infrastructure/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../components/CustomTextField.dart';

class SignUpScreen extends ConsumerWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: 'Scan your Face ID or Fingerprint to register',
      options: AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom AppBar with background gradient
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              width: double.infinity,
              height: 400, // Adjust height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/BgBlue.webp'), // WebP background
                  fit: BoxFit.cover, // Covers entire screen
                ),
                // gradient: LinearGradient(
                //   colors: [Colors.blue, Colors.blueAccent],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
              ),
              child: Container(
                color: Color(0xffA01B29).withOpacity(0.4),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Arrow
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 30), // Space below back button
                        // "New Account" Text
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Account",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Expanded section for the form content
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                // CustomTextField(
                //   labelText: 'Username',
                //   hintText: 'Enter your username',
                //   prefixText: '',
                //   controller: usernameController,
                // ),
                // CustomTextField(
                //   labelText: 'Email',
                //   hintText: 'Enter your email',
                //   prefixText: '',
                //   controller: emailController,
                // ),
                TextField(
                  // Controller to set default value
                  readOnly: true, // Prevents typing
                  decoration: InputDecoration(
                    hintText: "test_user", // Hint if no text is set
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  // Controller to set default value
                  readOnly: true, // Prevents typing
                  decoration: InputDecoration(
                    hintText: "test_user@gmail.com", // Hint if no text is set
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: GestureDetector(
                    onTap: () async {
                      bool isAuthenticated = await authenticate();
                      if (!isAuthenticated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Authentication failed!")));
                        return;
                      }

                      // String username = usernameController.text;
                      String username = "test_user";
                      // String email = emailController.text;
                      String email = "test_user@gmail.com";
                      String biometricData =
                          "biometric_token"; // Store a unique value for authentication

                      bool success = await ref
                          .read(authProvider.notifier)
                          .signUp(
                              username, email, biometricData, biometricData);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Signup Successful")));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Username already exists")));
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Color(0xffA01B29),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Next Page",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
