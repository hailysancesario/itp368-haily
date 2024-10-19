// lib/blocs/game_event.dart
abstract class GameEvent {}

class PickHoldSuitcase extends GameEvent {
  final int suitcaseId;
  PickHoldSuitcase(this.suitcaseId);
}

class RevealSuitcase extends GameEvent {
  final int suitcaseId;
  RevealSuitcase(this.suitcaseId);
}

class DealOffer extends GameEvent {}

class NoDeal extends GameEvent {}
