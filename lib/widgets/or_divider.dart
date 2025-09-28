import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('OR', style: TextStyle(color: Colors.grey)),
        ),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}