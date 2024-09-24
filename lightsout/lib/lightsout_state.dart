import 'dart:math';

class LightsOutState {
  final List<bool> lights;

  LightsOutState(this.lights);

 /*Create a new LightsOutState object with a list of n random boolean values
  We are initializing the game state with a random configuration of lights being on or off.*/
  static LightsOutState createInitialState(int n) {
    final random = Random();
    return LightsOutState(List.generate(n, (_) => random.nextBool()));
  }
}