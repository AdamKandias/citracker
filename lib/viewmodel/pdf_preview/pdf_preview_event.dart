// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pdf_preview_bloc.dart';

sealed class PdfPreviewEvent {}

class PdfPreviewLoadEvent extends PdfPreviewEvent {
  final String documentId;

  PdfPreviewLoadEvent({required this.documentId});
}
