// lib/screens/game_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';
import 'dart:math';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deal or No Deal Game'),
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          //remaining suitcases and their $$$
          final remainingSuitcases = state.suitcases.where((s) => !s.isRevealed).toList();
          
          //shuffle the order for the display
          remainingSuitcases.shuffle(Random());

          return Column(
            children: [
  
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //center the row
                  children: [
                    Text('Remaining Cases: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    //create the list of remaining suitcases
                    ...remainingSuitcases.map((suitcase) => 
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0), // Space between each case
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 225, 88, 134), width: 2), // Pink border
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                          ),
                          padding: EdgeInsets.all(8.0), // Padding inside the container
                          child: Text(
                            '\$${suitcase.value}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ).toList(),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0,),
                  itemCount: state.suitcases.length,
                  itemBuilder: (context, index) {
                    final suitcase = state.suitcases[index];
                    return GestureDetector(
                      onTap: suitcase.isRevealed
                        ? null
                        : () {
                            context.read<GameBloc>().add(RevealSuitcase(suitcase.id));

                            // Trigger the deal offer after revealing 3 suitcases
                            if (state.suitcases.where((s) => s.isRevealed).length >= 2) {
                              context.read<GameBloc>().add(DealOffer());
                            }
                          },
                      child: Container(
                        color: suitcase.isRevealed 
                          ? const Color.fromARGB(239, 188, 187, 187) 
                          : const Color.fromARGB(223, 255, 135, 223),
                        child: Center(
                          child: Text(
                            suitcase.isRevealed
                                ? '\$${suitcase.value}'
                                : 'Case ${suitcase.id}',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (state.offer != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100.0), //padding to move it up
                  child: Column(
                    children: [
                      Text(
                        'Dealer is Offering: \$${state.offer!.toStringAsFixed(2)}', //make only 2 decimal spaces
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              //show that deal is accepted using a snack bar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Deal Accepted!')), //appears at the bottom
                              );
                            },
                            child: Text('DEAL', style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<GameBloc>().add(NoDeal());
                            },
                            child: Text('NO DEAL', style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
