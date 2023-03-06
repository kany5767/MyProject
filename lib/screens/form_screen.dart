// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_db/models/transactions.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //Controller
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final typeController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Record Form'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Room Name"),
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Room Name.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Room number"),
                      keyboardType: TextInputType.text,
                      controller: numberController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Room number.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Room type"),
                      keyboardType: TextInputType.text,
                      controller: typeController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Room type.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkInController,
                      decoration: InputDecoration(
                        labelText: 'Enter Date check in',
                        icon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          checkInController.text = formattedDate;
                        } else {
                          print('Date is not selected');
                        }
                      },
                    ),
                    TextField(
                      controller: checkOutController,
                      decoration: InputDecoration(
                        labelText: 'Enter Date check out',
                        icon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDatex = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDatex != null) {
                          String formattedDatex =
                              DateFormat('yyyy-MM-dd').format(pickedDatex);
                          checkOutController.text = formattedDatex;
                        } else {
                          print('Date is not selected');
                        }
                      },
                    ),
                    ElevatedButton(
                        style: style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var name = nameController.text;
                            var number = numberController.text;
                            var type = typeController.text;
                            var checkIn = checkInController.text;
                            var checkOut = checkOutController.text;

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            // ignore: prefer_typing_uninitialized_variable

                            Transactions data = Transactions(
                                name: name,
                                number: number,
                                type: type,
                                checkIn: checkIn,
                                checkOut: checkOut);
                            provider.addTransaction(data);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Add data"))
                  ]),
            )));
  }
}
