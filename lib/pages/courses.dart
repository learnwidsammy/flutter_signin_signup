import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  final ScrollController? scrollController;

  const CoursesPage({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    if (scrollController != null) {
      return ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.only(top: 8, bottom: 120),
        itemCount: 50,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Course ${index + 1}'),
              subtitle: const Text('Scroll up and down to see the bar hide/show.'),
            ),
          );
        },
      );
    } else {
      return const Center(child: Text('Courses Page'));
    }
  }
}
