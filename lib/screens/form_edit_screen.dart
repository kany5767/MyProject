// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_db/models/transactions.dart';

class FormEditScreen extends StatefulWidget {
  final Transactions data;

  //Controller

  const FormEditScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<FormEditScreen> createState() => _FormEditScreenState();
}

class _FormEditScreenState extends State<FormEditScreen> {
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final typeController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),);

  @override
  void initState() {
    super.initState();
    idController.text = widget.data.id.toString();
    nameController.text = widget.data.name.toString();
    numberController.text = widget.data.number.toString();
    typeController.text = widget.data.type.toString();
    checkInController.text = widget.data.checkIn.toString();
    checkOutController.text = widget.data.checkOut.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Edit Form', 
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 25,),),),
        
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      enabled: false,
                      style: const TextStyle(color: Colors.black54),
                      decoration: const InputDecoration(labelText: "Your Id"),
                      autofocus: false,
                      controller: idController,
                    ),
                    
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Your Name"),
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Your Name.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Room number"),
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
                        labelText: 'Enter Date',
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
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: 'Enter Date',
                        // ignore: prefer_const_constructors
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
                          checkOutController.text = formattedDate;
                        } else {
                          print('Date is not selected');
                        }
                      },
                    ),
                    ElevatedButton(
                        style: 
                        style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var id = int.parse(idController.text);
                            var name = nameController.text;
                            var number = numberController.text;
                            var type = typeController.text;
                            var checkIn = checkInController.text;
                            var checkOut = checkOutController.text;

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            Transactions data = Transactions(
                                id: id,
                                name: name,
                                number: number,
                                type: type,
                                checkIn: widget.data.checkIn,
                                checkOut: widget.data.checkOut);
                            provider.updateTransaction(data);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Save data", 
                        // ignore: unnecessary_const
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255)),))
                  ]),
            )));
  }
}
