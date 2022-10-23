import 'package:expense_cal/widgets/card_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized;
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontFamily: 'OpenSans',
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: '1',
    //   title: 'Clothes',
    //   amount: 10000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Shoes',
    //   amount: 8900,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '3',
    //   title: 'turtion',
    //   amount: 9700,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return DateTime.now().isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addUserTransaction(
      String txTitle, double txAmount, DateTime pickedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle.trim(),
        amount: txAmount,
        date: pickedDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
            addTransaction: _addUserTransaction,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere(
        (tx) {
          return tx.id == id;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _startBottomSheet(context),
          icon: Icon(Icons.add),
        )
      ],
    );
    final mediaQuery = MediaQuery.of(context);
    
    double dynamicSize = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            height: dynamicSize * 0.3,
            child: CardDashboard(
              recentTransactions: _recentTransactions,
            ),
          ),
          Container(
            height: dynamicSize * 0.7,
            child: TransactionList(
              transactions: _userTransactions,
              deleteTransaction: _deleteTransaction,
            ),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startBottomSheet(context),
      ),
    );
  }
}
