import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_example/helpers/connectivity.dart';
import 'package:riverpod_example/screens/home/home.dart';
import 'package:riverpod_example/screens/noInternet/no_internet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  runApp(ProviderScope(child: MyApp(connectionStatus: connectionStatus)));
}

class MyApp extends StatelessWidget {
  final ConnectionStatusSingleton? connectionStatus;
  const MyApp({required this.connectionStatus, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) => StreamBuilder<bool>(
          stream: connectionStatus!.connectionChangeController.stream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? _Unfocus(
                    key: Key("${Random().nextDouble()}"),
                    child: snapshot.data!
                        ? HomeScreen(
                            key: Key("${Random().nextDouble()}"),
                          )
                        : NoInternetScreen(
                            key: Key("${Random().nextDouble()}"),
                          ))
                : NoInternetScreen(
                    key: Key("${Random().nextDouble()}"),
                  );
          }),
      // home: const HomeScreen(),
    );
  }
}

/// A widget that unfocus everything when tapped.
///
/// This implements the "Unfocus when tapping in empty space" behavior for the
/// entire application.
class _Unfocus extends HookConsumerWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
