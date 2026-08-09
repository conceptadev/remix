import 'package:flutter/material.dart';
import '../registry/component_registry.dart';

class PlaygroundHome extends StatelessWidget {
  const PlaygroundHome({super.key});

  @override
  Widget build(BuildContext context) {
    final items = availableComponents;
    return Scaffold(
      appBar: AppBar(title: const Text('Remix Playground')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final key = items[index];
          return ListTile(
            title: Text(key),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    final builder = components[key]!;
                    return Scaffold(
                      appBar: AppBar(title: Text(key)),
                      body: Builder(builder: builder),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
