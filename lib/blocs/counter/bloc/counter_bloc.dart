import 'package:bloc/bloc.dart';

import '../../machine_state.dart';

part 'counter_event.dart';
part 'state/counter_plus_minus.dart';
part 'state/counter_multi_divide.dart';
part 'state/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterData data;

  late final CounterOff off;
  late final CounterMuliplyDivide muliply;
  late final CounterPLusMinus plusMinus;

  late final Map<CounterState, Map<String, CounterState>> _transitions;
  CounterBloc({required CounterData tempData})
      : data = tempData,
        super(CounterOff(tempData)) {
    off = CounterOff(tempData)..setMachine(this);
    muliply = CounterMuliplyDivide(data, this);
    plusMinus = CounterPLusMinus(data, this);

    _transitions = {
      off: {
        '_CounterSwitchPlus': plusMinus,
        '_CounterSwitchMuli': muliply,
      },
      muliply: {
        '_CounterNegativeCommand': plusMinus,
        '_CounterPositiveCommand': plusMinus,
        '_CounterSwitchPlus': plusMinus,
        '_CounterSwitchMuli': muliply,
      },
      plusMinus: {
        '_CounterNegativeCommand': plusMinus,
        '_CounterPositiveCommand': plusMinus,
        '_CounterSwitchPlus': plusMinus,
        '_CounterSwitchMuli': muliply,
      },
    };

    on<CounterCommand>((event, emit) {
      final sm = state as CounterMachineState;
      switch (event.type) {
        case 0:
          sm.onNegativeCommand();
          break;
        case 1:
          sm.onPositiveCommand();
          break;
      }
    });
    on<CounterModeSwitch>((event, emit) {
      final sm = state as CounterMachineState;
      sm.switchMode();
    });

    on<CounterEvent>((event, emit) {
      final transition = _transitions[state]?[(event).toString()];
      if (transition != null) {
        emit(transition);
      } else {
        addError(Exception());
      }
    });
  }

  void init() {
    final mState = state as MachineState;
    mState.enterState(from: mState);
  }

  @override
  void onTransition(Transition<CounterEvent, CounterState> transition) {
    final from = transition.currentState as MachineState;
    final to = transition.nextState as MachineState;
    final event = transition.event;

    from.exitState();
    to.enterState(from: from, event: event);

    super.onTransition(transition);
  }
}
