import 'package:flutter/material.dart';


Widget cardNumber({required int number , required double side}){

  return Container(
    height: side,
    width: side,
    decoration:  BoxDecoration(
      color:  Colors.blueAccent, //Color((number.toDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      borderRadius: const BorderRadius.all(Radius.circular(5)),

    ),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(number.toString(), style:const TextStyle(color: Colors.white),),
    ),

  );
}