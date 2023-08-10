class EditProjectState {
  final String title;
  final String description;
  final String dueDate;

  EditProjectState({this.title = '', this.description = '', this.dueDate = ''});

  EditProjectState copyWith(
      {String? title, String? description, String? dueDate}) {
    return EditProjectState(
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate);
  }
}
