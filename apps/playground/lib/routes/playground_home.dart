import 'package:flutter/widgets.dart';
import 'package:remix_fortal/remix_fortal.dart';
import '../registry/component_registry.dart';

class PlaygroundHome extends StatelessWidget {
  const PlaygroundHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: FortalHeading('Remix Playground'),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: availableComponents.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final key = availableComponents[index];
              return FortalButton(
                label: key,
                onPressed: () => Navigator.of(context).push(
                  PageRouteBuilder<void>(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  FortalButton(
                                    label: 'Back',
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(width: 16),
                                  FortalHeading(key),
                                ],
                              ),
                            ),
                            Expanded(child: Builder(builder: components[key]!)),
                          ],
                        ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
