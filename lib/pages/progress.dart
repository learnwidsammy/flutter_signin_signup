import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  final ScrollController? scrollController;

  const ProgressPage({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Progress Page'));
  }
}
