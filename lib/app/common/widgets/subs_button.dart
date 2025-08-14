import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/subs_features/data/entities/subs_entity.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/cubit/subs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionButton extends StatefulWidget {
  final String channelId;
  final String screenName;
  final String avatarUrl;

  const SubscriptionButton({
    super.key,
    required this.channelId,
    required this.screenName,
    required this.avatarUrl,
  });

  @override
  State<SubscriptionButton> createState() => _SubscriptionButtonState();
}

class _SubscriptionButtonState extends State<SubscriptionButton> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionCubit>().check(widget.channelId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final cubit = context.read<SubscriptionCubit>();
        final isSubscribed = cubit.isSubscribed(widget.channelId);

        return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            foregroundColor: isSubscribed ? Colors.grey[800] : Colors.white,
            backgroundColor: isSubscribed ? Colors.grey[300] : Colors.redAccent,
            padding: AppPadding.iconButtonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: Icon(
            isSubscribed ? Icons.check_circle : Icons.notification_add_outlined,
            size: 20,
          ),
          label: Text(
            isSubscribed ? "Takiptesin" : "Abone Ol",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            cubit.toggle(
              SubscriptionEntity(
                channelId: widget.channelId,
                screenName: widget.screenName,
                avatarUrl: widget.avatarUrl,
              ),
            );
          },
        );
      },
    );
  }
}
