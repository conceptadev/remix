// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_modal.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Carbon modal recipe generated over [RemixDialog].
class CarbonModal extends StatelessWidget {
  const CarbonModal({
    super.key,
    this.size = .medium,
    this.child,
    this.title,
    this.description,
    this.actions,
    this.scrollable = false,
    this.modal = true,
    this.semanticLabel,
  });

  final CarbonModalSize size;

  final Widget? child;

  final String? title;

  final String? description;

  final List<Widget>? actions;

  final bool scrollable;

  final bool modal;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return _CarbonModalBase(
      key: this.key,
      style: carbonModalStyle(size: this.size),
      child: this.child,
      title: this.title,
      description: this.description,
      actions: this.actions,
      scrollable: this.scrollable,
      modal: this.modal,
      semanticLabel: this.semanticLabel,
    );
  }
}
