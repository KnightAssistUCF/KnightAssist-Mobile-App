import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/announcements/presentation/announcements_list/announcements_search_state_provider.dart';

class AnnouncementsSearchTextField extends ConsumerStatefulWidget {
  const AnnouncementsSearchTextField({super.key});

  @override
  ConsumerState<AnnouncementsSearchTextField> createState() =>
      _AnnouncementsSearchTextFieldState();
}

class _AnnouncementsSearchTextFieldState
    extends ConsumerState<AnnouncementsSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller,
        builder: (context, value, _) {
          return TextField(
            controller: _controller,
            autofocus: false,
            style: Theme.of(context).textTheme.titleLarge,
            decoration: InputDecoration(
              hintText: 'Search Announcements',
              icon: const Icon(Icons.search),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        ref
                            .read(
                                announcementsSearchQueryStateProvider.notifier)
                            .state = '';
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
            ),
            onChanged: (text) => ref
                .read(announcementsSearchQueryStateProvider.notifier)
                .state = text,
          );
        });
  }
}
