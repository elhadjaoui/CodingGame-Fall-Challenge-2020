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
  int get mmax => [d0, d1, d2, d3].reduce((max));
  int get sum => d0 + d1 + d2 + d3;
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

class LearntSpells {
  int d0;
  int d1;
  int d2;
  int d3;
  int id;
  int castable;
  int repeatable;
  int taxcount;
  int taxindex;
  int best = 0;
  int time;
  LearntSpells(
      {this.d0,
      this.d1,
      this.d2,
      this.d3,
      this.id,
      this.castable,
      this.taxcount,
      this.taxindex,
      this.repeatable,
      this.time});
  int get mmax => [d0, d1, d2, d3].reduce((max));
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
  List<Spells> goodSpells = List();
  List<Spells> badSpells = List();
  List<LearntSpells> addlearnetSpells = List();
  Orders od;
  Spells sp;
  int i = 0;
  bool bol = true;
  LearntSpells lsp;
  IngredientsNedded nedded = IngredientsNedded();
  IngredientsNedded newNeed = IngredientsNedded();
  myInventory inv;
  int getTime(int a, int b, int c, int d) {
    return (a + (b * 2) + (b * 3) + (b * 4));
  }

  getFirstLSP(List<LearntSpells> learnetSpells) {
    print("LEARN ${learnetSpells.first.id}");
  }

