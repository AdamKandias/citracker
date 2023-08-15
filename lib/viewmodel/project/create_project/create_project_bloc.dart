import 'package:citracker/services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_project_event.dart';
import 'create_project_state.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  CreateProjectBloc() : super(CreateProjectInitial()) {
    on<TitleChangedEvent>(_titleChangeEvent);
    on<DescriptionChangedEvent>(_descriptionChangeEvent);
    on<DueDateChangedEvent>(_dueDateChangeEvent);
    on<CreateProjectActionEvent>(_createProjectHandler);
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

  _createProjectHandler(
      CreateProjectEvent event, Emitter<CreateProjectState> emit) async {
    final String title = state.title;
    final String description = state.description;
    final String dueDate = state.dueDate;
    emit(CreateProjectLoading(
        title: title, description: description, dueDate: dueDate));
    if (title.isEmpty) {
      emit(CreateProjectFailed(
          message: "Title field can't empty",
          title: title,
          description: description,
          dueDate: dueDate));
      return;
    }
    if (description.isEmpty) {
      emit(CreateProjectFailed(
          message: "Description field can't empty",
          title: title,
          description: description,
          dueDate: dueDate));
      return;
    }
    if (dueDate.isEmpty) {
      emit(CreateProjectFailed(
          message: "Due date field can't empty",
          title: title,
          description: description,
          dueDate: dueDate));
      return;
    }
    try {
      await FirestoreService().create('projects', {
        "title": title,
        "description": description,
        "due_date": dueDate,
      });
      emit(CreateProjectSuccess(message: "Successfully create new project"));
    } catch (e) {
      emit(CreateProjectFailed(
          message: "Error while create new project: ${e.toString()}",
          title: title,
          description: description,
          dueDate: dueDate));
    }
  }
}
