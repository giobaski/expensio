import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensio/models/expense.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:expensio/utils/dialogs.dart';

import 'auth_controller.dart';

class ExpenseController extends GetxController {

  var availableCategories = [
    "Food",
    "Shopping",
    "Housing",
    "Transportation",
    "Vehicle",
    "Entertainment",
    "Communication",
    "Other"
  ];

  var selectedCategory = "Food".obs;

  // final CollectionReference c = FirebaseFirestore.instance.collection('expenses');
  FirebaseFirestore? _instance;
  var expenses = [].obs;
  var userId = AuthController.instance.firebaseUser.value!.uid;


  @override
  Future<void> onInit() async {
    super.onInit();
    await getExpenses();
  }

  Future addExpense(Expense expense) async {
    final docExpense = FirebaseFirestore.instance.collection('expenses').doc();
    expense.id = docExpense.id;
    await docExpense.set(expense.toJson());

    getExpenses();
    getExpensesByCategory();
  }


  Future<void> getExpenses() async {
    List<Expense> exp = await FirebaseFirestore.instance
        .collection('expenses')
        .where('userId', isEqualTo: userId)
        .limit(5)
        .orderBy('date', descending: true)
        .get()
        .then((value) =>
        value.docs.map((doc) => Expense.fromJson(doc.data())).toList());

    print(exp.length);

    expenses.value = exp;
  }


   Map<String, double> getExpensesByCategory() {
    print("######Length");
    print(expenses.length);


    Map<String, double> sumMap = {};

    expenses.forEach((expense) {
      if (sumMap.containsKey(expense.category)) {
        if (sumMap[expense.category] != null) {
          // print(sumMap[expense.category]);
          sumMap[expense.category] = sumMap[expense.category]! + double.parse(expense.amount.toString());
        }
      } else {
        sumMap[expense.category] = double.parse(expense.amount.toString());
      }
    });

    print("####CALLED");
    print(sumMap);

    return sumMap;
  }

}