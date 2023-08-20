import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.initial());

  void setSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
