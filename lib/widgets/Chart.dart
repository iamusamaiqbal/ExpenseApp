import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanse/TransactionClass.dart';
import 'package:intl/intl.dart';

import 'ChartBars.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get getGroupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          sum += recentTransactions[i].amount;
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum
      };
    }).reversed.toList();
  }

  double get totalSpandings {
    return getGroupedTransaction.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return (recentTransactions.isNotEmpty)
        ? Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: getGroupedTransaction.map((data) {
                    return ChartBar(data['day'], data['amount'],
                        (data['amount'] as double) / totalSpandings);
                  }).toList()),
            ),
          )
        : Card(
            elevation: 6,
            child: Center(
              child: Text(
                "No, Transaction yet",
                style: Theme.of(context).textTheme.title,
              ),
            ),
          );
  }
}
