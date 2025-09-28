import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final ScrollController? scrollController;

  const SettingsPage({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Page'));
  }
}
