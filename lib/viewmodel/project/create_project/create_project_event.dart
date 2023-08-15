abstract class CreateProjectEvent {}

class TitleChangedEvent extends CreateProjectEvent {
  final String title;
  TitleChangedEvent({required this.title});
}

class DescriptionChangedEvent extends CreateProjectEvent {
  final String description;
  DescriptionChangedEvent({required this.description});
}

class DueDateChangedEvent extends CreateProjectEvent {
  final String dueDate;
  DueDateChangedEvent({required this.dueDate});
}

class CreateProjectActionEvent extends CreateProjectEvent {}
