import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../widgets/page_header.dart';
import '../widgets/theme_panel.dart';
import '../widgets/toast.dart';
import '../widgets/typography.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _nameController = TextEditingController(text: 'Leo Farias');
  final _emailController = TextEditingController(text: 'leo@remix.dev');
  String _language = 'English (US)';
  bool _productUpdates = true;
  bool _weeklyDigest = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Align(
        alignment: .topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: 20,
            children: [
              const PageHeader(
                title: 'Settings',
                description: 'Manage your profile, preferences, and workspace.',
              ),
              FortalCard(
                size: .size3,
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: 16,
                  children: [
                    const CardHeading(
                      title: 'Profile',
                      description:
                          'Your personal details and communication preferences.',
                    ),
                    Row(
                      crossAxisAlignment: .start,
                      spacing: 14,
                      children: [
                        Expanded(
                          child: FortalTextField(
                            controller: _nameController,
                            label: 'Name',
                            hintText: 'Your name',
                          ),
                        ),
                        Expanded(
                          child: FortalTextField(
                            controller: _emailController,
                            label: 'Email',
                            helperText: 'Domain verification is pending.',
                            error: true,
                            keyboardType: .emailAddress,
                          ),
                        ),
                      ],
                    ),
                    FortalSelect<String>(
                      trigger: const RemixSelectTrigger(
                        placeholder: 'Language',
                      ),
                      selectedValue: _language,
                      items: const [
                        RemixSelectItem(
                          value: 'English (US)',
                          label: 'English (US)',
                        ),
                        RemixSelectItem(
                          value: 'English (UK)',
                          label: 'English (UK)',
                        ),
                        RemixSelectItem(value: 'Spanish', label: 'Spanish'),
                        RemixSelectItem(
                          value: 'Portuguese',
                          label: 'Portuguese',
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => _language = value);
                      },
                    ),
                    _PreferenceRow(
                      title: 'Product updates',
                      description: 'News about features and improvements.',
                      trailing: FortalSwitch(
                        selected: _productUpdates,
                        semanticLabel: 'Receive product updates',
                        onChanged: (value) =>
                            setState(() => _productUpdates = value),
                      ),
                    ),
                    _PreferenceRow(
                      title: 'Weekly digest',
                      description:
                          'A summary of workspace activity each Monday.',
                      trailing: FortalCheckbox(
                        selected: _weeklyDigest,
                        semanticLabel: 'Receive weekly digest',
                        onChanged: (value) =>
                            setState(() => _weeklyDigest = value ?? false),
                      ),
                    ),
                    Align(
                      alignment: .centerLeft,
                      child: FortalButton(
                        key: const ValueKey('save-profile'),
                        onPressed: () => showToast(
                          context,
                          message: 'Profile settings saved',
                        ),
                        label: 'Save changes',
                      ),
                    ),
                  ],
                ),
              ),
              FortalCard(
                size: .size3,
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: 16,
                  children: const [
                    CardHeading(
                      title: 'Appearance',
                      description:
                          'Tune every Fortal theme parameter in real time.',
                    ),
                    FortalCallout(
                      icon: Icons.auto_awesome_outlined,
                      text: 'Changes apply live across the entire dashboard.',
                    ),
                    ThemePanel(),
                  ],
                ),
              ),
              FortalCard(
                size: .size3,
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: 16,
                  children: [
                    const CardHeading(
                      title: 'Danger zone',
                      description:
                          'Destructive workspace actions cannot be undone.',
                    ),
                    Align(
                      alignment: .centerLeft,
                      child: FortalScope(
                        accent: .red,
                        hasBackground: false,
                        child: FortalButton.outline(
                          onPressed: _confirmDelete,
                          label: 'Delete workspace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showRemixDialog<bool>(
      context: context,
      barrierLabel: 'Dismiss',
      builder: (context) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: FortalDialog(
            title: 'Delete workspace?',
            description:
                'This demo keeps your data safe, but a real action would be permanent.',
            actions: [
              FortalButton.soft(
                onPressed: () => Navigator.of(context).pop(false),
                label: 'Cancel',
              ),
              FortalScope(
                accent: .red,
                hasBackground: false,
                child: FortalButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  label: 'Delete',
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (!mounted || confirmed != true) return;
    showToast(
      context,
      message: 'Demo workspace was not deleted',
      icon: Icons.info_outline,
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({
    required this.title,
    required this.description,
    required this.trailing,
  });

  final String title;
  final String description;
  final Widget trailing;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: .start,
          spacing: 2,
          children: [
            FortalText(title, size: .size2, weight: .medium),
            StyledText(description, style: dashboardText(.size1, tone: .muted)),
          ],
        ),
      ),
      trailing,
    ],
  );
}
