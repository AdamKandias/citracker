abstract class EditProjectEvent {}

class TitleChangedEvent extends EditProjectEvent {
  final String title;
  TitleChangedEvent({required this.title});
}

class DescriptionChangedEvent extends EditProjectEvent {
  final String description;
  DescriptionChangedEvent({required this.description});
}

class DueDateChangedEvent extends EditProjectEvent {
  final String dueDate;
  DueDateChangedEvent({required this.dueDate});
}

class EditProjectLoadEvent extends EditProjectEvent {
  final String documentId;
  EditProjectLoadEvent({required this.documentId});
}

class EditProjectActionEvent extends EditProjectEvent {}
