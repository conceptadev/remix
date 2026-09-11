import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Loading content', type: RemixSkeleton)
Widget buildSkeletonUseCase(BuildContext context) => const SkeletonExample();

class SkeletonExample extends StatefulWidget {
  const SkeletonExample({super.key});

  @override
  State<SkeletonExample> createState() => _SkeletonExampleState();
}

class _SkeletonExampleState extends State<SkeletonExample> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          FortalSkeleton(
            loading: _loading,
            child: const Text('Your workspace is ready'),
          ),
          FortalButton.outline(
            label: _loading ? 'Show content' : 'Show skeleton',
            onPressed: () => setState(() => _loading = !_loading),
          ),
        ],
      ),
    ),
  );
}
