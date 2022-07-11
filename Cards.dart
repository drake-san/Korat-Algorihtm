class Card {
  Card(this.type, this.number);
  CardType type;
  int number;

  @override
  String toString() {
    // TODO: implement toString
    return {"type": getType(type), "number": number}.toString();
  }

  getType(CardType t) {
    switch (t) {
      case CardType.COEUR:
        return "Coeur";
      case CardType.ETOILE:
        return "Etoile";
      case CardType.TREFLE:
        return "Trefle";
      default:
        return "Pique";
    }
  }
}

enum CardType { COEUR, TREFLE, PIQUE, ETOILE }

List<Card> generateCard(List<CardType> cardType,
    {int begin = 3, int end = 10}) {
  List<Card> cards = [];
  for (var i = begin; i <= end; i++) {
    cardType.forEach((type) {
      cards.add(Card(type, i));
    });
  }
  return cards;
}
