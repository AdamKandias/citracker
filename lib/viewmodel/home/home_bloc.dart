import 'package:bloc/bloc.dart';
import 'package:citracker/models/project.dart';
import 'package:citracker/services/firestore_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(ProjectInitial()) {
    on<ProjectLoad>(_loadProject);
  }

  void _loadProject(ProjectLoad event, Emitter<HomeState> emit) async {
    emit(ProjectLoadLoading());
    try {
      List<Project> projects = [];
      var querySnapshoot = await FirestoreService().getAll('projects');
      for (var element in querySnapshoot.docs) {
        Map<String, dynamic> project = {
          'id': element.id,
          'title': element.data()['title'],
          'description': element.data()['description'],
          'due_date': element.data()['due_date']
        };
        projects.add(Project.fromMap(project));
      }
      emit(ProjectLoadSuccess(projects: projects));
    } catch (e) {
      emit(ProjectLoadFailed(message: e.toString()));
    }
  }
}
