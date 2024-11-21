part of '../counter_bloc.dart';

final class CounterPLusMinus extends CounterState with CounterMachineState {
  @override
  CounterBloc machine;

  CounterPLusMinus(super.data, this.machine);

  @override
  void onNegativeCommand() {
    data.counter--;
    machine.add(const _CounterNegativeCommand());
  }

  @override
  void onPositiveCommand() {
    data.counter++;
    machine.add(const _CounterPositiveCommand());
  }

  @override
  void enterState({required CounterState from, CounterEvent? event}) {
    data.modeId = 1;
  }

  @override
  void exitState() {}

  @override
  void switchMode() {
    machine.add(_CounterSwitchMuli());
  }
}
