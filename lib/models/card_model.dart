import 'dart:ui';

class Card {
  List<CardResults> cardResults;

  Card({this.cardResults});

  Card.fromJson(Map<String, dynamic> json) {
    if (json['cardResults'] != null) {
      cardResults = new List<CardResults>();
      json['cardResults'].forEach((v) {
        cardResults.add(new CardResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardResults != null) {
      data['cardResults'] = this.cardResults.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardResults {
  String cardHolderName;
  String cardNumber;
  String cardMonth;
  String cardYear;
  String cardCvv;
  Color cardColor;
  String cardType;

  CardResults(
      {this.cardHolderName,
        this.cardNumber,
        this.cardMonth,
        this.cardYear,
        this.cardCvv,
        this.cardColor,
        this.cardType});

  CardResults.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardNumber = json['cardNumber'];
    cardMonth = json['cardMonth'];
    cardYear = json['cardYear'];
    cardCvv = json['cardCvv'];
    cardColor = json['cardColor'];
    cardType = json['cardType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardHolderName'] = this.cardHolderName;
    data['cardNumber'] = this.cardNumber;
    data['cardMonth'] = this.cardMonth;
    data['cardYear'] = this.cardYear;
    data['cardCvv'] = this.cardCvv;
    data['cardColor'] = this.cardColor;
    data['cardType'] = this.cardType;
    return data;
  }
}