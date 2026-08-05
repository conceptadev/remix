import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

Widget buildMenuExample() => const _MenuExample();

class _MenuExample extends StatefulWidget {
  const _MenuExample();

  @override
  State<_MenuExample> createState() => _MenuExampleState();
}

class _MenuExampleState extends State<_MenuExample> {
  bool _showStatus = true;
  String _density = 'comfortable';
  String _lastSelection = 'None';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text('Compound menu', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Open the menu and use the arrow keys to see focus and nested navigation.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          FortalMenu<String>.soft(
            trigger: const RemixMenuTrigger(
              label: 'View options',
              icon: Icons.tune,
            ),
            onSelected: (value) {
              setState(() => _lastSelection = value);
            },
            items: [
              const RemixMenuItem(
                value: 'rename',
                label: 'Rename',
                leadingIcon: Icons.edit_outlined,
                trailingIcon: Icons.keyboard_command_key,
              ),
              const RemixMenuItem(
                value: 'locked',
                label: 'Locked action',
                leadingIcon: Icons.lock_outline,
                enabled: false,
              ),
              const RemixMenuDivider(),
              RemixMenuCheckboxItem(
                value: 'show-status',
                label: 'Show status',
                checked: _showStatus,
                closeOnActivate: false,
                onChanged: (next) => setState(() => _showStatus = next),
              ),
              RemixMenuRadioGroup(
                value: _density,
                onChanged: (next) => setState(() => _density = next),
                items: const [
                  RemixMenuRadioItem(
                    value: 'compact',
                    label: 'Compact',
                    closeOnActivate: false,
                  ),
                  RemixMenuRadioItem(
                    value: 'comfortable',
                    label: 'Comfortable',
                    closeOnActivate: false,
                  ),
                ],
              ),
              const RemixMenuDivider(),
              const RemixMenuSubmenu(
                label: 'Share',
                leadingIcon: Icons.ios_share_outlined,
                items: [
                  RemixMenuItem(value: 'copy-link', label: 'Copy link'),
                  RemixMenuSubmenu(
                    label: 'Send with',
                    items: [
                      RemixMenuItem(value: 'email', label: 'Email'),
                      RemixMenuItem(value: 'messages', label: 'Messages'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Last selection: $_lastSelection'),
          Text('Status: ${_showStatus ? 'shown' : 'hidden'}'),
          Text('Density: $_density'),
        ],
      ),
    );
  }
}
