abstract interface class MachineState<T, E> {
  void enterState({required T from, E? event});
  void exitState();
}
