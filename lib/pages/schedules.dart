import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  final ScrollController? scrollController;

  const SchedulePage({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Schedule Page'));
  }
}
