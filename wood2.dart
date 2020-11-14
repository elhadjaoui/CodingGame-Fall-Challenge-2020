import 'dart:io';
import 'dart:math';

class Orders {
  int d0;
  int d1;
  int d2;
  int d3;
  int id;
  int price;
  int best = 0;
  int time;
  Orders({this.d0, this.d1, this.d2, this.d3, this.id, this.price, this.time});
}

void main() {
  List inputs;
  List<Orders> addOrders = List();
  int inv0;
  int inv1;
  int inv2;
  int inv3;
  int score;
  int getTime(int a, int b, int c, int d) {
    return (a + (b * 2) + (b * 3) + (b * 4));
  }

  // game loop
  while (true) {
    int actionCount = int.parse(
        stdin.readLineSync()); // the number of spells and recipes in play
    for (int i = 0; i < actionCount; i++) {
      inputs = stdin.readLineSync().split(' ');
      int actionId =
          int.parse(inputs[0]); // the unique ID of this spell or recipe
      String actionType = inputs[
          1]; // in the first league: BREW; later: CAST, OPPONENT_CAST, LEARN, BREW
      int delta0 = int.parse(inputs[2]); // tier-0 ingredient change
      int delta1 = int.parse(inputs[3]); // tier-1 ingredient change
      int delta2 = int.parse(inputs[4]); // tier-2 ingredient change
      int delta3 = int.parse(inputs[5]); // tier-3 ingredient change
      int price =
          int.parse(inputs[6]); // the price in rupees if this is a potion
      int tomeIndex = int.parse(inputs[7]); // in the first two leagues: always 0; later: the index in the tome if this is a tome spell, equal to the read-ahead tax
      int taxCount = int.parse(inputs[8]); // in the first two leagues: always 0; later: the amount of taxed tier-0 ingredients you gain from learning this spell
      int castable = int.parse(inputs[9]); // in the first league: always 0; later: 1 if this is a castable player spell
      int repeatable = int.parse(inputs[10]); // for the first two leagues: always 0; later: 1 if this is a repeatable player spell
      addOrders.add(Orders(
          d0: delta0,
          d1: delta1,
          d2: delta2,
          d3: delta3,
          id: actionId,
          price: price,
          time: getTime(delta0, delta1, delta2, delta3)));
    }
    for (int i = 0; i < 2; i++) {
      inputs = stdin.readLineSync().split(' ');
      if (i == 0) {
        inv0 = int.parse(inputs[0]); // tier-0 ingredients in inventory
        inv1 = int.parse(inputs[1]);
        inv2 = int.parse(inputs[2]);
        inv3 = int.parse(inputs[3]);
        score = int.parse(inputs[4]);
      }
    }
    addOrders.forEach((element) {
      if (element.d0 > inv0 ||
          element.d1 > inv1 ||
          element.d2 > inv2 ||
          element.d3 > inv3) addOrders.remove(element);
    });
    addOrders.sort((a, b) => a.time.compareTo(b.time));
    addOrders.first.best += 5;
    addOrders.sort((a, b) => a.price.compareTo(b.price));
    addOrders.last.best += 5;
    addOrders.sort((a, b) => a.best.compareTo(b.best));
    print('BREW ${addOrders.last.id}');
    addOrders.clear();

    // Write an action using print()
    // To debug: stderr.writeln('Debug messages...');

    // in the first league: BREW <id> | WAIT; later: BREW <id> | CAST <id> [<times>] | LEARN <id> | REST | WAIT
    // print('BREW 0');
  }
}
