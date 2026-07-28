import 'package:flutter/material.dart';

import 'data.dart';
import 'theme.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(item.tag.toUpperCase(),
              style: text.labelSmall?.copyWith(color: seed, letterSpacing: 1)),
          const SizedBox(height: 8),
          Text(item.title, style: text.headlineSmall),
          const SizedBox(height: 12),
          Text(item.body, style: text.bodyLarge?.copyWith(color: Colors.white70, height: 1.5)),
        ],
      ),
    );
  }
}
