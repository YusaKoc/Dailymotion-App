import 'package:flutter_bloc/flutter_bloc.dart';
import 'navbar_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(currentIndex: 0));

  void changeTab(int index) {
    emit(NavigationState(currentIndex: index));
  }
}
