import 'dart:io';
import 'dart:math';
import 'Cards.dart';

var first_player;
var currentPlayer;
bool isOver = false;
List distributedCard = [];
List<Player> players = [];
List<Player> remainingPlayers = [];
List playedCards = [];

class Player {
  int id = 0;
  List ownCards = [];
  bool hasHand = false;
  bool isPlaying = false;
  List playerCards = [];
  List playerPlayedCards = [];
  List playerPlayedTypeCards = [];
  var previous;
  var next;
  var entry;
  var won = false;

  Player(id, ownCards, hasHand, isPlaying, playerCards) {
    this.id = id;
    this.ownCards = ownCards;
    this.hasHand = hasHand;
    this.isPlaying = isPlaying;
    this.playerCards = playerCards;
  }

  void GiveCards() {
    for (var i = 0; i < 5; i++) {
      var playerCard = getCard(playerCards);
      distributedCard.add(playerCard);
    }
  }

  void Play() {
    print("Tour du joueur ${id}");
    print("Choix de carte");
    ShowCards();
    entry = stdin.readLineSync();
    switch (entry) {
      case "1":
        playerPlayedCards.add(this.playerCards[1]);
        playerPlayedTypeCards.add(this.playerCards[0]);
        ownCards.add(1);
        this.playerCards.removeAt(1);
        this.playerCards.removeAt(0);
        break;
      case "2":
        playerPlayedCards.add(this.playerCards[3]);
        playerPlayedTypeCards.add(this.playerCards[2]);
        ownCards.add(1);
        this.playerCards.removeAt(3);
        this.playerCards.removeAt(2);
        break;
      case "3":
        playerPlayedCards.add(this.playerCards[5]);
        playerPlayedTypeCards.add(this.playerCards[4]);
        ownCards.add(1);
        this.playerCards.removeAt(5);
        this.playerCards.removeAt(4);
        break;
      case "4":
        playerPlayedCards.add(this.playerCards[7]);
        playerPlayedTypeCards.add(this.playerCards[6]);
        ownCards.add(1);
        this.playerCards.removeAt(7);
        this.playerCards.removeAt(6);
        break;
      case "5":
        playerPlayedCards.add(this.playerCards[9]);
        playerPlayedTypeCards.add(this.playerCards[8]);
        ownCards.add(1);
        this.playerCards.removeAt(9);
        this.playerCards.removeAt(8);
        break;
      default:
        break;
    }
    print(
        "Le joueur ${id} a joue le ${playerPlayedCards[0]} ${playerPlayedTypeCards[0]}");
  }
}

void CreatePlayers() {
  for (int i = 0; i < 4; i++) {
    players.add(new Player((i + 1), [], false, false, []));
  }
  for (var v = 0; v < 4; v++) {
    players[v].GiveCards();
  }
}

void SwitchPlayers() {
  int index = Random().nextInt(4);

  first_player = players[index];
  first_player.hasHand = true;
  first_player.isPlaying = true;
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
  for (var i = 0; i < currentPlayer.playerCards.length; i += 2) {
    print(
        "${k}-${currentPlayer.playerCards[i]} ${currentPlayer.playerCards[i + 1]}");
    k++;
  }
}

void Game() {
  currentPlayer = first_player;
  while (!isOver) {
    for (var i = 0; i < players.length; i++) {
      currentPlayer.Play();
      currentPlayer = currentPlayer.next;
      playedCards.add(players[i].playerPlayedCards);
      if (players[0].ownCards.length == 5 &&
          players[1].ownCards.length == 5 &&
          players[2].ownCards.length == 5 &&
          players[3].ownCards.length == 5) {
        print("Le joueur ${first_player.id} a gagne");
        isOver = true;
      }
    }
    for (var i = 0; i < 4; i++) {
      if (first_player.playerPlayedTypeCards[0] ==
              currentPlayer.playerPlayedTypeCards[0] &&
          first_player.playerPlayedCards[0] <
              currentPlayer.playerPlayedCards[0]) {
        first_player = currentPlayer;
      }
      currentPlayer = currentPlayer.next;
    }
    currentPlayer = first_player;
    for (var i = 0; i < players.length; i++) {
      players[i].playerPlayedCards.removeAt(0);
      players[i].playerPlayedTypeCards.removeAt(0);
    }
  }
}
