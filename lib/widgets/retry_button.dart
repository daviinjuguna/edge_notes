import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({super.key, required this.retry});
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: retry,
      icon: Icon(Icons.refresh),
      label: Text("Retry"),
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Theme.of(context).colorScheme.onError,
      ),
    );
  }
}
