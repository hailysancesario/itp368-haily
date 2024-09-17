//This class will hold the BLoC logic for the counter

import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> { //use the event and state we created

  CounterBloc() : super(CounterState(0)) { //the initial state of the value is 0
    //Listens for IncrementCounter button press
    //When event is triggered it increments the counter
    on<IncrementCounter>((event, emit) {
      emit(CounterState(state.counterValue + 1)); 
    });

  }
}