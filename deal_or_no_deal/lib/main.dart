// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_bloc.dart';
import 'game_screen.dart';

void main() {
  runApp(DealOrNoDealApp());
}

class DealOrNoDealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => GameBloc(),
        child: GameScreen(),
      ),
    );
  }
}