abstract class ApplicationEvent {}

class ApplicationPageChangedEvent extends ApplicationEvent {
  final int index;

  ApplicationPageChangedEvent({required this.index});
}
