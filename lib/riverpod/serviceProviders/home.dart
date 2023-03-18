import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/riverpod/providers/state.dart';
import 'package:riverpod_example/riverpod/state/screen.dart';

class HomeService extends StateNotifier<ScreenState> {
  final Ref ref;
  HomeService(this.ref) : super(ScreenState(viewState: ViewState.idle));

  Future<void> incrementCounter() async {
    state = state.copyWith(viewState: ViewState.busy);
    await Future.delayed(const Duration(seconds: 1));
    var counterProvider = ref.read(counterStateProvider.notifier);
    int counterValue = (counterProvider.state.counterValue ?? 0) + 1;
    counterProvider.state =
        counterProvider.state.copyWith(counterValue: counterValue);
    debugPrint('Incremented Counter Value : $counterValue');
    state = state.copyWith(viewState: ViewState.idle);
  }

  Future<void> decrementCounter() async {
    state = state.copyWith(viewState: ViewState.busy);
    await Future.delayed(const Duration(seconds: 1));
    var counterProvider = ref.read(counterStateProvider.notifier);
    int counterValue = (counterProvider.state.counterValue ?? 0) - 1;
    counterProvider.state =
        counterProvider.state.copyWith(counterValue: counterValue);
    debugPrint('Decremented Counter Value : $counterValue');

    state = state.copyWith(viewState: ViewState.idle);
  }

  Future<void> resetCounter() async {
    state = state.copyWith(viewState: ViewState.busy);
    await Future.delayed(const Duration(seconds: 1));
    var counterProvider = ref.read(counterStateProvider.notifier);
    var counterValue = counterProvider.state.counterValue;
    if (counterValue != 0) {
      counterProvider.state = counterProvider.state.copyWith(counterValue: 0);
      counterValue = counterProvider.state.counterValue;
      debugPrint('Reset Counter Value : $counterValue');
    } else {
      debugPrint('Counter already reset');
    }
    state = state.copyWith(viewState: ViewState.idle);
  }
}
