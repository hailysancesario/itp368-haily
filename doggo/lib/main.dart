import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(DogCeoApp());
}

class DogCeoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cute Dog App',
      theme: ThemeData(
        // primarySwatch: Colors.pink,
        fontFamily: 'Poppins', // Optional: Make the font more fun!
      ),
      home: DogImageScreen(),
    );
  }
}

class DogImageScreen extends StatefulWidget {
  @override
  _DogImageScreenState createState() => _DogImageScreenState();
}

class _DogImageScreenState extends State<DogImageScreen> {
  String? dogImageUrl;

  // Fetch a random dog image from the API
  Future<void> fetchDogImage() async {
    final url = Uri.parse('https://dog.ceo/api/breeds/image/random');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          dogImageUrl = data['message'];
        });
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDogImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50, // Soft background color
      appBar: AppBar(
        title: Text('🐾 Random Dog Picture Generator 🐾'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 239, 187, 205),
      ),
      body: Center(
        child: dogImageUrl == null
            ? CircularProgressIndicator(color: const Color.fromARGB(255, 251, 129, 170))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      dogImageUrl!,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: fetchDogImage,
                    // icon: Icon(Icons.pets, size: 30), // Cute pet icon
                    label: Text(
                      'Get Another Pupper!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 142, 179),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
