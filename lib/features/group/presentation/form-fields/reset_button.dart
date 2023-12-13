import 'package:flutter/material.dart';

import 'field_padding.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key, required this.onReset});

  final void Function() onReset;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FieldPadding(
        child: FilledButton(
          style: Theme.of(context).filledButtonTheme.style,
          onPressed: onReset,
          child: Text('Reset'),
      ),
    ),
  );
  }
}
