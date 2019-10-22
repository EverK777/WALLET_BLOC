import 'dart:async';
import 'package:bloc_wallet/blocs/bloc_provider.dart';
import 'package:bloc_wallet/blocs/card_list_bloc.dart';
import 'package:bloc_wallet/blocs/validators.dart';
import 'package:bloc_wallet/models/card_color.dart';
import 'package:bloc_wallet/models/card_model.dart';
import 'package:rxdart/rxdart.dart';
import '../helpers/card_colors.dart';

class CardBloc with Validators implements BlocBase {
  BehaviorSubject<String> _cardHolderName = BehaviorSubject<String>();
  BehaviorSubject<String> _cardNumber = BehaviorSubject<String>();
  BehaviorSubject<String> _cardMonth = BehaviorSubject<String>();
  BehaviorSubject<String> _cardYear = BehaviorSubject<String>();
  BehaviorSubject<String> _cardCvv = BehaviorSubject<String>();
  BehaviorSubject<int> _cardColorIndexSelected = BehaviorSubject.seeded(0);
  BehaviorSubject<String> _cardType = BehaviorSubject<String>();

  final _cardColors = BehaviorSubject<List<CardColor>>();

//Add data stream
  Function(String) get changeCardHolderName => _cardHolderName.sink.add;
  Function(String) get changeCardNumber => _cardNumber.sink.add;
  Function(String) get changeCardMonth => _cardMonth.sink.add;
  Function(String) get changeCardYear => _cardYear.sink.add;
  Function(String) get changeCardCvv => _cardCvv.sink.add;
  Function(String) get selectCardType => _cardType.sink.add;


  //Retrieve3 data from stream
  Stream<String>get cardHolderName => _cardHolderName.stream.transform(validateCardHolderName);
  Stream<String>get cardNumber => _cardNumber.stream.transform(validateCardNumber);
  Stream<String>get cardMonth => _cardMonth.stream.transform(validateCardMonth);
  Stream<String>get cardYear => _cardYear.stream.transform(validateCardYear);
  Stream<String>get cardCvv => _cardCvv.stream.transform(validateCardVerificationValue);
  Stream<String>get cardType => _cardType.stream;
  //manipulate color index
  Stream<int>get cardColorIndexSelected => _cardColorIndexSelected.stream;
  //manage data color
  Stream<List<CardColor>>get cardColorList => _cardColors.stream;
  Stream<bool> get saveCardValid => Observable.combineLatest5(
      cardHolderName, cardNumber, cardMonth, cardYear, cardCvv, (ch,cn,cm,cy,cv)=>true);

  void saveCard(){
    final newCard = CardResults(
      cardHolderName:  _cardHolderName.value,
      cardNumber:  _cardNumber.value.replaceAll(RegExp(r'\s+\b|\b\s'), ''),
      cardMonth: _cardMonth.value,
      cardYear: _cardYear.value,
      cardCvv: _cardCvv.value,
      cardColor: CardColors.baseColors[_cardColorIndexSelected.value],
      cardType: _cardType.value);
    cardListBloc.addCardToList(newCard);
  }


  void selectCardColor(int colorIndex){
    CardColors.cardColors.forEach((element) => element.isSelected = false);
    CardColors.cardColors[colorIndex].isSelected = true;
    _cardColors.sink.add(CardColors.cardColors);
    _cardColorIndexSelected.sink.add(colorIndex);

  }


  void dispose() {
    _cardType.close();
    _cardCvv.close();
    _cardHolderName.close();
    _cardMonth.close();
    _cardYear.close();
    _cardNumber.close();
    _cardColors.close();
    _cardColorIndexSelected.close();
  }
}
