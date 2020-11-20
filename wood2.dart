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
/*
import 'dart:io';
import 'dart:math';

///**************DFS IMPLEMENTATION *******************//
class Node {
  int d0;
  int d1;
  int d2;
  int d3;
  int id;
  int price;
  int best = 0;
  int taxcount = 0;
  int taxindex = 0;
  int castable = 0;
  int repeatable = 0;
  int score = 0;
  bool discovered = false;
  List<Node> links = [];
    int get sum => d0 + d1 + d2 + d3;
  Node(
      {this.d0,
      this.d1,
      this.d2,
      this.d3,
      this.castable,
      this.id,
      this.price,
      this.repeatable,
      this.taxcount,
      this.taxindex,
      this.score});
}

DFS(List<Node> graph,List<Node> move) {
  for (final node in graph) {
    if (!node.discovered) {
      explore(node,move);
    }
  }
}

explore( Node node,List<Node> move) {
  
  if (node.links.length != 0 )
  {
    node.discovered = true;
    for (Node link in node.links) {
    if (!link.discovered) {
      explore(link,move);
    }
  }
  }
   else if (!node.discovered)
   {
      node.discovered = true;
     move.add(node);
   }
    
 
}

////******************** NEDDED CLASSES *******************//

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

////************CREATE GRAPH***************** //////////////

List<Node> Graph(List<Node> orders, Node inventory, List<Node> sp) {
  IngredientsNedded need = IngredientsNedded();
  
  for (Node order in orders )
  {

  
    need.inv0 = (inventory.d0 + order.d0 >= 0) ? 77 : inventory.d0 + order.d0;
    need.inv1 = (inventory.d1 + order.d1 >= 0) ? 77 : inventory.d1 + order.d1;
    need.inv2 = (inventory.d2 + order.d2 >= 0) ? 77 : inventory.d2 + order.d2;
    need.inv3 = (inventory.d3 + order.d3 >= 0) ? 77 : inventory.d3 + order.d3;

     stderr.writeln("${need.inv0} ${need.inv1} ${need.inv2} ${need.inv3}");
    
    //stderr.writeln("${od.id} ${od.d0} ${od.d1} ${od.d2} ${od.d3}");

    if (need.inv0 != 77) {
      sp.forEach((element) {
        if (element.d0 > 0 && !element.discovered) 
        {
            element.links.add(element);
            element.discovered = true;
        }
        
        if (element.links.length != 0)
           Graph(element.links, inventory, sp);
      });
    } 
    else if (need.inv1 != 77) 
    {
         sp.forEach((element) {
        if (element.d0 > 0&& !element.discovered) 
        {
            element.links.add(element);
            element.discovered = true;
        }
        if (element.links.length != 0)
           Graph(element.links, inventory, sp);
      });
    } 
    else if (need.inv2 != 77)
    {
       sp.forEach((element) {
        if (element.d0 > 0&& !element.discovered) 
        {
            element.links.add(element);
            element.discovered = true;
        }
        if (element.links.length != 0)
           Graph(element.links, inventory, sp);
      });
    } 
    else if (need.inv3 != 77) 
    {
       sp.forEach((element) {
        if (element.d0 > 0 && !element.discovered) 
        {
            element.links.add(element);
            element.discovered = true;
        }
        if (element.links.length != 0)
           Graph(element.links, inventory, sp);
      });
    }
  }
  //aware about it so far (make it inside loop)
  sp.forEach((element) {
    element.discovered = false;
  });
  return orders;
}

///******************** MAIN ********************////////
void main() {
  List inputs;
  List<Node> addOrders = List();
  List<Node> addSpells = List();
  List<Node> addlearnetSpells = List();
  Node sp;
  List<Node> bestMove =  List();
  bool bl,ll;
  int i = 0;
  Node inv;

  getFirstLSP(List<Node> learnetSpells) {
    print("LEARN ${learnetSpells.first.id}");
  }

  // game loop
  while (true) {
    bl = true;
    ll = true;
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
        addOrders.add(Node(
          d0: delta0,
          d1: delta1,
          d2: delta2,
          d3: delta3,
          id: actionId,
          price: price,
        ));
      }
      if (actionType == "CAST") {
        addSpells.add(Node(
          d0: delta0,
          d1: delta1,
          d2: delta2,
          d3: delta3,
          castable: castable,
          id: actionId,
        ));
      }
      if (actionType == "LEARN") {
        addlearnetSpells.add(Node(
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
        inv = Node(d0: inv0, d1: inv1, d2: inv2, d3: inv3, score: score);
      }
    }
    if (i < 1)
    {
      for (Node element in addSpells) {
        if (element.d0 == 2 && element.d1 ==0 && element.d2 ==0 && element.d3 == 0)
        {
           print('CAST ${element.id}');
           break;
        }
      }
      i++;
    }
    else
    {
      for (Node od in addOrders)
      {
        if (inv.d0 + od.d0 >= 0 &&
        inv.d1 + od.d1 >= 0 &&
        inv.d2 + od.d2 >= 0 &&
        inv.d3 + od.d3 >= 0) {
      print('BREW ${od.id}');
      bl = false;
      break;
      }
      }
      if (bl)
      {
        for (Node element in addlearnetSpells)
        {
          if (element.d0 >= 0 && element.d1 >=0 && element.d2 >=0 && element.d3 >= 0 && element.taxindex <= inv.d0)
        {
           print('Learn ${element.id}');
           ll = false;
           break;
        }
        }
            if (i < 6 && ll)
            {
                  getFirstLSP(addlearnetSpells);
                  i++;
            }
              
    else if (ll) {

      DFS(Graph(addOrders, inv, addSpells),bestMove);
      if (bestMove.length != 0)
      {
        bestMove.forEach((element) {
          if (element.castable == 1)
              element.best += 5;    
          if (element.d0 >= 0)
                element.best += 1;
          if (element.d1 >= 0)
                element.best += 2;
          if (element.d2 >= 0)
                element.best += 3;
          if (element.d3 >= 0)
                element.best += 4;
        });
         bestMove.sort((a, b) => a.best.compareTo(b.best));
        if (bestMove.last.castable == 0)
          print('REST');
        else
        {
          int k = 1;
          while(bestMove.last.d0  + inv.d0 >= 0
          &&   bestMove.last.d1  + inv.d1 >= 0
          &&   bestMove.last.d2  + inv.d2 >= 0
          &&   bestMove.last.d3  + inv.d3 >= 0
          &&  bestMove.last.sum + inv.sum <= 10
          )
          k++;

            print('CAST ${sp.id} ${k}');
        }
      }
      else
        getFirstLSP(addlearnetSpells);
     
          
      
    }
      }
    }
      
    
    addOrders.clear();
    addSpells.clear();
    addlearnetSpells.clear();
    bestMove.clear();

    // Write an action using print()
    // To debug: stderr.writeln('Debug messages...');

    // in the first league: BREW <id> | WAIT; later: BREW <id> | CAST <id> [<times>] | LEARN <id> | REST | WAIT
  }
}

*/
