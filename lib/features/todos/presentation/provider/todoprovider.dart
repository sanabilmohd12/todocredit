import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier{


   TextEditingController todoAmountController = TextEditingController();
  TextEditingController todoitemController = TextEditingController();
  bool isCredited = true;


void toggleCreditedUpdate(bool value) {
    isCredited = value;
    notifyListeners();
  }


}