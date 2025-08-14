import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/routing/route_observer.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/cubit/subs_cubit.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/widgets/subs_list_item.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/widgets/subs_search_bar.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionCubit>().watchAll();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<SubscriptionCubit>().watchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: AppTextStyles.heading1Bold(context),
        ),
      ),
      body: Column(
        children: [
          SubsSearchBar(
            onSearch: (value) {
              context.read<SubscriptionCubit>().updateSearch(value);
            },
          ),
          Expanded(
            child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
              builder: (context, state) {
                if (state is SubscriptionLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SubscriptionListLoaded) {
                  if (state.subs.isEmpty) {
                    return Center(
                      child: Text(
                        "Henüz abone olduğunuz kanal yok.",
                        style: AppTextStyles.body(context),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.subs.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    itemBuilder: (context, index) {
                      return SubscriptionListItem(channel: state.subs[index]);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
