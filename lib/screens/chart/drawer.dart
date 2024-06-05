import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoriesDrawer extends ConsumerWidget {
  const CategoriesDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.orange),
            child: Text(
              'chart',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text('Rating'),
            onTap: () {
              context.go('/starChart');
              Navigator.pop(context, true);
            },
          ),
          ListTile(
            title: Text('sample'),
            onTap: () {
              context.go('/sampleChart');
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }
}
