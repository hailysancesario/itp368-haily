import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'lightsout_bloc.dart';
import 'lightsout_event.dart';
import 'lightsout_state.dart';
import 'main.dart';

void main() {
  runApp(LightsOut());
}

class LightsOut extends StatelessWidget {
  const LightsOut({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lights Out',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
        create: (context) => LightsoutBloc(5), // default N = 5
        child: MyHomePage(title: 'Lights Out Game'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LightsoutBloc, LightsOutState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(state.lights.length, (index) {
                        return IconButton(
                          icon: Icon(
                            state.lights[index]
                                ? Icons.lightbulb
                                : Icons.lightbulb_outline,
                            color: state.lights[index] ? Colors.yellow : Colors.grey,
                          ),
                          onPressed: () {
                            context.read<LightsoutBloc>().add(ToggleLight(index));
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    // Add Row for + and - buttons to inc and dec num of lights
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Creat the buttons here...
                        ElevatedButton(
                          onPressed: () {
                            if (state.lights.length > 1) { //check num of lights
                              context.read<LightsoutBloc>().add(DecreaseLights());
                            }
                          },
                          child: const Text('-'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.read<LightsoutBloc>().add(IncreaseLights());
                          },
                          child: const Text('+'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
