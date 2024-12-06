import 'dart:developer';

import 'package:creditapp/features/todos/presentation/provider/todoprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void addItemPopup(
  BuildContext context, {
  formKey,
  // required String userId,
  // String? username,
}) {
  showDialog(
    context: context,
    builder: (context) {
      
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Consumer<TodoProvider>(
            builder: (context,todo,child) {
              return Container(
                width: 300,
                height: 500,
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Add Todo",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      SwitchListTile(
                        tileColor: Colors.red,
                        selectedTileColor: Colors.green,
                        selected: todo.isCredited,
                        title: Text(
                          todo.isCredited ? 'Credited' : 'Debited',
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: todo.isCredited,
                        onChanged: (bool value) {
                          todo.toggleCreditedUpdate(value);
                        },
                      ),
                      const SizedBox(height: 30),
                      AddItemTextField(
                        labelText: "Todo",
                        context: context,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Todo';
                          }
                          return null;
                        },
                        controller: todo.todoitemController,
                      ),
                      const SizedBox(height: 30),
                      AddItemTextField(
                        labelText: "Amount",
                        keyboardType: TextInputType.number,
                        context: context,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Amount';
                          }
              
                          return null;
                        },
                        controller: todo.todoAmountController,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Buttons(
                              context,
                              label: "Cancel",
                              color: Colors.grey[300]!,
                              textColor: Colors.grey,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Buttons(
                              context,
                              label: "Save",
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final navi = Navigator.of(context);
                                  // todo.addTodos(
                                  //   amountController: todo.todoAmountController,
                                  //   titleController: todo.todoitemController,
                                  //   isCredited: todo.isCredited,
                                  //   context: context,
                                  
                                  // );
                                  log("ggg");
              
                                  navi.pop();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      );
    },
  );
}

Widget Buttons(BuildContext context,
    {required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.03),
    ),
    onPressed: onPressed,
    child: Text(
      label,
      style: TextStyle(color: textColor),
    ),
  );
}

Widget AddItemTextField({
  required String labelText,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  required BuildContext context,
  List<TextInputFormatter>? inputFormatter,
  String? Function(String?)? validator,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    inputFormatters: inputFormatter,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey,
        fontSize: screenWidth * 0.04,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.02,
        horizontal: screenWidth * 0.05,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    ),
    validator: validator,
  );
}
