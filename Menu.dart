import 'dart:io';

void main() {
  int i = 1;
  var choice;
  bool isChoosing = true;
  List<String> options = ["3 3", "3 7", "Double korat"];
  do {
    print("Choisissez un extra. Appuyez sur e pour commencer");
    for (int i = 0; i < options.length; i++) {
      print("${i + 1}-${options[i]}");
    }
    choice = stdin.readLineSync();
    switch (choice) {
      case "1":
        options.removeAt(0);
        break;
      case "2":
        options.removeAt(1);
        break;
      case "3":
        options.removeAt(2);
        break;
      default:
        isChoosing = false;
        break;
    }
  } while (isChoosing);
}
