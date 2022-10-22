import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({required this.addTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();
  final _amountInputController = TextEditingController();
  DateTime? _selectedDate;

  void _selectedDateicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void sumbitTransaction() {
    if (_amountInputController.text.isEmpty) {
      return;
    }
    String _title = _titleInputController.text;
    double _amount = double.parse(_amountInputController.text);

    if (_title.isEmpty || _amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(
      _title,
      _amount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleInputController,
            onSubmitted: (_) => sumbitTransaction(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountInputController,
            onSubmitted: (_) => sumbitTransaction(),
            keyboardType: TextInputType.number,
          ),
          Container(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No Date chosen!'
                      : 'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}'),
                ),
                TextButton(
                  onPressed: _selectedDateicker,
                  child: Text('Choose Date'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: sumbitTransaction,
            child: Text('Add Transaction'),
          )
        ]),
      ),
    );
  }
}
