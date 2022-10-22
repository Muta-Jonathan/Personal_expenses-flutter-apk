import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './card_bar.dart';

class CardDashboard extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const CardDashboard({super.key, required this.recentTransactions});

  List<Map<String, dynamic>> get weekTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'weekDay': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get spendingPcOfTotal {
    return weekTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data['weekDay'],
                  spendingAmount: data['amount'],
                  spendingPcOfTotal: spendingPcOfTotal == 0.0
                      ? 0.0
                      : data['amount'] / spendingPcOfTotal),
            );
          }).toList(),
        ),
      ),
    );
  }
}
