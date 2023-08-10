class CreateProjectState {
  final String title;
  final String description;
  final String dueDate;

  CreateProjectState(
      {this.title = '', this.description = '', this.dueDate = ''});

  CreateProjectState copyWith(
      {String? title, String? description, String? dueDate}) {
    return CreateProjectState(
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate);
  }
}
