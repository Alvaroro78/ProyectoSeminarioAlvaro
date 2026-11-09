import 'package:flutter/material.dart';

/// Buttons where one option is selected; reports the chosen index.
class ChoiceButtons extends StatelessWidget {
  final List<String> labels;
  final int selected;
  final int perRow;
  final Function(int) onSelect;

  const ChoiceButtons({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelect,
    this.perRow = 3,
  });

  Widget _button(int index) {
    final child = Text(
      labels[index],
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    if (index == selected) {
      return FilledButton(
        onPressed: () => onSelect(index),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: child,
      );
    }
    return OutlinedButton(
      onPressed: () => onSelect(index),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var start = 0; start < labels.length; start += perRow) {
      final end =
          start + perRow < labels.length ? start + perRow : labels.length;
      rows.add(
        Row(
          spacing: 8,
          children: [
            for (var i = start; i < end; i++) Expanded(child: _button(i)),
          ],
        ),
      );
    }
    return Column(spacing: 8, children: rows);
  }
}
