import 'package:expensio/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseDetailsPage extends StatelessWidget {
  final Expense expense;


  const ExpenseDetailsPage({
    Key? key,
    required this.expense
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Details"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 240,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("ID: " + expense.id),
              ),
              Text("Name: " + expense.name),
              Text("Amount: " + expense.amount.toString() + "\$"),
              Text("Date: " + expense.date.toString()),

              SizedBox(height: 20,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){

                        },
                        child: Text("Repeat"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){

                        },
                        child: Text("Archive"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: EdgeInsets.all(5),
                        ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
