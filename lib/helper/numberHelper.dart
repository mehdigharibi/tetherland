import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String separateThousands(String number) {
  number = double.parse(number).round().toString();
  String formattedNumber = number;
  //  formattedNumber =
  String separatedNumber = '';

  int count = 0;
  for (int i = formattedNumber.length - 1; i >= 0; i--) {
    separatedNumber = formattedNumber[i] + separatedNumber;
    count++;
    if (count == 3 && i > 0) {
      separatedNumber = ',' + separatedNumber;
      count = 0;
    }
  }
  // separatedNumber = int.parse(separatedNumber).floor().toString();

  return separatedNumber;
}
