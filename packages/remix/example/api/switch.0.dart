import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: SwitchExample()),
    ),
  );
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  final ValueNotifier<bool> _selected = ValueNotifier(false);

  @override
  void dispose() {
    _selected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RemixSwitch(
        semanticLabel: 'Toggle',
        style: style,
        selected: _selected.value,
        onChanged: (value) {
          setState(() {
            _selected.value = value;
          });
        },
      ),
    );
  }

  SwitchStyler get style {
    return SwitchStyler()
        .thumbColor(Colors.grey.shade600)
        .trackColor(Colors.deepPurpleAccent.shade200)
        .size(65, 30)
        .borderRadius(.all(const Radius.circular(40)))
        .alignment(_selected.value ? .centerRight : .centerLeft)
        .animate(AnimationConfig.easeOut(300.ms))
        .thumb(
          BoxStyler()
              .color(Colors.white)
              .size(40, 30)
              .borderRadius(.circular(40))
              .scale(0.85)
              .decoration(
                .boxShadow([
                  BoxShadowMix(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(2, 4),
                    blurRadius: 4,
                    spreadRadius: 3,
                  ),
                ]),
              )
              .keyframeAnimation(
                trigger: _selected,
                timeline: [
                  KeyframeTrack<double>('scale', [
                    Keyframe.easeOutSine(1.25, 200.ms),
                    Keyframe.elasticOut(0.85, 500.ms),
                  ], initial: 0.85),
                  KeyframeTrack<double>(
                    'width',
                    [
                      Keyframe.decelerate(50, 100.ms),
                      Keyframe.linear(50, 100.ms),
                      Keyframe.elasticOut(40, 500.ms),
                    ],
                    initial: 40,
                    tweenBuilder: Tween.new,
                  ),
                ],
                styleBuilder: (values, style) =>
                    style.scale(values.get('scale')).width(values.get('width')),
              ),
        );
  }
}
