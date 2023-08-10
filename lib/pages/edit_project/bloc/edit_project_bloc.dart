import 'package:citracker/pages/edit_project/bloc/edit_project_event.dart';
import 'package:citracker/pages/edit_project/bloc/edit_project_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProjectBloc extends Bloc<EditProjectEvent, EditProjectState> {
  EditProjectBloc() : super(EditProjectState()) {
    on<TitleChangedEvent>(_titleChangeEvent);
    on<DescriptionChangedEvent>(_descriptionChangeEvent);
    on<DueDateChangedEvent>(_dueDateChangeEvent);
  }
  _titleChangeEvent(TitleChangedEvent event, Emitter<EditProjectState> emit) {
    emit(state.copyWith(title: event.title));
  }

  _descriptionChangeEvent(
      DescriptionChangedEvent event, Emitter<EditProjectState> emit) {
    emit(state.copyWith(description: event.description));
  }

  _dueDateChangeEvent(
      DueDateChangedEvent event, Emitter<EditProjectState> emit) {
    emit(state.copyWith(dueDate: event.dueDate));
  }
}
