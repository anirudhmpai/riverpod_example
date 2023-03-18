import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/riverpod/state/counter.dart';

final counterStateProvider =
    StateProvider<CounterState>((ref) => CounterState(counterValue: 0));
