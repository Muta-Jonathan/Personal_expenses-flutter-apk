import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  const TransactionItem(
      {super.key, required this.transaction, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
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
                'Shs${transaction.amount.toStringAsFixed(0)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 560
            ? TextButton.icon(
                onPressed: (() => deleteTransaction(transaction.id)),
                icon: Icon(
                    color: Theme.of(context).errorColor, Icons.delete_forever),
                label: Text(
                  'delete',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(
                    color: Theme.of(context).errorColor, Icons.delete_forever),
                onPressed: (() => deleteTransaction(transaction.id)),
              ),
      ),
    );
  }
}
