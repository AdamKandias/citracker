import 'package:citracker/pages/application/bloc/application_event.dart';
import 'package:citracker/pages/application/bloc/application_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationState(page: 0)) {
    on<ApplicationPageChangedEvent>((event, emit) {
      emit(ApplicationState(page: event.index));
    });
  }
}
