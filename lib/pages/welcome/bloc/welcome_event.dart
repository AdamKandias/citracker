abstract class WelcomeEvent {}

class PageChangedEvent extends WelcomeEvent {
  final int page;

  PageChangedEvent({required this.page});
}
