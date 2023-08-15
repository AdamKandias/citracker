import 'package:citracker/services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_project_event.dart';
import 'edit_project_state.dart';

class EditProjectBloc extends Bloc<EditProjectEvent, EditProjectState> {
  EditProjectBloc() : super(EditProjectInitial()) {
    on<TitleChangedEvent>(_titleChangeEvent);
    on<DescriptionChangedEvent>(_descriptionChangeEvent);
    on<DueDateChangedEvent>(_dueDateChangeEvent);
    on<EditProjectLoadEvent>(_editProjectLoadHandler);
    on<EditProjectActionEvent>(_editProjectActionHandler);
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

  _editProjectLoadHandler(
      EditProjectLoadEvent event, Emitter<EditProjectState> emit) async {
    emit(EditProjectLoadLoading());
    try {
      var documentSnapshoot =
          await FirestoreService().getOne('projects', event.documentId);
      emit(EditProjectLoadSuccess(
          id: documentSnapshoot.id,
          title: documentSnapshoot.data()!['title'],
          description: documentSnapshoot.data()!['description'],
          dueDate: documentSnapshoot.data()!['due_date']));
    } catch (e) {
      emit(EditProjectLoadFailed(message: e.toString()));
    }
  }

  _editProjectActionHandler(
      EditProjectActionEvent event, Emitter<EditProjectState> emit) async {
    final String id = state.id;
    final String title = state.title;
    final String description = state.description;
    final String dueDate = state.dueDate;
    emit(EditProjectActionLoading(
        id: id, title: title, description: description, dueDate: dueDate));
    if (title.isEmpty) {
      emit(EditProjectActionFailed(
          message: "Title field can't empty",
          id: id,
          title: title,
          description: description,
          dueDate: dueDate));
      return;
    }
    if (description.isEmpty) {
      emit(EditProjectActionFailed(
          message: "Description field can't empty",
          id: id,
          title: title,
          description: description,
          dueDate: dueDate));
      return;
    }
    if (dueDate.isEmpty) {
      emit(EditProjectActionFailed(
          message: "Due date field can't empty",
          id: id,
          title: title,
          description: description,
          dueDate: dueDate));
      return;
    }
    try {
      await FirestoreService().update('projects', id, {
        "title": title,
        "description": description,
        "due_date": dueDate,
      });
      emit(EditProjectActionSuccess(message: "Successfully edit the project"));
    } catch (e) {
      emit(EditProjectActionFailed(
          message: e.toString(),
          id: id,
          title: title,
          description: description,
          dueDate: dueDate));
    }
  }
}
