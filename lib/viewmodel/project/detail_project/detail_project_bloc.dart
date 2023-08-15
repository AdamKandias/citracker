import 'package:bloc/bloc.dart';
import 'package:citracker/services/firestore_service.dart';
import 'package:meta/meta.dart';

import '../../../models/project.dart';

part 'detail_project_event.dart';
part 'detail_project_state.dart';

class DetailProjectBloc extends Bloc<DetailProjectEvent, DetailProjectState> {
  DetailProjectBloc() : super(DetailProjectInitial()) {
    on<DetailProjectLoadEvent>(_loadOneProjectHandler);
    on<DetailProjectDeleteEvent>(_loadDeleteOneProjectHandler);
  }

  void _loadOneProjectHandler(
      DetailProjectLoadEvent event, Emitter<DetailProjectState> emit) async {
    emit(DetailProjectLoadLoading());
    try {
      var documentSnapshoot =
          await FirestoreService().getOne('projects', event.documentId);
      emit(DetailProjectLoadSuccess(
          project: Project.fromMap({
        'id': documentSnapshoot.id,
        'title': documentSnapshoot.data()!['title'],
        'description': documentSnapshoot.data()!['description'],
        'due_date': documentSnapshoot.data()!['due_date']
      })));
    } catch (e) {
      emit(DetailProjectLoadFailed(message: e.toString()));
    }
  }

  void _loadDeleteOneProjectHandler(
      DetailProjectDeleteEvent event, Emitter<DetailProjectState> emit) async {
    emit(DeleteProjectLoading());
    try {
      await FirestoreService().deleteOne('projects', event.documentId);
      emit(DeleteProjectSuccess(message: "Successfully deleted the project"));
    } catch (e) {
      emit(DeleteProjectFailed(message: e.toString()));
    }
  }
}
