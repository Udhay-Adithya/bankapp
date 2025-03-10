import 'package:bankapp/mock/mock_data_provider.dart';
import 'package:bankapp/presentation/pages/Transcation/send_receive_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final transactions = ref.watch(transactionProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Set custom height
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset('assets/icons/icons8-menu-squared-50.png'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/icons8-add-50.png',
                    width: 60,
                    height: 80,
                    color: Color(0xffA01B29),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //            Profilepage()), // Create instance here
                      // );
                    },
                    child: Image.asset(
                        'assets/icons/icons8-test-account-50.png',
                        width: 60,
                        height: 80),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     Text("Balance: \$${user.balance.toStringAsFixed(2)}",
      //         style: TextStyle(fontSize: 24)),
      //     ElevatedButton(
      //       onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => SendMoneyScreen()),
      //       ),
      //       child: Text("Send Money"),
      //     ),
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: transactions.length,
      //         itemBuilder: (context, index) {
      //           final transaction = transactions[index];
      //           return ListTile(
      //             title: Text("Sent to: ${transaction.receiver}"),
      //             subtitle: Text("\$${transaction.amount}"),
      //             trailing: Text(transaction.timestamp.toLocal().toString()),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi, ${user.name}",
                        style: const TextStyle(
                            fontFamily: 'Recta-Bold',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1C1717))),
                    Text("Welcome back!",
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1C1717))),
                    SizedBox(height: 15),
                    const Text(
                      "Wallet Balance",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1C1717)),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "₹${user.balance.toStringAsFixed(2)}", // Main amount
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 50,
                              color: Color(0xFF1C1717),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      print("refreshed");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.refresh,
                        size: 40,
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SendMoneyScreen()), // Create instance here
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: screenHeight * 0.08,
                    width: screenWidth * 0.4,
                    color: const Color(0xFFF2F2F4),
                    child: Row(
                      children: [
                        // Add Circle inside Row
                        SizedBox(
                          width: 2,
                        ),
                        CircleAvatar(
                          radius: 22, // Set the size of the circle
                          backgroundColor: Color(0xffA01B29), // Circle color
                          child: Icon(
                            Icons.arrow_forward, // Icon inside circle
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            width: screenWidth *
                                0.02), // Space between the circle and the text
                        Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           const ReceivePage()), // Create instance here
                  // );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: screenHeight * 0.08,
                    width: screenWidth * 0.4,
                    color: const Color(0xFFF2F2F4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 2,
                        ),
                        CircleAvatar(
                          radius: 22, // Set the size of the circle
                          backgroundColor: Color(0xffA01B29), // Circle color
                          child: Icon(
                            Icons.arrow_downward, // Icon inside circle
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            width: screenWidth *
                                0.02), // Space between the circle and the text
                        Text(
                          "Receive",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            // Custom color
            thickness: 1, // Line thickness
            indent: 20, // Left padding
            endIndent: 20, // Right padding
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 29, 29, 29),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View all",
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffA01B29),
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward_ios, size: 18),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10), // Add spacing before transaction list
          ListView.builder(
            itemCount: transactions.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final isCredit = transaction.receiver ==
                  user.name; // Determine credit or debit

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Card(
                  color: Color(0xFFF2F2F4),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor:
                          isCredit ? Colors.green[100] : Colors.red[100],
                      child: Icon(
                        isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isCredit ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(
                      isCredit
                          ? "Received from: ${transaction.sender}"
                          : "Sent to: ${transaction.receiver}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      "₹${transaction.amount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: Text(
                      transaction.timestamp
                          .toLocal()
                          .toString()
                          .split(' ')[0], // Show only date
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
