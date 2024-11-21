part of '../counter_bloc.dart';

final class CounterMuliplyDivide extends CounterState with CounterMachineState {
  @override
  CounterBloc machine;

  CounterMuliplyDivide(super.data, this.machine);

  @override
  void enterState({required CounterState from, CounterEvent? event}) {
    data.modeId = 2;
  }

  @override
  void exitState() {}

  @override
  void onNegativeCommand() {
    final count = data.counter;
    data.counter = (count / 2).round();
  }

  @override
  void onPositiveCommand() {
    final count = data.counter;
    data.counter = (count * 2).round();
  }

  @override
  void switchMode() {
    machine.add(_CounterSwitchPlus());
  }
}
