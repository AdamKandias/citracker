part of 'detail_project_bloc.dart';

sealed class DetailProjectEvent {}

class DetailProjectLoadEvent extends DetailProjectEvent {
  final String documentId;

  DetailProjectLoadEvent({required this.documentId});
}

class DetailProjectDeleteEvent extends DetailProjectEvent {
  final String documentId;

  DetailProjectDeleteEvent({required this.documentId});
}
