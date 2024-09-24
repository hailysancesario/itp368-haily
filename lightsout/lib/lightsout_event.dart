// lightsout_event.dart

abstract class LightsOutEvent {}

class ToggleLight extends LightsOutEvent {
  final int index;

  ToggleLight(this.index);
}

class IncreaseLights extends LightsOutEvent {}

class DecreaseLights extends LightsOutEvent {}
