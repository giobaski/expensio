import 'package:expensio/controllers/auth_controller.dart';
import 'package:expensio/controllers/expense_controller.dart';
import 'package:expensio/models/expense.dart';
import 'package:expensio/utils/dialogs.dart';
import 'package:expensio/widgets/botom_navigation_bar.dart';
import 'package:expensio/widgets/custom_drawer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'expense_details.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ExpenseController expenseController = Get.put(ExpenseController(), permanent: true);
  String qrCode = '';

  var expensesByCategory = {};


  @override
  void initState() {
    super.initState();

    expensesByCategory = expenseController.getExpensesByCategory();
    // expenseController.getExpensesByCategory().then((value) => expensesByCategory = value);
  }



  List<Widget> _displayStat() {
    List<Widget> my = [];
    expensesByCategory.forEach((key, value) {
      print("#####################################################key");
      my.add(Text('Key = ${key} : Value = ${value}'));
    });
    return my;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                _scanQRCode();
              },
              icon: Icon(Icons.qr_code)
          )
        ],
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: MyBottomnavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("Welcome ${AuthController.instance.firebaseUser.value!.email}"),
              // ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("STATISTICS", style: TextStyle(fontWeight: FontWeight.bold),),
                    Icon(Icons.bar_chart)
                  ],
                ),
              ),

              // _displayExpenses(),
              Container(
                height: 100,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // image: DecorationImage(
                    //     image: NetworkImage("https://thumbs.dreamstime.com/b/abstract-blue-light-grid-technology-background-illu-illustration-design-65069866.jpg"),
                    //     fit: BoxFit.cover)
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                      ),
                      const BoxShadow(
                        color: Colors.black,
                        // spreadRadius: -12.0,
                        blurRadius: 12.0,
                      ),
                    ],
                        ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                          [
                            Text("Food: " + expensesByCategory['Other'].toString()),
                            Text("Shopping: " + expensesByCategory['Shopping'].toString()),
                            Text("Housing: " + expensesByCategory['Housing'].toString()),
                            Text("Vehicle: " + expensesByCategory['Vehicle'].toString()),
                          ]
                      ),
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Text("Transportation: " + expensesByCategory['Transportation'].toString()),
                            Text("Communication: " + expensesByCategory['Communication'].toString()),
                            Text("Entertainment: " + expensesByCategory['Entertainment'].toString()),
                            Text("Other: " + expensesByCategory['Other'].toString()),
                          ]
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: (){
                  Get.defaultDialog(
                    title: "New Expense",
                    content: _buildAddExpenseTextField(),
                  );
                },
                label: Text('Add'),
                icon: Icon(Icons.add),

                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.all(5),
                    minimumSize: Size(double.infinity * 0.6, 35)
                ),
              ),
              SizedBox(height: 20),
              // Spacer(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("LATEST EXPENSES", style: TextStyle(fontWeight: FontWeight.bold),),
                    Icon(Icons.monetization_on_outlined)
                  ],
                ),
              ),


              Container(
                height: 320,
                width: double.infinity,
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // image: DecorationImage(
                  //     image: NetworkImage("https://thumbs.dreamstime.com/b/abstract-blue-light-grid-technology-background-illu-illustration-design-65069866.jpg"),
                  //     fit: BoxFit.cover)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(()=>ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),

                          itemCount: expenseController.expenses.length,
                          itemBuilder: (context, index){
                            var expense = expenseController.expenses[index];
                          return Card(
                            child: ListTile(
                              leading:
                              CircleAvatar(
                                child: Text("${expense.amount}",
                                    style:TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                backgroundColor: Colors.brown,
                              ),
                              title: Text(expense.name),
                              subtitle: Text(DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(expense.date.toString())),
                            // style: TextStyle(fontSize: 12)
                            style: Theme.of(context).textTheme.caption,
                          ),
                              trailing: Text(expense.category,
                                  style:TextStyle( fontWeight: FontWeight.bold, color: Colors.amber) ),
                            onTap: (){
                                Get.to(()=>ExpenseDetailsPage(expense: expense));
                            },
                            ),
                          );


                          }
                      )
                    )

                    ],

                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scanQRCode() async {
    try {
      var code = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.QR);
      print("######" + code);

      if (code.isNotEmpty) {
        setState(() {
          qrCode = code;
        });
      }
    } on Exception {
      MyDialogs.error("Failed To get qrCode", "Try Again!");
    }
  }




  Widget _buildAddExpenseTextField(){
    final TextEditingController _expenseNameController = TextEditingController();
    final TextEditingController _expenseAmountController = TextEditingController();
    // final TextEditingController _productPriceController = TextEditingController();
    return Column(
      children: [
        Container(
          height: 55,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(),
          child: TextField(
            controller: _expenseNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // prefixIcon: Icon(Icons.phone, color: Colors.teal),
              labelText: 'Title',
              labelStyle: TextStyle(fontSize: 14),
              hintText: '',
            ),
          ),
        ),
        Container(
          height: 55,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(),
          child: TextField(
            controller: _expenseAmountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // prefixIcon: Icon(Icons.phone, color: Colors.teal),
              labelText: 'Amount',
              labelStyle: TextStyle(fontSize: 14),
              hintText: '',
            ),
          ),
        ),

        Obx(
            () => SingleChildScrollView(
              child: Container(
                height: 100,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Expanded(
                        child: Text("Category:", style: TextStyle(fontSize: 14))),
                    Expanded(
                      flex: 2,
                      child: DropdownButton<String>(
                      value: expenseController.selectedCategory.value,
                      onChanged: (selectedBank) {
                        expenseController.selectedCategory.value = selectedBank!;
                      },
                      isExpanded: true,
                      iconSize: 32,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      items: expenseController.availableCategories
                          .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category, style: TextStyle(fontSize: 14,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold)),
                      ))
                          .toList(),
          ),
                    ),
                  ],
                ),
              ),
            ),
        ),

        ElevatedButton(
          onPressed: () {
            // installmentController.installment.value.products!
            if(_expenseNameController.text.isEmpty || _expenseAmountController.text.isEmpty){
              Get.snackbar("ERROR!", "You Should Fill All Fields",
                  backgroundColor: Colors.white, colorText: Colors.red);
            } else {
              expenseController.addExpense(
                  Expense(
                      name: _expenseNameController.text,
                      amount: double.parse(_expenseAmountController.text),
                      category: expenseController.selectedCategory.value,
                    date: DateTime.now(),
                    userId: AuthController.instance.firebaseUser.value!.uid
                  )
              );
              Get.back();

              _expenseNameController.clear(); _expenseAmountController.clear();
            }
          },
          child: Text("Create", style: TextStyle(fontWeight: FontWeight.bold),),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            padding: EdgeInsets.all(10),
            minimumSize: Size(double.infinity * 0.7, 40),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),),
        ),
        // ),
      ],
    );
  }




}
