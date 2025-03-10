import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/pages/AuthPage/login_page.dart';
import 'presentation/pages/AuthPage/signup_page.dart';
import 'presentation/pages/Dashboard/dashboard.dart';
import 'presentation/pages/LandingPage/landing_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Default route
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => LoginPageScreen(),
        '/signup': (context) => SignUpScreen(),
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Face ID Auth',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: FaceAuthScreen(),
//     );
//   }
// }

// class FaceAuthScreen extends StatefulWidget {
//   @override
//   _FaceAuthScreenState createState() => _FaceAuthScreenState();
// }

// class _FaceAuthScreenState extends State<FaceAuthScreen> {
//   final LocalAuthentication auth = LocalAuthentication();
//   String authStatus = "Not Authenticated";

//   Future<void> authenticate() async {
//     try {
//       bool canCheckBiometrics = await auth.canCheckBiometrics;
//       bool isDeviceSupported = await auth.isDeviceSupported();
//       List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

//       if (canCheckBiometrics && isDeviceSupported) {
//         if (availableBiometrics.contains(BiometricType.face)) {
//           bool authenticated = await auth.authenticate(
//             localizedReason: 'Scan your face to authenticate',
//             options: const AuthenticationOptions(
//               biometricOnly: true,
//               stickyAuth: true,
//             ),
//           );

//           setState(() {
//             authStatus = authenticated ? "Authentication Successful!" : "Authentication Failed!";
//           });
//         } else {
//           setState(() {
//             authStatus = "Face ID not available on this device";
//           });
//         }
//       } else {
//         setState(() {
//           authStatus = "Biometric Authentication not supported";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         authStatus = "Error during authentication: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Face ID Authentication")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(authStatus, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: authenticate,
//               child: Text("Authenticate with Face ID"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Face ID Check',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: FaceCheckScreen(),
//     );
//   }
// }

// class FaceCheckScreen extends StatefulWidget {
//   @override
//   _FaceCheckScreenState createState() => _FaceCheckScreenState();
// }

// class _FaceCheckScreenState extends State<FaceCheckScreen> {
//   final LocalAuthentication auth = LocalAuthentication();
//   String faceIdStatus = "Checking...";

//   @override
//   void initState() {
//     super.initState();
//     checkFaceID();
//   }

//   Future<void> checkFaceID() async {
//     try {
//       bool canCheckBiometrics = await auth.canCheckBiometrics;
//       bool isDeviceSupported = await auth.isDeviceSupported();
//       List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

//       if (canCheckBiometrics && isDeviceSupported) {
//         if (availableBiometrics.contains(BiometricType.face)) {
//           setState(() {
//             faceIdStatus = "Face ID is available!";
//           });
//         } else {
//           setState(() {
//             faceIdStatus = "Face ID not available on this device.";
//           });
//         }
//       } else {
//         setState(() {
//           faceIdStatus = "Biometric Authentication not supported.";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         faceIdStatus = "Error checking Face ID: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Check Face ID Availability")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(faceIdStatus, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: checkFaceID,
//               child: Text("Recheck Face ID"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

