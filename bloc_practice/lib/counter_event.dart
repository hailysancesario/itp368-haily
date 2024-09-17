//In BLoC, events represent user actions that trigger changes
//In this app, pressing the increment button is an event

abstract class CounterEvent {}

//This defines a simple event called IncrementCounter which will trigger the  incrementing counter
class IncrementCounter extends CounterEvent {}