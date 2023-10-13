import 'package:knightassist_mobile_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const EmptyPlaceholderWidget(message: '404 - Page not found'),
    );
  }
}
