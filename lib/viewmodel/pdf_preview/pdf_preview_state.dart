// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pdf_preview_bloc.dart';

sealed class PdfPreviewStateModelView {}

class PdfPreviewInitial extends PdfPreviewStateModelView {}

class PdfPreviewLoading extends PdfPreviewStateModelView {}

class PdfPreviewLoadFailed extends PdfPreviewStateModelView {
  final String message;

  PdfPreviewLoadFailed({required this.message});
}

class PdfPreviewLoadSuccess extends PdfPreviewStateModelView {
  final Project project;

  PdfPreviewLoadSuccess({required this.project});
}
