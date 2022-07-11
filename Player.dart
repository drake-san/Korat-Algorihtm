import 'dart:io';
import 'dart:math';
import 'Cards.dart';

var first_player;
var currentPlayer;
bool isOver = false;
List<Card> cards = generateCard(
    [CardType.COEUR, CardType.ETOILE, CardType.PIQUE, CardType.TREFLE]);
List<Player> players = [];
List<Player> remainingPlayers = [];

class Player {
  int id = 0;
  List ownCards = [];
  List<Card> playerPlayedCards = [];
  List<Card> playerCard = [];
  var previous;
  var next;
  var entry;

  Player(id, ownCards) {
    this.id = id;
    this.ownCards = ownCards;
  }

  void receiveCards() {
    for (var i = 0; i < 5; i++) {
      int theCard = Random().nextInt(cards.length);
      playerCard.add(cards[theCard]);
      cards.removeAt(theCard);
    }
  }

  void Play() {
    print("Tour du joueur ${id}\n");
    print("Choix de carte");
    ShowCards();
    entry = stdin.readLineSync();
    print("\n");
    switch (entry) {
      case "1":
        playerPlayedCards.add(playerCard[0]);
        ownCards.add(1);
        playerCard.removeAt(0);
        break;
      case "2":
        playerPlayedCards.add(playerCard[1]);
        ownCards.add(1);
        playerCard.removeAt(1);
        break;
      case "3":
        playerPlayedCards.add(playerCard[2]);
        ownCards.add(1);
        playerCard.removeAt(2);
        break;
      case "4":
        playerPlayedCards.add(playerCard[3]);
        ownCards.add(1);
        playerCard.removeAt(3);
        break;
      case "5":
        playerPlayedCards.add(playerCard[4]);
        ownCards.add(1);
        playerCard.removeAt(4);
        break;
      default:
        break;
    }
    print(
        "Le joueur ${id} a joue le ${playerPlayedCards[0].getType(playerPlayedCards[0].type)} ${playerPlayedCards[0].number}\n");
  }
}

void CreatePlayers() {
  for (int i = 0; i < 4; i++) {
    players.add(new Player(
      (i + 1),
      [],
    ));
  }
  for (var v = 0; v < 4; v++) {
    players[v].receiveCards();
  }
}

void SwitchPlayers() {
  int index = Random().nextInt(4);

  first_player = players[index];
  currentPlayer = first_player;
  remainingPlayers = players;
  remainingPlayers.remove(players[index]);

  for (var i = 0; i < remainingPlayers.length; i++) {
    if (i == 0) {
      remainingPlayers[i].previous = first_player;
      remainingPlayers[i].next = players[i + 1];
      first_player.next = players[i];
    } else {
      remainingPlayers[i].previous = players[i - 1];
      if (i == 2) {
        remainingPlayers[i].next = first_player;
        first_player.previous = players[i];
      } else {
        remainingPlayers[i].next = players[i + 1];
      }
    }
  }
  remainingPlayers.insert(0, first_player);
  players = remainingPlayers;
}

void ShowCards() {
  var k = 1;
  for (var i = 0; i < currentPlayer.playerCard.length; i++) {
    print(
        "${k}-${currentPlayer.playerCard[i].getType(currentPlayer.playerCard[i].type)} ${currentPlayer.playerCard[i].number}");
    k++;
  }
}

void Game() {
  currentPlayer = first_player;
  while (!isOver) {
    for (var i = 0; i < players.length; i++) {
      currentPlayer.Play();
      currentPlayer = currentPlayer.next;
    }
    for (var i = 0; i < 4; i++) {
      if (first_player.playerPlayedCards[0].type ==
              currentPlayer.playerPlayedCards[0].type &&
          first_player.playerPlayedCards[0].number <
              currentPlayer.playerPlayedCards[0].number) {
        first_player = currentPlayer;
      }
      currentPlayer = currentPlayer.next;
    }
    currentPlayer = first_player;
    for (var i = 0; i < players.length; i++) {
      players[i].playerPlayedCards.removeAt(0);
    }
    if (players[0].ownCards.length == 5 &&
        players[1].ownCards.length == 5 &&
        players[2].ownCards.length == 5 &&
        players[3].ownCards.length == 5) {
      print("Le joueur ${first_player.id} a gagne");
      isOver = true;
      break;
    }
    print("Le joueur ${currentPlayer.id} a la main\n");
  }
}
