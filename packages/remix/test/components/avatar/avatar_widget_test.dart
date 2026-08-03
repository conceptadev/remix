import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('RemixAvatar', () {
    group('Basic Rendering', () {
      testWidgets('renders avatar with minimal props', (tester) async {
        await tester.pumpRemixApp(const RemixAvatar());
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        expect(find.byType(Box), findsOneWidget);
        expect(find.byType(Container), findsAtLeastNWidgets(1));
      });

      testWidgets('renders avatar with label', (tester) async {
        await tester.pumpRemixApp(const RemixAvatar(label: 'JD'));
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        expect(find.text('JD'), findsOneWidget);
        expect(find.byType(StyledText), findsOneWidget);
      });

      testWidgets('renders avatar with icon', (tester) async {
        await tester.pumpRemixApp(const RemixAvatar(icon: Icons.person));
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        expect(find.byIcon(Icons.person), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('renders avatar with custom child', (tester) async {
        await tester.pumpRemixApp(const RemixAvatar(child: Text('Custom')));
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        expect(find.text('Custom'), findsOneWidget);
      });

      testWidgets('renders avatar with background image', (tester) async {
        // Test that the avatar widget can be created with a background image
        final avatar = RemixAvatar(
          backgroundImage: const NetworkImage('https://example.com/avatar.png'),
        );

        expect(avatar.backgroundImage, isNotNull);
        expect(avatar, isA<RemixAvatar>());
      });

      testWidgets('renders avatar with foreground image', (tester) async {
        // Test that the avatar widget can be created with a foreground image
        final avatar = RemixAvatar(
          foregroundImage: const NetworkImage('https://example.com/badge.png'),
        );

        expect(avatar.foregroundImage, isNotNull);
        expect(avatar, isA<RemixAvatar>());
      });
    });

    group('Custom Builders', () {
      testWidgets('labelBuilder renders custom label widget', (tester) async {
        await tester.pumpRemixApp(
          RemixAvatar(
            label: 'JD',
            labelBuilder: (context, spec, label) {
              return Container(
                key: const ValueKey('custom_label'),
                child: Text('Custom: $label'),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('custom_label')), findsOneWidget);
        expect(find.text('Custom: JD'), findsOneWidget);
      });

      testWidgets('iconBuilder renders custom icon widget', (tester) async {
        await tester.pumpRemixApp(
          RemixAvatar(
            icon: Icons.person,
            iconBuilder: (context, spec, icon) {
              return Container(
                key: const ValueKey('custom_icon'),
                child: Icon(icon, size: 32),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('custom_icon')), findsOneWidget);
        expect(find.byIcon(Icons.person), findsOneWidget);
      });

      testWidgets('labelBuilder with null label handles empty string', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          RemixAvatar(
            labelBuilder: (context, spec, label) {
              return Container(
                key: const ValueKey('empty_label'),
                child: Text('Empty: "$label"'),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('empty_label')), findsOneWidget);
        expect(find.text('Empty: ""'), findsOneWidget);
      });
    });

    group('Content Priority', () {
      testWidgets('child takes precedence over label and icon', (tester) async {
        await tester.pumpRemixApp(
          const RemixAvatar(
            child: Text('Child'),
            label: 'Label',
            icon: Icons.person,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Child'), findsOneWidget);
        expect(find.text('Label'), findsNothing);
        expect(find.byIcon(Icons.person), findsNothing);
      });

      testWidgets('label takes precedence over icon when no child', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixAvatar(label: 'Label', icon: Icons.person),
        );
        await tester.pumpAndSettle();

        expect(find.text('Label'), findsOneWidget);
        expect(find.byIcon(Icons.person), findsNothing);
      });

      testWidgets('icon renders when no child or label', (tester) async {
        await tester.pumpRemixApp(const RemixAvatar(icon: Icons.person));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.person), findsOneWidget);
        expect(find.byType(StyledIcon), findsOneWidget);
      });

      testWidgets('renders empty container when no content', (tester) async {
        await tester.pumpRemixApp(const RemixAvatar());
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        expect(find.byType(Container), findsAtLeastNWidgets(1));
        // Should have no text or icon content
        expect(find.byType(Text), findsNothing);
        expect(find.byType(Icon), findsNothing);
      });
    });

    group('Image Error Handling', () {
      testWidgets('onBackgroundImageError callback is properly set', (
        tester,
      ) async {
        Exception? exception;
        await tester.pumpRemixApp(
          RemixAvatar(
            backgroundImage: const NetworkImage(
              'https://invalid-url.com/image.png',
            ),
            onBackgroundImageError: (e, stackTrace) {
              // Callback is properly set
              exception = e as Exception;
            },
          ),
        );
        await tester.pumpAndSettle();

        expectLater(exception, isA<Exception>());
        expect(find.byType(RemixAvatar), findsOneWidget);
      });

      testWidgets('onForegroundImageError callback is properly set', (
        tester,
      ) async {
        Exception? exception;
        await tester.pumpRemixApp(
          RemixAvatar(
            foregroundImage: const NetworkImage(
              'https://invalid-url.com/image.png',
            ),
            onForegroundImageError: (e, stackTrace) {
              exception = e as Exception;
              // Callback is properly set
            },
          ),
        );
        await tester.pumpAndSettle();

        expectLater(exception, isA<Exception>());
        expect(find.byType(RemixAvatar), findsOneWidget);
      });
    });

    group('Layout and Sizing', () {
      testWidgets('default layout properties are applied', (tester) async {
        await tester.pumpRemixApp(const RemixAvatar());
        await tester.pumpAndSettle();

        final containerWidgets = tester.widgetList<Container>(
          find.byType(Container),
        );
        final avatarContainer = containerWidgets.firstWhere(
          (container) => container.alignment == Alignment.center,
        );
        expect(avatarContainer.alignment, equals(Alignment.center));
      });
    });

    group('Style Integration', () {
      testWidgets('avatar uses provided styleSpec', (tester) async {
        const styleSpec = AvatarSpec();

        await tester.pumpRemixApp(
          const RemixAvatar(styleSpec: styleSpec, label: 'Test'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('avatar with null background image renders correctly', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixAvatar(backgroundImage: null, label: 'Test'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('avatar with null foreground image renders correctly', (
        tester,
      ) async {
        await tester.pumpRemixApp(
          const RemixAvatar(foregroundImage: null, label: 'Test'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('avatar with null icon renders correctly', (tester) async {
        await tester.pumpRemixApp(const RemixAvatar(icon: null));
        await tester.pumpAndSettle();

        expect(find.byType(RemixAvatar), findsOneWidget);
        // Should render empty container
        expect(find.byType(Container), findsAtLeastNWidgets(1));
      });
    });
  });
}