  Orders getBestOrder(List<Orders> orders, myInventory inv) {
    int scoreforTime = 5;
    int scoreforPrice = 1;
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

  Spells getBestSpell(List<Spells> spells, myInventory inv,
      IngredientsNedded need)
  {
    int rank = 1;
    Spells ss = Spells(d0: 77,d1: 77,d2: 77,d3: 77);
    goodSpells.clear();
    badSpells.clear();

    if (need.inv0 != 77) {
      spells.forEach((element) {
        if (element.d0 > 0) {
          if (inv.inv1 + element.d1 >= 0 &&
              inv.inv2 + element.d2 >= 0 &&
              inv.inv3 + element.d3 >= 0 &&
              (inv.sum + element.sum) <= 10) {
            if (element.castable == 1)
              element.best += 10;
            if (element.d1 > 0) element.best += 5;
            if (element.d3 > 0) element.best += 5;
            if (element.d2 > 0) element.best += 5;
            if (element.d2 == 0 && element.d3 == 0 && element.d1 ==0)
              element.best += 10;
            goodSpells.add(element);
          }
          else {
            if (element.castable == 1) element.best += 5;
            if (element.d1 > 0) element.best += 1;
            if (element.d3 > 0) element.best += 1;
            if (element.d2 > 0) element.best += 1;
            badSpells.add(element);
          }
        }
      });
      if (goodSpells.length != 0)
      {
        goodSpells.sort((a, b) => a.d0.compareTo(b.d0));
        goodSpells.forEach((element) {
          element.best += rank;
          ++rank;
        });
        goodSpells.sort((a, b) => a.best.compareTo(b.best));
          ss = goodSpells.last;
      }
      else if (badSpells.length != 0)
        {
          badSpells.sort((a, b) => a.d0.compareTo(b.d0));
          badSpells.forEach((element) {
            element.best += rank;
            ++rank;
          });
          badSpells.sort((a, b) => a.best.compareTo(b.best));
          newNeed.inv0 = (inv.inv0 + badSpells.last.d0 >= 0)
              ? 77
              : inv.inv0 + badSpells.last.d0;
          newNeed.inv1 = (inv.inv1 + badSpells.last.d1 >= 0)
              ? 77
              : inv.inv1 + badSpells.last.d1;
          newNeed.inv2 = (inv.inv2 + badSpells.last.d2 >= 0)
              ? 77
              : inv.inv2 + badSpells.last.d2;
          newNeed.inv3 = (inv.inv3 + badSpells.last.d3 >= 0)
              ? 77
              : inv.inv3 + badSpells.last.d3;
          ss = getBestSpell(spells, inv,  newNeed);
        }
    }
    else if (need.inv1 != 77) {
      spells.forEach((element) {
        if (element.d1 > 0) {
          stderr.write("sdfghsfhs");
          if (inv.inv0 + element.d0 >= 0 &&
              inv.inv2 + element.d2 >= 0 &&
              inv.inv3 + element.d3 >= 0 &&
              (inv.sum + element.sum) <= 10) {
            if (element.castable == 1) element.best += 10;
            if (element.d0 > 0) element.best += 5;
            if (element.d3 > 0) element.best += 5;
            if (element.d2 > 0) element.best += 5;
            if (element.d2 == 0 && element.d3 == 0 && element.d0 ==0)
              element.best += 10;
            goodSpells.add(element);
          }
          else {
            if (element.castable == 1) element.best += 5;
            if (element.d0 > 0) element.best += 1;
            if (element.d3 > 0) element.best += 1;
            if (element.d2 > 0) element.best += 1;
            goodSpells.add(element);
          }
        }
      });

      if (goodSpells.length == 0)
        ss = Spells(d0: 77,d1: 77,d2: 77,d3: 77);
      else {
        goodSpells.sort((a, b) => a.d1.compareTo(b.d1));
        goodSpells.forEach((element) {
          element.best += rank;
          ++rank;
        });
        goodSpells.sort((a, b) => a.best.compareTo(b.best));
        if (inv.inv1 + goodSpells.last.d1 >= 0 &&
            inv.inv2 + goodSpells.last.d2 >= 0 &&
            inv.inv0 + goodSpells.last.d0 >= 0 &&
            (inv.sum + goodSpells.last.sum) <= 10)
          ss = goodSpells.last;
        else if ((inv.sum + goodSpells.last.sum) <= 10) {
          print("hhhhhhhere 11");
          newNeed.inv0 = (inv.inv0 + goodSpells.last.d0 >= 0)
              ? 77
              : inv.inv0 + goodSpells.last.d0;
          newNeed.inv1 = (inv.inv1 + goodSpells.last.d1 >= 0)
              ? 77
              : inv.inv1 + goodSpells.last.d1;
          newNeed.inv2 = (inv.inv2 + goodSpells.last.d2 >= 0)
              ? 77
              : inv.inv2 + goodSpells.last.d2;
          newNeed.inv3 = (inv.inv3 + goodSpells.last.d3 >= 0)
              ? 77
              : inv.inv3 + goodSpells.last.d3;
          stderr.writeln(" 1  = ${need.inv0} ${need.inv1} ${need.inv2} ${need.inv3}");
          ss = getBestSpell(spells, inv,  newNeed);
          stderr.writeln(" ss 1  = ${ss.d0} ${ss.d1} ${ss.d2} ${ss.d3}");
        }

        else
          ss = Spells(d0: 77,d1: 77,d2: 77,d3: 77);
      }
    }

    else if (need.inv2 != 77) {

      spells.forEach((element) {
        if (element.d2 > 0) {
          if (inv.inv1 + element.d1 >= 0 &&
              inv.inv0 + element.d0 >= 0 &&
              inv.inv3 + element.d3 >= 0 &&
              (inv.sum + element.sum) <= 10) {
            if (element.castable == 1)
              element.best += 10;
            if (element.d0 > 0) element.best += 5;
            if (element.d3 > 0) element.best += 5;
            if (element.d1 > 0) element.best += 5;
            if (element.d1 == 0 && element.d3 == 0 && element.d0 ==0) element.best += 10;
            goodSpells.add(element);
          }
          else {
            if (element.castable == 1) element.best += 5;
            if (element.d0 > 0) element.best += 1;
            if (element.d3 > 0) element.best += 1;
            if (element.d1 > 0) element.best += 1;
            goodSpells.add(element);
          }
        }
      });

      if (goodSpells.length == 0)
        ss = Spells(d0: 77,d1: 77,d2: 77,d3: 77);
      else {

        goodSpells.sort((a, b) => a.d2.compareTo(b.d2));
        goodSpells.forEach((element) {
          element.best += rank;
          ++rank;
        });
        goodSpells.sort((a, b) => a.best.compareTo(b.best));
        if (inv.inv1 + goodSpells.last.d1 >= 0 &&
            inv.inv2 + goodSpells.last.d2 >= 0 &&
            inv.inv0 + goodSpells.last.d0 >= 0 &&
            (inv.sum + goodSpells.last.sum) <= 10)
          {
            ss = goodSpells.last;
          }

        else if ((inv.sum + goodSpells.last.sum) <= 10) {
          stderr.write("hhhhhhhere 22");
          newNeed.inv0 = (inv.inv0 + goodSpells.last.d0 >= 0)
              ? 77
              : inv.inv0 + goodSpells.last.d0;
          newNeed.inv1 = (inv.inv1 + goodSpells.last.d1 >= 0)
              ? 77
              : inv.inv1 + goodSpells.last.d1;
          newNeed.inv2 = (inv.inv2 + goodSpells.last.d2 >= 0)
              ? 77
              : inv.inv2 + goodSpells.last.d2;
          newNeed.inv3 = (inv.inv3 + goodSpells.last.d3 >= 0)
              ? 77
              : inv.inv3 + goodSpells.last.d3;
          stderr.writeln(" 2 = ${need.inv0} ${need.inv1} ${need.inv2} ${need.inv3}");
          ss = getBestSpell(spells, inv, newNeed);
          stderr.writeln(" ss 2  = ${ss.d0} ${ss.d1} ${ss.d2} ${ss.d3}");
        }
        else
          ss = Spells(d0: 77,d1: 77,d2: 77,d3: 77);
      }
    }


    else if (need.inv3 != 77) {
      spells.forEach((element) {
        if (element.d3 > 0) {
          if (inv.inv1 + element.d1 >= 0 &&
              inv.inv2 + element.d2 >= 0 &&
              inv.inv0 + element.d0 >= 0 &&
              (inv.sum + element.sum) <= 10) {
            if (element.castable == 1) element.best += 10;
            if (element.d0 > 0) element.best += 5;
            if (element.d2 > 0) element.best += 5;
            if (element.d1 > 0) element.best += 5;
            if (element.d2 == 0 && element.d1 == 0 && element.d0 ==0) element.best += 10;
            goodSpells.add(element);
          }
          else {
            if (element.castable == 1) element.best += 5;
            if (element.d0 > 0) element.best += 1;
            if (element.d2 > 0) element.best += 1;
            if (element.d1 > 0) element.best += 1;
            goodSpells.add(element);
          }
        }
      });

      if (goodSpells.length == 0) {
        ss = Spells(d0: 77,d1: 77,d2: 77,d3: 77);
      } else {
        goodSpells.sort((a, b) => a.d3.compareTo(b.d3));
        goodSpells.forEach((element) {
          element.best += rank;
          ++rank;
        });
        goodSpells.sort((a, b) => a.best.compareTo(b.best));
        if (inv.inv1 + goodSpells.last.d1 >= 0 &&
            inv.inv2 + goodSpells.last.d2 >= 0 &&
            inv.inv0 + goodSpells.last.d0 >= 0 &&
            (inv.sum + goodSpells.last.sum) <= 10)
          ss = goodSpells.last;
        else if ((inv.sum + goodSpells.last.sum) <= 10) {
          print("hhhhhhhere 333");
          newNeed.inv0 = (inv.inv0 + goodSpells.last.d0 >= 0)
              ? 77
              : inv.inv0 + goodSpells.last.d0;
          newNeed.inv1 = (inv.inv1 + goodSpells.last.d1 >= 0)
              ? 77
              : inv.inv1 + goodSpells.last.d1;
          newNeed.inv2 = (inv.inv2 + goodSpells.last.d2 >= 0)
              ? 77
              : inv.inv2 + goodSpells.last.d2;
          newNeed.inv3 = (inv.inv3 + goodSpells.last.d3 >= 0)
              ? 77
              : inv.inv3 + goodSpells.last.d3;
          stderr.writeln(" 3  = ${need.inv0} ${need.inv1} ${need.inv2} ${need.inv3}");
          ss = getBestSpell(spells, inv,  newNeed);
          stderr.writeln(" ss 3  = ${ss.d0} ${ss.d1} ${ss.d2} ${ss.d3}");
        }
        else
          ss = Spells(d0: 77,d1: 77,d2: 77,d3: 77);
      }
    }

    stderr.writeln(" ss   = ${ss.d0} ${ss.d1} ${ss.d2} ${ss.d3}");
    return ss;

    // return element;
  }

  // game loop
  while (true) {
    bol = true;
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
      if (actionType == "LEARN") {
        addlearnetSpells.add(LearntSpells(
          d0: delta0,
          d1: delta1,
          d2: delta2,
          d3: delta3,
          repeatable: repeatable,
          taxcount: taxCount,
          taxindex: tomeIndex,
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
    stderr.writeln("${nedded.inv0} ${nedded.inv1} ${nedded.inv2} ${nedded.inv3}");
    stderr.writeln("${od.id} ${od.d0} ${od.d1} ${od.d2} ${od.d3} ${od.price}");

    for (Orders element in addOrders) {
      if (inv.inv0 + element.d0 >= 0 &&
          inv.inv1 + element.d1 >= 0 &&
          inv.inv2 + element.d2 >= 0 &&
          inv.inv3 + element.d3 >= 0) {
        print('BREW ${element.id}');
        bol = false;
        break;
      }
    }

    if (bol) {
      if (i < 10)
        getFirstLSP(addlearnetSpells);
      else {
        sp = getBestSpell(addSpells, inv, nedded);
        if (sp.d0 != 77) {
          if (sp.castable == 0)
            print('REST');
          else
            print('CAST ${sp.id}');
        } else {
          if (addlearnetSpells.length != 0)
          print("LEARN ${addlearnetSpells.first.id}");
          else
            print("WAIT");
          stderr.writeln("here [][][][][]");
        }
      }
    }

    addOrders.clear();
    addSpells.clear();
    addlearnetSpells.clear();
    goodSpells.clear();
    i++;

    // Write an action using print()
    // To debug: stderr.writeln('Debug messages...');

    // in the first league: BREW <id> | WAIT; later: BREW <id> | CAST <id> [<times>] | LEARN <id> | REST | WAIT
  }
}
