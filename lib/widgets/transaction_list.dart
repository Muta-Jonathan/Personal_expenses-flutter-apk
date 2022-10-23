import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(
      {required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? SizedBox(
            height: 50,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('./assets/images/click-here.gif'),
                  Text(
                    'Oops!! No Records, \n Please add New records ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FittedBox(
                        child: Text(
                          'Shs${transactions[index].amount.toStringAsFixed(0)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMEd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 560
                      ? TextButton.icon(
                          onPressed: (() =>
                              deleteTransaction(transactions[index].id)),
                          icon: Icon(
                              color: Theme.of(context).errorColor,
                              Icons.delete_forever),
                          label: Text(
                            'delete',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                              color: Theme.of(context).errorColor,
                              Icons.delete_forever),
                          onPressed: (() =>
                              deleteTransaction(transactions[index].id)),
                        ),
                ),
              );
            },
          );
  }
}
