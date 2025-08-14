import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/search_cubit.dart';

class SearchBarField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClearPressed;

  const SearchBarField({
    super.key,
    required this.onChanged,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, String>(
      builder: (context, query) {
        final controller = TextEditingController(text: query);
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );

        return Padding(
          padding: AppPadding.defaultPadding,
          child: TextField(
            controller: controller,
            onChanged: (value) {
              context.read<SearchCubit>().updateQuery(value);
              onChanged(value);
            },
            decoration: InputDecoration(
              hintText: "Aramak istediğiniz kelimeyi yazın...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        context.read<SearchCubit>().clearQuery();
                        onClearPressed();
                      },
                    )
                  : null,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      },
    );
  }
}
