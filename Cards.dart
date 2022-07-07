import 'dart:math';

List<String> cardsTypes = ['Coeur', 'Trefle', 'Pique', 'Etoile'];
List<int> cardsNumbers = [3, 4, 5, 6, 7, 8, 9, 10];
var type = null;
var number = null;

List getCard(List distributedCards) {
  type = cardsTypes[Random().nextInt(4)];
  number = cardsNumbers[Random().nextInt(8)];
  do {
    type = cardsTypes[Random().nextInt(4)];
    number = cardsNumbers[Random().nextInt(8)];
  } while (Exist(distributedCards));

  distributedCards.add(type);
  distributedCards.add(number);
  return distributedCards;
}

bool Exist(List distributedCards) {
  bool exist = false;

  for (var i = 0; i < distributedCards.length; i++) {
    if (distributedCards[i] == type && distributedCards[i + 1] == number) {
      exist = true;
      break;
    }
  }
  return exist;
}
