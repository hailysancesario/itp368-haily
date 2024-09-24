// lightsout_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'lightsout_event.dart';
import 'lightsout_state.dart';
import 'dart:math';

class LightsoutBloc extends Bloc<LightsOutEvent, LightsOutState> {
  LightsoutBloc(int initialN) : super(LightsOutState(List.generate(initialN, (_) => Random().nextBool()))) {
    on<ToggleLight>((event, emit) {
      List<bool> newLights = List.from(state.lights);
      int index = event.index;

      newLights[index] = !newLights[index];
      if (index > 0) newLights[index - 1] = !newLights[index - 1];
      if (index < newLights.length - 1) newLights[index + 1] = !newLights[index + 1];

      emit(LightsOutState(newLights));
    });

    on<IncreaseLights>((event, emit) {
      List<bool> newLights = List.from(state.lights);
      newLights.add(Random().nextBool()); // Add a new random light state
      emit(LightsOutState(newLights));
    });

    on<DecreaseLights>((event, emit) {
      List<bool> newLights = List.from(state.lights);
      if (newLights.length > 1) {
        newLights.removeLast(); // Remove the last light
        emit(LightsOutState(newLights));
      }
    });
  }
}
