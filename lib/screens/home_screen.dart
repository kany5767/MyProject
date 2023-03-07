import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_db/screens/form_edit_screen.dart';
import 'package:provider/provider.dart';

import '../models/transactions.dart';
import '../providers/transaction_provider.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meeting Room Booking App", style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 25,),),
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                color: Colors.white,
                onPressed: () {
                  SystemNavigator.pop();
                }),
            IconButton(
              color: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen();
                  }));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider providers, Widget? child) {
            var count = providers.transactions.length;
            if (count <= 0) {
              return const Center(
                child: Text(
                  "No Data.",
                  style: TextStyle(
                  color: Color(0xFF00BCD4),
                  fontSize: 25,),),
              );
            } else {
              return ListView.builder(
                itemCount: providers.transactions.length,
                itemBuilder: (context, int index) {
                  Transactions data = providers.transactions[index];

                  return Card(
                      color: Color.fromARGB(255, 255, 255, 255),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                          enabled: true,
                          leading: CircleAvatar(
                              radius: 30,
                              child: FittedBox(
                                child: Text(data.number.toString(),
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                              // ignore: prefer_const_constructors
                              color: Color(0xFF00BCD4),
                              fontSize: 15,),),
                              )
                              
                              ),
                          title: Text(data.name, 
                          style: const TextStyle(color:Color(0xFF00BCD4)),),
                          // ignore: prefer_interpolation_to_compose_strings
                          subtitle: Text("Type Room: " +data.type.toString() +
                              "\n Check In: " +
                              data.checkIn +
                              "\n Check Out " +
                              data.checkOut ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormEditScreen(data: data);
                            }));
                          },
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // call provider
                                var provider = Provider.of<TransactionProvider>(
                                    context,
                                    listen: false);
                                provider.deleteTransaction(data);
                              })));
                },
              );
            }
          },
        ));
  }
}
