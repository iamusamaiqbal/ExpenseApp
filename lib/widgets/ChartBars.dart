import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  //const ChartBar({Key? key}) : super(key: key);

  final String label;
  final double spendingAmount;
  final double perSpendingAmount;

  ChartBar(this.label, this.spendingAmount, this.perSpendingAmount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text(spendingAmount.toString())),
        SizedBox(height: 4,),
        Container(
          height: 50,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: perSpendingAmount,
                child: Container(
                  decoration: BoxDecoration(
                  //border: Border.all(color: Colors.grey, width: 1.0),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  ),
                )
              )
            ],
          ),
        ),
        Text(label),
      ],
    );
  }
}
