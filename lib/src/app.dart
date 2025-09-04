import 'package:flutter/material.dart';
import 'package:flutter_redrocket_test_task/src/presentation/utils/di_provider.dart';

import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  const App({required this.getIt, super.key});

  final GetIt getIt;

  @override
  Widget build(BuildContext context) {
    return DiProvider(getIt: getIt, child: const MaterialApp());
  }
}
