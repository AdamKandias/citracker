// ignore_for_file: public_member_api_docs, sort_constructors_first

class EditProjectState {
  final String id;
  final String title;
  final String description;
  final String dueDate;

  EditProjectState(
      {this.id = '',
      this.title = '',
      this.description = '',
      this.dueDate = ''});

  EditProjectState copyWith(
      {String? id, String? title, String? description, String? dueDate}) {
    return EditProjectState(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate);
  }
}

class EditProjectInitial extends EditProjectState {}

class EditProjectLoad extends EditProjectState {}

class EditProjectLoadLoading extends EditProjectState {}

class EditProjectLoadFailed extends EditProjectState {
  final String message;

  EditProjectLoadFailed({required this.message});
}

class EditProjectLoadSuccess extends EditProjectState {
  EditProjectLoadSuccess(
      {super.id, super.title, super.description, super.dueDate});
}

class EditProjectActionLoading extends EditProjectState {
  EditProjectActionLoading(
      {super.id, super.title, super.description, super.dueDate});
}

class EditProjectActionFailed extends EditProjectState {
  final String message;

  EditProjectActionFailed(
      {required this.message,
      super.id,
      super.title,
      super.description,
      super.dueDate});
}

class EditProjectActionSuccess extends EditProjectState {
  final String message;

  EditProjectActionSuccess({required this.message});
}
