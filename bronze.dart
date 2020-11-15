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

class Spells {
  int d0;
  int d1;
  int d2;
  int d3;
  int id;
  int castable;
  int best = 0;
  int time;
  Spells(
      {this.d0, this.d1, this.d2, this.d3, this.id, this.castable, this.time});
    int get mmax => [d0,d1,d2,d3].reduce((max));
}

class myInventory {
  int inv0;
  int inv1;
  int inv2;
  int inv3;
  int score;
  myInventory({this.inv0, this.inv1, this.inv2, this.inv3, this.score});
  int get sum => inv0 + inv1 + inv2 + inv3;
}

class IngredientsNedded {
  int inv0;
  int inv1;
  int inv2;
  int inv3;
  IngredientsNedded({
    this.inv0,
    this.inv1,
    this.inv2,
    this.inv3,
  });
}

void main() {
  List inputs;
  List<Orders> addOrders = List();
  List<Spells> addSpells = List();
  Orders od;
  Spells sp;
  IngredientsNedded nedded = IngredientsNedded();
  myInventory inv;
  int getTime(int a, int b, int c, int d) {
    return (a + (b * 2) + (b * 3) + (b * 4));
  }

  Orders getBestOrder(List<Orders> orders, myInventory inv) {
    int scoreforTime = 4;
    int scoreforPrice = 1;
    /*  orders.forEach((element) {
      if (element.d0 > inv.inv0 ||
          element.d1 > inv.inv1 ||
          element.d2 > inv.inv2 ||
          element.d3 > inv.inv3) orders.remove(element);
    });*/
    orders.sort((a, b) => a.time.compareTo(b.time));
    orders.forEach((element) {
      element.best += scoreforTime;
      --scoreforTime;
    });

    orders.sort((a, b) => a.price.compareTo(b.price));
    orders.forEach((element) {
      element.best += scoreforPrice;
      ++scoreforPrice;
    });
    orders.sort((a, b) => a.best.compareTo(b.best));

    return orders.last;
  }

  Spells getBestSpell(List<Spells> spells, myInventory inv, Orders bestorder,
      IngredientsNedded need) {
    if (nedded.inv0 != 77)
    {
        spells.sort((a, b) => a.d0.compareTo(b.d0));
        if (spells.last.d0 + inv.inv0 >= 0 && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
    }
      
      if (nedded.inv1 != 77)
     {
         spells.sort((a, b) => a.d1.compareTo(b.d1));
          if (spells.last.d1 + inv.inv1 >= 0 && spells.last.d0 + inv.inv0 >= 0 && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
          else
          {
              spells.sort((a, b) => a.d0.compareTo(b.d0));
             if (spells.last.d0 + inv.inv0 >= 0 && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
          }
     }
     
     if (nedded.inv2 != 77)
     {
        spells.sort((a, b) => a.d2.compareTo(b.d2));
         if (spells.last.d2 + inv.inv2 >= 0 && spells.last.d1 + inv.inv1 >= 0 
         && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
          else
          {
      spells.sort((a, b) => a.d1.compareTo(b.d1));
          if (spells.last.d1 + inv.inv1 >= 0 && spells.last.d0 + inv.inv0 >= 0 && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
          else
          {
              spells.sort((a, b) => a.d0.compareTo(b.d0));
             if (spells.last.d0 + inv.inv0 >= 0 && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
          }
          }
          

     }
      
     if (nedded.inv3 != 77) 
     {
        spells.sort((a, b) => a.d3.compareTo(b.d3));
        if (spells.last.d3 + inv.inv3 >= 0 && spells.last.d2 + inv.inv2 >= 0
           && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
        else
          {
         spells.sort((a, b) => a.d2.compareTo(b.d2));
         if (spells.last.d2 + inv.inv2 >= 0 && spells.last.d1 + inv.inv1 >= 0 
         && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
          else
          {
      spells.sort((a, b) => a.d1.compareTo(b.d1));
          if (spells.last.d1 + inv.inv1 >= 0 && spells.last.d0 + inv.inv0 >= 0 && (inv.sum + spells.last.mmax) <= 10)
          return spells.last;
          else
          {
              spells.sort((a, b) => a.d0.compareTo(b.d0));
             if (spells.last.d0 + inv.inv0 >= 0)
          return spells.last;
          }
          }
          }
         
     }
     
   spells.sort((a, b) => a.mmax.compareTo(b.mmax));
     return spells.last;
      
   // return spells.last;
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
      int tomeIndex = int.parse(inputs[
          7]); // in the first two leagues: always 0; later: the index in the tome if this is a tome spell, equal to the read-ahead tax
      int taxCount = int.parse(inputs[
          8]); // in the first two leagues: always 0; later: the amount of taxed tier-0 ingredients you gain from learning this spell
      int castable = int.parse(inputs[
          9]); // in the first league: always 0; later: 1 if this is a castable player spell
      int repeatable = int.parse(inputs[
          10]); // for the first two leagues: always 0; later: 1 if this is a repeatable player spell
      if (actionType == "BREW") {
        addOrders.add(Orders(
            d0: delta0,
            d1: delta1,
            d2: delta2,
            d3: delta3,
            id: actionId,
            price: price,
            time: getTime(delta0, delta1, delta2, delta3)));
      }
      if (actionType == "CAST") {
        addSpells.add(Spells(
          d0: delta0,
          d1: delta1,
          d2: delta2,
          d3: delta3,
          castable: castable,
          id: actionId,
        ));
      }
    }
    for (int i = 0; i < 2; i++) {
      inputs = stdin.readLineSync().split(' ');
      if (i == 0) {
        int inv0 = int.parse(inputs[0]); // tier-0 ingredients in inventory
        int inv1 = int.parse(inputs[1]);
        int inv2 = int.parse(inputs[2]);
        int inv3 = int.parse(inputs[3]);
        int score = int.parse(inputs[4]);
        inv = myInventory(
            inv0: inv0, inv1: inv1, inv2: inv2, inv3: inv3, score: score);
      }
    }
    od = getBestOrder(addOrders, inv);
    nedded.inv0 = (inv.inv0 + od.d0 >= 0) ? 77 : inv.inv0 + od.d0;
    nedded.inv1 = (inv.inv1 + od.d1 >= 0) ? 77 : inv.inv1 + od.d1;
    nedded.inv2 = (inv.inv2 + od.d2 >= 0) ? 77 : inv.inv2 + od.d2;
    nedded.inv3 = (inv.inv3 + od.d3 >= 0) ? 77 : inv.inv3 + od.d3;
    stderr.writeln("${inv.inv0} ${inv.inv1} ${inv.inv2} ${inv.inv3}");
    stderr
        .writeln("${nedded.inv0} ${nedded.inv1} ${nedded.inv2} ${nedded.inv3}");
    stderr.writeln("${od.id} ${od.d0} ${od.d1} ${od.d2} ${od.d3}");
    if (inv.inv0 + od.d0 >= 0 &&
        inv.inv1 + od.d1 >= 0 &&
        inv.inv2 + od.d2 >= 0 &&
        inv.inv3 + od.d3 >= 0) {
      stderr.writeln(nedded.inv0);
      stderr.writeln(od.d0);
      print('BREW ${od.id}');
    } else {
      sp = getBestSpell(addSpells, inv, od, nedded);
      if (sp.castable == 0)
        print('REST');
      else
        print('CAST ${sp.id}');
    }
    addOrders.clear();
    addSpells.clear();

    // Write an action using print()
    // To debug: stderr.writeln('Debug messages...');

    // in the first league: BREW <id> | WAIT; later: BREW <id> | CAST <id> [<times>] | LEARN <id> | REST | WAIT
  }
}
