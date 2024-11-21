part of '../counter_bloc.dart';

final class CounterData {
  int modeId;
  int counter;

  CounterData()
      : counter = 0,
        modeId = 0;
}

mixin CounterMachineState implements MachineState<CounterState, CounterEvent> {
  CounterBloc get machine;
  set machine(CounterBloc value);

  void setMachine(CounterBloc bloc) {
    machine = bloc;
  }

  void switchMode();

  void onPositiveCommand();

  void onNegativeCommand();

  @override
  void enterState({required CounterState from, CounterEvent? event});

  @override
  void exitState();
}

sealed class CounterState {
  const CounterState(this.data);

  final CounterData data;
}

final class CounterOff extends CounterState with CounterMachineState {
  @override
  late CounterBloc machine;

  CounterOff(super.data);

  @override
  void enterState({required CounterState from, CounterEvent? event}) {
    data.counter = 0;
    data.modeId = 0;
    switchMode();
  }

  @override
  void exitState() {}

  @override
  void onNegativeCommand() {}

  @override
  void onPositiveCommand() {}

  @override
  void switchMode() {
    machine.add(_CounterSwitchPlus());
  }
}
