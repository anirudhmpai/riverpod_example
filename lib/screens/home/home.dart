import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_example/riverpod/providers/state.dart';
import 'package:riverpod_example/riverpod/serviceProviders/home.dart';
import 'package:riverpod_example/riverpod/state/screen.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});
  final homeService = StateNotifierProvider.autoDispose<HomeService, dynamic>(
      (ref) => HomeService(ref));
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterStateProvider);
    final screenState = ref.watch(homeService).viewState;
    debugPrint(screenState.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Example'),
        centerTitle: true,
      ),
      body: Visibility(
        visible: screenState == ViewState.busy,
        replacement: Center(
          child: Text(counterState.counterValue.toString()),
        ),
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ref.read(homeService.notifier).incrementCounter(),
            child: const Icon(Icons.plus_one),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => ref.read(homeService.notifier).decrementCounter(),
            child: const Icon(Icons.exposure_minus_1),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => ref.read(homeService.notifier).resetCounter(),
            child: const Icon(Icons.restore),
          ),
        ],
      ),
    );
  }
}
