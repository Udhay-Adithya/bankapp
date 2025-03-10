import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  String name;
  double balance;

  User({required this.name, required this.balance});

  Map<String, dynamic> toJson() => {"name": name, "balance": balance};

  static User fromJson(Map<String, dynamic> json) =>
      User(name: json['name'], balance: json['balance']);
}

class Transaction {
  String sender;
  String receiver;
  double amount;
  DateTime timestamp;

  Transaction({
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "amount": amount,
        "timestamp": timestamp.toIso8601String(),
      };

  static Transaction fromJson(Map<String, dynamic> json) => Transaction(
        sender: json['sender'],
        receiver: json['receiver'],
        amount: json['amount'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(User(
          name: "test_user",
          balance: 10000.0,
        )) {
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      state = User.fromJson(jsonDecode(userData));
    }
  }

  Future<void> updateBalance(double amount) async {
    state = User(name: state.name, balance: state.balance + amount);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(state.toJson()));
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionData = prefs.getString('transactions');
    if (transactionData != null) {
      final List<dynamic> jsonList = jsonDecode(transactionData);
      state = jsonList.map((e) => Transaction.fromJson(e)).toList();
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    state = [...state, transaction];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'transactions', jsonEncode(state.map((e) => e.toJson()).toList()));
  }
}
