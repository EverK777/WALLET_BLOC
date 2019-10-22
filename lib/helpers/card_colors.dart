import 'package:bloc_wallet/models/card_color.dart';
import 'package:flutter/material.dart';

class CardColors{
  static const baseColors = <Color>[
    Color.fromRGBO(61, 132, 223, 1.0),
    Color.fromRGBO(114, 71, 200, 1.0),
    Color.fromRGBO(106, 188, 121, 1.0),
    Color.fromRGBO(229, 92, 131, 1.0),
    Color.fromRGBO(96, 200, 227, 1.0),
    Color.fromRGBO(219, 157, 80, 1.0),
    Color.fromRGBO(60, 61, 63, 1.0),
    Color.fromRGBO(222, 88, 116, 1.0),
    Color.fromRGBO(128, 182, 234, 1.0)
  ];

  static List<CardColor> cardColors = new List<CardColor>.generate(
      baseColors.length,
      (int index)=>
  CardColor(isSelected: false, cardColor: index));
}