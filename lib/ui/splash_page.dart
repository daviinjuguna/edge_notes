import 'package:auto_route/auto_route.dart';
import 'package:edge_notes/routes/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            'Edge Notes',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
          ),
          Text("A minimal Note Taking App"),
          Spacer(),
          ElevatedButton.icon(
            onPressed: () => context.navigateTo(NotesRoute()),
            label: Icon(Icons.arrow_right_alt_outlined),
            icon: Text("Continue"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
