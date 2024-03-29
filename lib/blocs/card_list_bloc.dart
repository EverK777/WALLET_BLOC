import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/card_model.dart';
import 'dart:convert';
import '../helpers/card_colors.dart';

class CardListBloc {
  BehaviorSubject<List<CardResults>> _cardsCollection =
      BehaviorSubject<List<CardResults>>();

  List<CardResults> _cardResults;

  //Retrieve data from stream
  Stream<List<CardResults>> get cardList => _cardsCollection.stream;

  void initialData() async {
    var initialData = await rootBundle.loadString('data/initialData.json');
    print(initialData);
    var decodedJson = jsonDecode(initialData);
    _cardResults = Card.fromJson(decodedJson).cardResults;
    for(var i =0; i< _cardResults.length; i++){
      _cardResults[i].cardColor = CardColors.baseColors[i];
    }
    _cardsCollection.sink.add(_cardResults);
  }

  CardListBloc(){
    initialData();
  }

  void dispose() {
    _cardsCollection.close();
  }

  void addCardToList(CardResults newCard){
    _cardResults.add(newCard);
    _cardsCollection.sink.add(_cardResults);
  }
}
final cardListBloc = CardListBloc();