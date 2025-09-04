import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DiProvider extends InheritedWidget {
  const DiProvider({required this.getIt, required super.child, super.key});

  final GetIt getIt;

  static DiProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<DiProvider>();

    return result ?? (throw Exception('No DiProvider found in context'));
  }

  @override
  bool updateShouldNotify(DiProvider oldWidget) => getIt != oldWidget.getIt;
}

extension GetItExtension on BuildContext {
  GetIt get getIt => DiProvider.of(this).getIt;
}
