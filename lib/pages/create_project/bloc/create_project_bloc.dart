import 'package:citracker/pages/create_project/bloc/create_project_event.dart';
import 'package:citracker/pages/create_project/bloc/create_project_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  CreateProjectBloc() : super(CreateProjectState()) {
    on<TitleChangedEvent>(_titleChangeEvent);
    on<DescriptionChangedEvent>(_descriptionChangeEvent);
    on<DueDateChangedEvent>(_dueDateChangeEvent);
  }
  _titleChangeEvent(TitleChangedEvent event, Emitter<CreateProjectState> emit) {
    emit(state.copyWith(title: event.title));
  }

  _descriptionChangeEvent(
      DescriptionChangedEvent event, Emitter<CreateProjectState> emit) {
    emit(state.copyWith(description: event.description));
  }

  _dueDateChangeEvent(
      DueDateChangedEvent event, Emitter<CreateProjectState> emit) {
    emit(state.copyWith(dueDate: event.dueDate));
  }
}
