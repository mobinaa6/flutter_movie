// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class ShowErrorWidget extends StatelessWidget {
  final String _exception;
  const ShowErrorWidget({
    super.key,
    required String exception,
  }) : _exception = exception;

  @override
  Widget build(BuildContext context) {
    final TextTheme _themeData = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Center(
        child: Text(_exception, style: _themeData.headlineMedium),
      ),
    );
  }
}
