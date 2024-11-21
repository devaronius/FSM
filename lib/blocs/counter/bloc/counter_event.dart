part of 'counter_bloc.dart';

sealed class CounterEvent {
  const CounterEvent();
}

class CounterCommand extends CounterEvent {
  final int type;

  CounterCommand._(this.type);

  factory CounterCommand.positive() {
    return CounterCommand._(1);
  }

  factory CounterCommand.negative() {
    return CounterCommand._(0);
  }
}

class CounterModeSwitch extends CounterEvent {
  CounterModeSwitch();
}

final class _CounterSwitchPlus extends CounterEvent {
  _CounterSwitchPlus();
}

final class _CounterSwitchMuli extends CounterEvent {
  _CounterSwitchMuli();
}

final class _CounterPositiveCommand extends CounterEvent {
  const _CounterPositiveCommand();
}

final class _CounterNegativeCommand extends CounterEvent {
  const _CounterNegativeCommand();
}
