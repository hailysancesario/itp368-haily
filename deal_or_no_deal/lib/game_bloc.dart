// lib/blocs/game_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';
import 'suitcase.dart';
import 'dart:math';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(GameState(
          suitcases: _generateSuitcases(),
        )) {
    on<PickHoldSuitcase>(_onPickHoldSuitcase);
    on<RevealSuitcase>(_onRevealSuitcase);
    on<DealOffer>(_onDealOffer);
    on<NoDeal>(_onNoDeal);
  }

  static List<Suitcase> _generateSuitcases() {
    final values = [1, 5, 10, 100, 1000, 5000, 10000, 100000, 500000, 1000000];
    values.shuffle(Random()); //randomize suitcase values
    return List.generate(
      10,
      (index) => Suitcase(id: index + 1, value: values[index]),
    );
  }

  void _onPickHoldSuitcase(PickHoldSuitcase event, Emitter<GameState> emit) {
    emit(GameState(
      suitcases: state.suitcases,
      holdSuitcaseId: event.suitcaseId,
    ));
  }

  void _onRevealSuitcase(RevealSuitcase event, Emitter<GameState> emit) {
  final updatedSuitcases = state.suitcases.map((s) {
    if (s.id == event.suitcaseId) {
      return Suitcase(id: s.id, value: s.value, isRevealed: true);
    }
    return s;
  }).toList();
  
  //calc the offer again whenever a suitcase is revealed
  final newOffer = state.calculateOffer();
  
  emit(GameState(
    suitcases: updatedSuitcases,
    holdSuitcaseId: state.holdSuitcaseId,
    offer: newOffer, // Update the offer here
  ));
}

 void _onDealOffer(DealOffer event, Emitter<GameState> emit) {
  }

  void _onNoDeal(NoDeal event, Emitter<GameState> emit) {
    emit(GameState(
      suitcases: state.suitcases,
      holdSuitcaseId: state.holdSuitcaseId,
    ));
  }
}