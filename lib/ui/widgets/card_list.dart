import 'package:bloc_wallet/blocs/card_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../blocs/card_list_bloc.dart';
import 'card_chip.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return StreamBuilder<List<CardResults>>(
      stream: cardListBloc.cardList,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            !snapshot.hasData
                ? CircularProgressIndicator()
                : SizedBox(
                    height:
                        _screenSize.height * 0.8, // 80 porcieto de la pantalla
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return CardModelList(
                          cardModel: snapshot.data[index],
                        );
                      },
                      //snapshot ti[po list card result
                      itemCount: snapshot.data.length,
                      itemWidth: _screenSize.width * 0.68,
                      itemHeight: _screenSize.height * 0.62,
                      layout: SwiperLayout.STACK,
                      duration: 105,
                      scrollDirection: Axis.vertical,

                    ),
                  )
          ],
        );
      },
    );
  }
}

class CardModelList extends StatelessWidget {
  final CardResults cardModel;

  CardModelList({this.cardModel});

  @override
  Widget build(BuildContext context) {
    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 25.0, right: 52.0),
          child: Image(
            image: AssetImage(getImage(cardModel.cardNumber)),
            width: 65,
            height: 32,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 52.0),
          child: Text(
            cardModel.cardType,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
    final _cardNumber = Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildDots(),
        ],
      ),
    );
    final _cardLastNumber = Padding(
        padding: const EdgeInsets.only(top: 1.0, left: 55.0),
        child: Text(
          cardModel.cardNumber.substring(12),
          style: TextStyle(color: Colors.white, fontSize: 8.0),
        ));
    final _cardValidTru = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'valid',
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              ),
              Text(
                'thru',
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              )
            ],
          ),
          SizedBox(width: 5.0),
          Text(
            '${cardModel.cardMonth}/${cardModel.cardYear.substring(2)}',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          )
        ],
      ),
    );
    final _cardOwner = Padding(
      padding: const EdgeInsets.only(top:15.0, left: 35.0),
      child: Text(
        cardModel.cardHolderName,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: cardModel.cardColor,
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _cardLogo,
            CardChip(),
            _cardNumber,
            _cardLastNumber,
            _cardValidTru,
            _cardOwner
          ],
        ),
      ),
    );
  }

  String getImage(String cardNumber) {
    if (cardNumber.startsWith("4")) {
      return 'assets/visa_logo.png';
    }
    return 'assets/mastercard_logo.png';
  }

  Widget _buildDots() {
    List<Widget> dotList = new List<Widget>();
    for (var i = 0; i < 12; i++) {
        dotList.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ));
      if (((i + 1) % 4) == 0) {
        dotList.add(SizedBox(
          width: 40.0,
        ));
      }
    }
    dotList.add(
      Text(
        cardModel.cardNumber.substring(12),
        style: TextStyle(color: Colors.white),
      ),
    );
    return Row(children: dotList);
  }
}
