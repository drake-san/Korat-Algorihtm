import 'dart:io';
import 'dart:math';
import 'Cards.dart';

var first_player;
var currentPlayer;
List distributedCard = [];
List<Player> players = [];
List<Player> remainingPlayers = [];

class Player {
  int id = 0;
  List ownCards = [];
  bool hasHand = false;
  bool isPlaying = false;
  List playerCards = [];
  List playerPlayedCards = [];
  var previous;
  var next;

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
  print(currentPlayer.playerCards);
  print(currentPlayer.next.playerCards);
  print(currentPlayer.previous.playerCards);
}

void Play() {}
