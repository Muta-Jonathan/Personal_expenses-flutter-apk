import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPcOfTotal;
  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPcOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 14,
            child: FittedBox(
                child: Text('Shs${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 90,
          width: 14,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPcOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 5,
        ),
        Text('$label'),
      ],
    );
  }
}
