part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<Project> projects;

  const HomeState({this.projects = const []});
}

final class ProjectInitial extends HomeState {}

final class ProjectLoadLoading extends HomeState {}

final class ProjectLoadFailed extends HomeState {
  final String message;

  const ProjectLoadFailed({required this.message});
}

final class ProjectLoadSuccess extends HomeState {
  const ProjectLoadSuccess({required super.projects});
}
