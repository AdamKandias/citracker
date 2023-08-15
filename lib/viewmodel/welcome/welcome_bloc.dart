import 'package:bloc/bloc.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState()) {
    on<PageChangedEvent>((event, emit) {
      emit(WelcomeState(page: event.page));
    });
  }
}
