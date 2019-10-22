import 'package:bloc_wallet/blocs/bloc_provider.dart';
import 'package:bloc_wallet/blocs/card_bloc.dart';
import 'package:bloc_wallet/ui/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_create.dart';

class CardType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _buildTextInfo = Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text.rich(
        TextSpan(
            text:
                'You can now add gift cards with a specific balance into wallet. When the card hits \$0.00 it will automatically dissapear. Want to know if your gift card will link? ',
            style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
            children: <TextSpan>[
              TextSpan(
                  text: 'Learn More',
                  style: TextStyle(
                      color: Colors.lightBlue, fontWeight: FontWeight.bold))
            ]),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        appBarTitle: 'Select Type',
        leadingIcon: Icons.clear,
        context: context,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildRaiseButton(
                Colors.black, 'Credit Card', Colors.white, context),
            _buildRaiseButton(
                Colors.lightBlue, 'Debit Card', Colors.white, context),
            _buildRaiseButton(
                Colors.redAccent, 'Gift Card', Colors.white, context),
            _buildTextInfo,
          ],
        ),
      ),
    );
  }

  Widget _buildRaiseButton(Color buttonColor, String buttonText,
      Color textColor, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0,left: 10.0,right: 10.0),
        child: RaisedButton(
          elevation: 1.0,
          color: buttonColor,
          child: Text(buttonText,style: TextStyle(color: Colors.white),),
          onPressed: () {
            var blocProviderCardCreate = BlocProvider(
              bloc: CardBloc(),
              child: CardCreate(),
            );
            blocProviderCardCreate.bloc.selectCardType(buttonText);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => blocProviderCardCreate));
          },
        ));
  }
}
