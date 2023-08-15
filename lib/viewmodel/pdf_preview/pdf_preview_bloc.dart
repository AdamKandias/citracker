import 'package:citracker/models/project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/firestore_service.dart';

part 'pdf_preview_event.dart';
part 'pdf_preview_state.dart';

class PdfPreviewBloc extends Bloc<PdfPreviewEvent, PdfPreviewStateModelView> {
  PdfPreviewBloc() : super(PdfPreviewInitial()) {
    on<PdfPreviewLoadEvent>(_pdfPreviewLoadHandler);
  }

  _pdfPreviewLoadHandler(
      PdfPreviewLoadEvent event, Emitter<PdfPreviewStateModelView> emit) async {
    emit(PdfPreviewLoading());
    try {
      var documentSnapshoot =
          await FirestoreService().getOne('projects', event.documentId);
      emit(PdfPreviewLoadSuccess(
          project: Project.fromMap({
        'id': documentSnapshoot.id,
        'title': documentSnapshoot.data()!['title'],
        'description': documentSnapshoot.data()!['description'],
        'due_date': documentSnapshoot.data()!['due_date']
      })));
    } catch (e) {
      emit(PdfPreviewLoadFailed(message: e.toString()));
    }
  }
}
