import 'package:flutter/material.dart';

/// A centered, max-width layout container with scrolling and safe area padding.
class CenteredBody extends StatelessWidget {
  final Widget child;

  const CenteredBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: child,
          ),
        ),
      ),
    );
  }
}
