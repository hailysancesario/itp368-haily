import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(PancakeApp());
}

class PancakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pancake Sorting',
      home: PancakeHomePage(),
    );
  }
}

class PancakeHomePage extends StatefulWidget {
  @override
  _PancakeHomePageState createState() => _PancakeHomePageState();
}

class _PancakeHomePageState extends State<PancakeHomePage> {
  List<int> pancakes = [];
  int pancakeCount = 5; //initally lets start with 5 pancakes, change this with + and - later...

  @override
  void initState() {
    super.initState();
    _generatePancakes();
  }

  //Generates random stack of pancakes
  void _generatePancakes() {
    pancakes = List<int>.generate(pancakeCount, (i) => i + 1); //the list of integers represents the pancakes
    pancakes.shuffle(); //randomize the order of the pancakes
  }

  //Flipping the pancakes
  void _flipPancakes(int index) {
    setState(() { //use reverse function to reverse the list
      pancakes = pancakes.sublist(0, index + 1).reversed.toList() + pancakes.sublist(index + 1);
    });
  }

  //Checks if stack is sorted -> display message in scaffold later...
  bool _isSorted() {
    for (int i = 0; i < pancakes.length - 1; i++) { //it should be sequential -> so increasing order
      if (pancakes[i] > pancakes[i + 1]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _generatePancakes(); //user should be able to refresh and play with stack again
              });
            },
          ),
        ],
        title: Text('Pancake Sorting'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Flip (tap) the pancakes to sort and enjoy a yummy breakfast!', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int index = 0; index < pancakes.length; index++) 
                  GestureDetector(
                    onTap: () => _flipPancakes(index),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 190, 110, 54),
                      borderRadius: BorderRadius.circular(8),
                      ),
                      width: pancakes[index] * 40.0, // Pancake size based on the number
                      height: 30,
                    ),
                  ),
              ],
            ),
          ),
          //Display success message once the pancakes ARE sorted.
          if (_isSorted())
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '🥞 Yay all pancakes are sorted! Bon Appétit 🥞',
                style: TextStyle(color: Colors.green, fontSize: 24),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove), //figure out - icon line
                onPressed: () {
                  if (pancakeCount > 2) { //CHECK RANGE!!!
                    setState(() {
                      pancakeCount--;
                      _generatePancakes(); //call generate again to make new stack
                    });
                  }
                },
              ),
              Text('$pancakeCount Pancakes', style: TextStyle(fontSize: 18)),
              IconButton(
                icon: Icon(Icons.add), 
                onPressed: () {
                  if (pancakeCount < 20) { //CHECK RANGE!!!!
                    setState(() {
                      pancakeCount++;
                      _generatePancakes(); //we have to call generate again to make new stack
                    });
                  }
                },
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
