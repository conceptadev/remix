import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'controls_bar.dart';

class PreviewShell extends StatefulWidget {
  final Widget child;
  final Size initialSize;
  final Brightness initialBrightness;

  const PreviewShell({
    super.key,
    required this.child,
    this.initialSize = const Size(375, 812),
    this.initialBrightness = .light,
  });

  @override
  State<PreviewShell> createState() => _PreviewShellState();
}

class _PreviewShellState extends State<PreviewShell> {
  late Size _size = widget.initialSize;
  late Brightness _brightness = widget.initialBrightness;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ControlsBar(
          brightness: _brightness,
          size: _size,
          onChange: ({Brightness? brightness, Size? size}) {
            setState(() {
              if (brightness != null) _brightness = brightness;
              if (size != null) _size = size;
            });
          },
        ),
        Expanded(
          child: Center(
            child: _ViewportFrame(
              size: _size,
              brightness: _brightness,
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }
}

class _ViewportFrame extends StatelessWidget {
  final Size size;
  final Brightness brightness;
  final Widget child;

  const _ViewportFrame({
    required this.size,
    required this.brightness,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final frame = Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: brightness == .light ? MixColors.white : MixColors.black,
        border: Border.all(color: MixColors.greySwatch[300]!),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(blurRadius: 24, color: MixColors.black12)],
      ),
      clipBehavior: .antiAlias,
    );

    final media = MediaQuery(
      data: MediaQueryData(
        size: size,
        platformBrightness: brightness,
        devicePixelRatio: 1.0,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: brightness),
        home: Scaffold(
          backgroundColor: MixColors.transparent,
          body: Center(child: child),
        ),
      ),
    );

    // Note: FortalScope is applied by the component registry wrapper.
    return Stack(
      children: [
        frame,
        Positioned.fill(child: media),
      ],
    );
  }
}
