import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tags extends ConsumerWidget {
  String tag;
  Tags({required this.tag});
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        backgroundColor: (Theme.of(context).primaryColor),
        label: Text(
          tag,
          style: const TextStyle(color: (Colors.white)),
        ),
      ),
    );
  }
}
