import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String id;
  final String name;
  final num amount;
  final String category;
  DateTime date;
  String userId;




  Expense({
    this.id = '',
    required this.name,
    required this.amount,
    required this.category,
    required this.date,
    required this.userId

  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        id: json['id'] ?? "",
        name: json['name'],
        amount:  json['amount'],
        category: json['category'] ?? "",
        date: (json["date"] as Timestamp).toDate(),
        userId:  json['userId'],

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'amount': amount,
    'category': category,
    "date": date,
    "userId": userId

  };

  @override
  String toString() {
    return 'Expense{id: $id, name: $name, amount: $amount, category: $category}, userId: $userId}';
  }
}
