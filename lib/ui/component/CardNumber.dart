import 'package:flutter/material.dart';

import '../../constant/custom_color.dart';


Widget cardNumber({required int number , required double side}){

  return Container(
    height: side,
    width: side,
    padding: const EdgeInsets.all(5),
    decoration:  BoxDecoration(
      color: (number>0)?Color(int.parse(number.toString(), radix: 16) * initColorCard):Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(5)),

    ),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(number.toString(), style: TextStyle(color: (number > 0)?textColorCard: Colors.transparent),),
    ),

  );
}