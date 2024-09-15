// Haily San Cesario
//Yahtzee Lab Project

import "package:flutter/material.dart";
import 'package:yahtzee/Dice.dart';


void main() // 23
{
  runApp(Yahtzee());
}

class Yahtzee extends StatelessWidget
{
  Yahtzee({super.key});

  @override
  Widget build( BuildContext context )
  { return MaterialApp
    ( title: "Yahtzee",
      home: YahtzeeHome(),
    );
  }
}

class YahtzeeHome extends StatefulWidget
{
  @override
  State<YahtzeeHome> createState() => YahtzeeHomeState();
}

class YahtzeeHomeState extends State<YahtzeeHome>
{
  Dice dice = Dice(); //instantiate outside you don't want to rebuild each time
  int sum = 0;
  
  void calculateSum() {
    sum = 0; // Reset sum
    for (int diceVal in dice.diceValuesList) { //in keyword not :
      sum += diceVal;
    }
  }
    
  @override
  Widget build( BuildContext context )
  { 
    calculateSum();
    return Scaffold(
      appBar: AppBar(title: const Text("Yahtzee")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                    height: 100,
                    width: 100,
                    child: GridView.count(
                      crossAxisCount: 3, // 3x3 grid for dice dots
                      children: dice.generateDiceDots(dice.diceValuesList[index]),
                    ),
                  ),

                  SizedBox(height: 10), // spacing b/w the dice and the hold button

                  //Hold Button Functionality
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        dice.diceHeldList[index] = !dice.diceHeldList[index];
                      });
                    },
                    backgroundColor: dice.diceHeldList[index]
                      ? Colors.red // it's true? set it to red
                      : Color.fromARGB(255, 253, 201, 213), // otherwise leave it at pink
                    child: Text(
                      "hold",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(188, 62, 11, 109),
                      ),
                    ),
                  ),

                ],
                
              );
              
              
            }),
          ),
          SizedBox(height: 50),
          //Roll button
          ElevatedButton(
            onPressed: () {
              setState(() {
                dice.rollDice(); // Call rollDice and then setState
                calculateSum();
              });
            },
            child: Text(
              "Roll",
              style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18,),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
          ),
          //Let's add a total counter
          SizedBox(height: 40),
          Text(
            "Total: $sum", // use our sum value. is it worth changing calculate sum to return a val?
            style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

