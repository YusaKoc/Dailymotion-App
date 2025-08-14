import 'dart:async';
import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_input_styles.dart';
import 'package:flutter/material.dart';

class FavoritesSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Duration debounceDuration;

  const FavoritesSearchBar({
    super.key,
    required this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 350),
  });

  @override
  State<FavoritesSearchBar> createState() => _FavoritesSearchBarState();
}

class _FavoritesSearchBarState extends State<FavoritesSearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  void _onTextChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(widget.debounceDuration, () => widget.onChanged(value));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.defaultPadding,
      child: TextField(
        controller: _controller,
        decoration: AppInputStyles.inputDecoration(
          context,
          hint: 'Video Ara',
          icon: Icons.search,
        ),
        onChanged: _onTextChanged,
      ),
    );
  }
}
