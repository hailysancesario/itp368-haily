//HW2 Converter

import "dart:math";

import "package:flutter/material.dart";

void main()
{ runApp(Converter());
}

// demo of a simple page
class Converter extends StatelessWidget
{
  Converter({super.key});

  @override
  Widget build(BuildContext context)
  { return MaterialApp
    ( title: "Converter Calculator",
      home: ConverterHome(),
    );
  }
}

class ConverterHome extends StatefulWidget
{
  @override
  State<ConverterHome> createState() => ConverterHomeState();
}

class ConverterHomeState extends State<ConverterHome> {
  String selectedConversion = 'temperature';
  bool isCelsius = false; // toggle boolean to switch between temperature units
  bool isKilograms = false; // toggle boolean to switch between weight units
  String inputValue = ""; // user key pad input
  String outputValue = ""; // result of conversion

    // Function to handle button press
  void handleKeypad(String value) {
    setState(() {

      // Handle 'clear' or 'backspace'
      if (value == "C") {
        inputValue = "";
        outputValue = "";
      } else if (value == "-" && inputValue.isEmpty) {
        // Only allow '-' at the start of the input
        inputValue += value;
      } else if (value == "." && !inputValue.contains(".")) {
        // Only allow one decimal point
        inputValue += value;
      } else if (RegExp(r'\d').hasMatch(value)) {
        // Add digits to the input
        inputValue += value;
      }
    });

    performConversion();
  }

  // Function to perform conversions based on selected units
  void performConversion() {
    if (inputValue.isEmpty || inputValue == "-") return;

    double inputNumber = double.tryParse(inputValue) ?? 0;

    //We have to use our booleans to determine which direction to convert/units to convert -> if else statements
    if (selectedConversion == 'temperature') {
      if (isCelsius) {
        outputValue = celsiusToFahrenheit(inputNumber).toStringAsFixed(2);
      } else {
        outputValue = fahrenheitToCelsius(inputNumber).toStringAsFixed(2);
      }
    } else if (selectedConversion == 'weight') {
      if (isKilograms) {
        outputValue = kilogramsToPounds(inputNumber).toStringAsFixed(2);
      } else {
        outputValue = poundsToKilograms(inputNumber).toStringAsFixed(2);
      }
    }
  }

   //Celsius to Fahrenheit
  double celsiusToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  //Fahrenheit to Celsius
  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  //Kilograms to Pounds
  double kilogramsToPounds(double kilograms) {
    return kilograms * 2.20462;
  }

  //Pounds to Kilograms
  double poundsToKilograms(double pounds) {
    return pounds / 2.20462;
  }


  @override
  Widget build(BuildContext context) {
    //Start of making buttons for temp weight , plus units in each category
    Row buttons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedConversion = 'temperature';
              inputValue = "";
        outputValue = "";
            });
          },
          child: Text(
            "Temperature",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedConversion == 'temperature' ? Colors.white : Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedConversion == 'temperature'
                ? const Color.fromARGB(188, 62, 11, 109)
                : Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: const Color.fromARGB(188, 62, 11, 109),
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedConversion = 'weight';
              inputValue = "";
              outputValue = "";
            });
          },
          child: Text(
            "Weight",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedConversion == 'weight' ? Colors.white : Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedConversion == 'weight'
                ? const Color.fromARGB(188, 62, 11, 109)
                : Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: const Color.fromARGB(188, 62, 11, 109),width: 2,),
            ),
          ),
        ),
      ],
    );

    // start of unit selection buttons, replicate the top row ^^
    Row unitSelectionButtons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: selectedConversion == 'temperature'
              ? () {
                  setState(() {
                    isCelsius = false; 
                    inputValue = "";
                    outputValue = "";
                  });
                }
              : () {
                  setState(() {
                    isKilograms = false;
                    inputValue = "";
                    outputValue = "";
                  });
                },
          child: Text(
            selectedConversion == 'temperature'? "Fahrenheit" : "Pounds",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedConversion == 'temperature' ? (isCelsius ? Colors.black : Colors.white) : (isKilograms ? Colors.black : Colors.white),),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedConversion == 'temperature'
                ? (isCelsius ? Colors.white : const Color.fromARGB(188, 62, 11, 109))
                : (isKilograms ? Colors.white : const Color.fromARGB(188, 62, 11, 109)),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), //use same styling as row above for consistency
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: const Color.fromARGB(188, 62, 11, 109),
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(width: 20), //add spacing bewtweeen

        //second button for celsius/kilos
        ElevatedButton(
          onPressed: selectedConversion == 'temperature'
              ? () {
                  setState(() {
                    isCelsius = true;
                    inputValue = "";
                    outputValue = "";
                  });
                }
              : () {
                  setState(() {
                    isKilograms = true;
                    inputValue = "";
                    outputValue = "";
                  });
                },
          child: Text(
            selectedConversion == 'temperature'
                ? "Celsius"
                : "Kilograms",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedConversion == 'temperature'? (isCelsius ? Colors.white : Colors.black) : (isKilograms ? Colors.white : Colors.black), ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedConversion == 'temperature'
                ? (isCelsius ? const Color.fromARGB(188, 62, 11, 109) : Colors.white)
                : (isKilograms ? const Color.fromARGB(188, 62, 11, 109) : Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: const Color.fromARGB(188, 62, 11, 109), width: 2,
              ),
            ),
          ),
        ),
      ],
    );

    // Define keypad row digits
    List<String> keypadButtons = [
      '7', '8', '9',
      '4', '5', '6',
      '1', '2', '3',
      '0', '.', '-',
    ];

    //make it a widget and we want to iterate every three making a row, so like 4 rows like in our list i + 3
    List<Widget> keypadRows = [];
    for (int i = 0; i < keypadButtons.length; i += 3) {
      List<String> rowButtons = keypadButtons.sublist(i, i + 3); 
      keypadRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowButtons.map((buttonValue) {
            return SizedBox(
              width: 70,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  handleKeypad(buttonValue);
                },
                child: Text(
                  buttonValue,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: const Color.fromARGB(188, 62, 11, 109), width: 2,),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    // copy code on top to create new row separate from keypad digits. this is so there aren't 4 buttons one row
    keypadRows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                handleKeypad("C"); // Clear button value
              },
              child: Text(
                "C", 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: const Color.fromARGB(188, 62, 11, 109), width: 2,),
                ),
              ),
            ),
          ),
        ],
      ),
    );

   return Scaffold(
      appBar: AppBar(
        title: Text('Converter App'),
      ),
      body: Column(
        children: [
          buttons,
          SizedBox(height: 20), //add spacing bewtweeen
          unitSelectionButtons,
          SizedBox(height: 20), //add spacing bewtweeen

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Input: $inputValue ${selectedConversion == 'temperature' ? (isCelsius ? '°C' : '°F') : (isKilograms ? 'kg' : 'lb')}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:const Color.fromARGB(188, 62, 11, 109),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(188, 62, 11, 109), // Purple background
                shape: BoxShape.circle, // Circular shape
              ),
              child: Center(
                child: Text("=", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Output: $outputValue ${selectedConversion == 'temperature' ? (isCelsius ? '°F' : '°C') : (isKilograms ? 'lb' : 'kg')}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:const Color.fromARGB(188, 62, 11, 109),),
            ),
          ),

          SizedBox(height: 20), //add spacing bewtweeen

          Expanded(
            child: Column(
              children: keypadRows,
            ),
          ),
        ],
      ),
    );
  }
}


