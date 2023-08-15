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
      dueDate: dueDate ?? this.dueDate,
    );
  }
}

class CreateProjectInitial extends CreateProjectState {}

class CreateProjectLoading extends CreateProjectState {
  CreateProjectLoading({super.title, super.description, super.dueDate});
}

class CreateProjectFailed extends CreateProjectState {
  final String message;
  CreateProjectFailed(
      {required this.message, super.title, super.description, super.dueDate});
}

class CreateProjectSuccess extends CreateProjectState {
  final String message;
  CreateProjectSuccess({required this.message});
}
