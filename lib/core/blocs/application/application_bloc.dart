import 'package:flutter_bloc/flutter_bloc.dart';

import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationState(page: 0)) {
    on<ApplicationPageChangedEvent>((event, emit) {
      emit(ApplicationState(page: event.index));
    });
  }
}
