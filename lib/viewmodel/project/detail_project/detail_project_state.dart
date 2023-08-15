// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_project_bloc.dart';

sealed class DetailProjectState {}

class DetailProjectInitial extends DetailProjectState {}

class DetailProjectLoad extends DetailProjectState {}

class DetailProjectLoadLoading extends DetailProjectState {}

class DetailProjectLoadFailed extends DetailProjectState {
  final String message;

  DetailProjectLoadFailed({required this.message});
}

class DetailProjectLoadSuccess extends DetailProjectState {
  final Project project;

  DetailProjectLoadSuccess({required this.project});
}

class DeleteProjectLoading extends DetailProjectState {}

class DeleteProjectFailed extends DetailProjectState {
  final String message;

  DeleteProjectFailed({required this.message});
}

class DeleteProjectSuccess extends DetailProjectState {
  final String message;

  DeleteProjectSuccess({required this.message});
}
