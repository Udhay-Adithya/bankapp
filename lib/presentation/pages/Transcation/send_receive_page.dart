import 'package:bankapp/infrastructure/core/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../mock/mock_data_provider.dart';


class SendMoneyScreen extends ConsumerStatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends ConsumerState<SendMoneyScreen> {
  final TextEditingController _controller = TextEditingController();
  double _amount = 0.0;

  void _updateAmount(String value) {
    setState(() {
      _amount = double.tryParse(value) ?? 0.0;
    });
  }


  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Send Money",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.cancel,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),

            // **Recipient Details**
            Text(
              "test_user",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "IOB BANK • 8900",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            // **Centered Amount Input**
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // Center content vertically
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.32, // Add left padding
                      ),
                      Text(
                        "₹",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA01B29), // INR symbol in red
                        ),
                      ),
                      Flexible(
                        // Ensure proper spacing without extra gaps
                        child: TextField(
                          controller: _controller,
                          onChanged: _updateAmount,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.start, // Align text next to ₹
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: "0.00",
                            hintStyle: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero, // Remove padding
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // **Add Note Button**
            TextButton(
              onPressed: () {},
              child: Text(
                "Add note",
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),

            // **Verify and Pay Button**
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffA01B29),
                padding: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.1, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                double amount = double.tryParse(_controller.text) ?? 0;
                if (amount > 0) {
                  _showVerificationBottomSheet(context, amount, ref);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter a valid amount!")),
                  );
                }
              },
              child: Text(
                "Verify and Pay",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showVerificationBottomSheet(
      BuildContext context, double amount, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return VerificationBottomSheet(
            amount: amount, authService: _authService, ref: ref);
      },
    );
  }
}

class VerificationBottomSheet extends StatefulWidget {
  final double amount;
  final AuthService authService;
  final WidgetRef ref;

  const VerificationBottomSheet({
    super.key,
    required this.amount,
    required this.authService,
    required this.ref,
  });

  @override
  _VerificationBottomSheetState createState() =>
      _VerificationBottomSheetState();
}

class _VerificationBottomSheetState extends State<VerificationBottomSheet> {
  bool isFingerprintVerified = false;
  XFile? _capturedImage;

  Future<void> _verifyFingerprint() async {
    bool isAuthenticated = await widget.authService.authenticate();
    setState(() {
      isFingerprintVerified = isAuthenticated;
    });

    if (!isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fingerprint verification failed!")),
      );
    }
  }

  Future<void> _capturePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _capturedImage = photo;
      });
    }
  }

  void _completeTransaction() {
    print("Transaction Attempted");

    if (!isFingerprintVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please verify fingerprint!")),
      );
      print("Fingerprint not verified");
      return;
    }

    if (_capturedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please upload a photo!")),
      );
      print("Photo not uploaded");
      return;
    }

    final sender = widget.ref.read(userProvider);
    print("Sender Balance: ${sender.balance}");
    print("Transaction Amount: ${widget.amount}");

    if (sender.balance >= widget.amount) {
      print("Sufficient balance, proceeding with transaction...");

      final transaction = Transaction(
        sender: sender.name,
        receiver: "Receiver XYZ",
        amount: widget.amount,
        timestamp: DateTime.now(),
      );

      widget.ref.read(userProvider.notifier).updateBalance(-widget.amount);
      widget.ref.read(transactionProvider.notifier).addTransaction(transaction);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Transaction successful!")),
      );

      // Navigate to dashboard after success
      Navigator.popAndPushNamed(context, '/dashboard');
    } else {
      print("Insufficient balance!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Insufficient balance!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 450,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "VERIFY TO PAY",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Colors.grey[800],
              ),
            ),

            SizedBox(height: 16),
            // Text("Amount: ₹${widget.amount.toStringAsFixed(2)}",
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            // SizedBox(height: 16),

            GestureDetector(
              onTap: _verifyFingerprint,
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: isFingerprintVerified ? Colors.green : Colors.blue,
                      width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.fingerprint,
                            color: isFingerprintVerified
                                ? Colors.green
                                : Colors.blue,
                            size: screenWidth * 0.06,
                          ),
                          SizedBox(width: 10),
                          Text(
                            isFingerprintVerified
                                ? "Verified"
                                : "Verify Fingerprint",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        isFingerprintVerified
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color:
                            isFingerprintVerified ? Colors.green : Colors.grey,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            GestureDetector(
              onTap: _capturePhoto,
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color:
                          _capturedImage != null ? Colors.green : Colors.blue,
                      width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: _capturedImage != null
                                ? Colors.green
                                : Colors.blue,
                            size: screenWidth * 0.06,
                          ),
                          SizedBox(width: 10),
                          Text(
                            _capturedImage != null
                                ? "Photo Uploaded"
                                : "Upload Photo",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        _capturedImage != null
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color:
                            _capturedImage != null ? Colors.green : Colors.grey,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffA01B29), width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Amount: ₹${widget.amount.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            ),
            SizedBox(height: 16),

            GestureDetector(
              onTap: _completeTransaction,
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffA01B29),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Pay",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lato',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffA01B29), width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lato',
                    color: Color(0xffA01B29),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
