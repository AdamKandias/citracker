import 'package:bloc/bloc.dart';
import 'package:citracker/pages/welcome/bloc/welcome_event.dart';
import 'package:citracker/pages/welcome/bloc/welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState()) {
    on<PageChangedEvent>((event, emit) {
      emit(WelcomeState(page: event.page));
    });
  }
}
