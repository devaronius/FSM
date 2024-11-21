import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsm/blocs/counter/bloc/counter_bloc.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(onPressed: () {
          context.read<CounterBloc>().add(CounterCommand.negative());
        }),
        Expanded(
          child: BlocSelector<CounterBloc, CounterState, int>(
              selector: (state) => state.data.counter,
              builder: (context, value) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
        ),
        MaterialButton(onPressed: () {
          context.read<CounterBloc>().add(CounterCommand.positive());
        }),
      ],
    );
  }
}
