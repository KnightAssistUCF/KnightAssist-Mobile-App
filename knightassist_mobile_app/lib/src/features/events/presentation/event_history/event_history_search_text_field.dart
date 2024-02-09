import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/event_history/event_history_search_state_provider.dart';

class EventHistorySearchTextField extends ConsumerStatefulWidget {
  const EventHistorySearchTextField({super.key});

  @override
  ConsumerState<EventHistorySearchTextField> createState() =>
      _EventHistorySearchTextFieldState();
}

class _EventHistorySearchTextFieldState
    extends ConsumerState<EventHistorySearchTextField> {
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
              hintText: 'Search Event History',
              icon: const Icon(Icons.search),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        ref
                            .read(eventHistorySearchQueryStateProvider.notifier)
                            .state = '';
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
            ),
            onChanged: (text) => ref
                .read(eventHistorySearchQueryStateProvider.notifier)
                .state = text,
          );
        });
  }
}
