import 'package:flutter/material.dart';
import './widgets/Chart.dart';
import './widgets/NewTransation.dart';
import './widgets/TransactionListWidget.dart';


import 'TransactionClass.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Transaction> transaction = [];

  List<Transaction> get recentTxt{
    return transaction.where((txt){
      return txt.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, int amount){
    final newTxt = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        title: title,
        date: DateTime.now()
    );

    setState(() {
      transaction.add(newTxt);
    });
  }

  void _startNewTransaction(BuildContext buildContext){
    showModalBottomSheet(context: context, builder: (ctx){
      return  NewTransaction(_addTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense App"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                _startNewTransaction(context);
              }
              )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              child: Chart(recentTxt),
            ),
            TransactionList(transaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _startNewTransaction(context);
        },
      ),
    );
  }
}
