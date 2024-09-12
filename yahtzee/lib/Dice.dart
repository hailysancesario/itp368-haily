import "package:flutter/material.dart";
import 'dart:math';

class Dice {
  // List of dice values (5 dice)
  List<int> diceValues = [1, 1, 1, 1, 1]; //let's start each dice at 1
  List<bool> diceHeld = [false, false, false, false, false]; //Default val is false, bc no hold yet is pressed

  //getters
  List<int> get diceValuesList {
    return diceValues;
  }

  List<bool> get diceHeldList {
    return diceHeld;
  }

  // Function to generate a random dice value between 1 and 6
  //have it return something and use that to set the state in the other file
  void rollDice() {
    Random random = Random();
    // setState(() {
      for (int i = 0; i < diceValues.length; i++) { //iterate through all dices (5)
        //let's check if it's held before we choose who to randomize
        if(diceHeld[i] == false) { //not held? ok we can randomize
          diceValues[i] = random.nextInt(6) + 1; //value between 1-6
        }
      }
    // });
  }

  // Function to generate the dice dots 
  List<Widget> generateDiceDots(int value) {

    //let's put all the dots into an array so we can manipulate their positions
    List<Widget> dots = List.generate(9, (index) {
      return Container(); 
    });

    // We can use switch for the 6 different cases (positions)
    switch (value) {
      case 1:
        dots[4] = dot(); // dot in the center
        break;
      case 2:
        dots[0] = dot(); // Top-left
        dots[8] = dot(); // Bottom-right
        break;
      case 3:
        dots[0] = dot(); // Top-left
        dots[4] = dot(); // Center dot
        dots[8] = dot(); // Bottom-right
        break;
      case 4:
        dots[0] = dot(); // Top-left
        dots[2] = dot(); // Top-right
        dots[6] = dot(); // Bottom-left
        dots[8] = dot(); // Bottom-right
        break;
      case 5:
        dots[0] = dot(); // Top-left
        dots[2] = dot(); // Top-right
        dots[4] = dot(); // Center dot
        dots[6] = dot(); // Bottom-left
        dots[8] = dot(); // Bottom-right
        break;
      case 6:
        dots[0] = dot(); // Top-left
        dots[2] = dot(); // Top-right
        dots[3] = dot(); // Middle-left
        dots[5] = dot(); // Middle-right
        dots[6] = dot(); // Bottom-left
        dots[8] = dot(); // Bottom-right
        break;
    }

    return dots; //let's return the right grid
  }

  // Function to make a smaller black dot with spacing
  Widget dot() {
    return Padding(
      padding: const EdgeInsets.all(3.0), // Add spacing between dots
      child: Container(
        height: 4,
        width: 4,  
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

}



