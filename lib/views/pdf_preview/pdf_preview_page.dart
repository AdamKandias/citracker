import 'package:citracker/core/widgets/dialog/loading_dialog.dart';
import 'package:citracker/core/widgets/dialog/reusable_dialog.dart';
import 'package:citracker/viewmodel/pdf_preview/pdf_preview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../models/project.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: BlocConsumer<PdfPreviewBloc, PdfPreviewStateModelView>(
        listener: (context, state) {
          if (state is PdfPreviewLoading) {
            loadingDialog(context: context);
          }
          if (state is PdfPreviewLoadFailed) {
            Navigator.pop(context);
            reusableDialog(
              context: context,
              msg: state.message,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'application', (route) => false);
              },
            );
          }
        },
        builder: (context, state) {
          if (state is PdfPreviewLoadSuccess) {
            return PdfPreview(build: (format) => makePdf(state.project));
          }
          return Container();
        },
      ),
    );
  }

  Future<Uint8List> makePdf(Project project) async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/icons/headpic.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Header(
                      text: "Analyst Of Project ${project.title}", level: 1),
                  pw.Image(pw.MemoryImage(byteList),
                      fit: pw.BoxFit.fitHeight, height: 100, width: 100),
                ],
              ),
              pw.Text("Project Description: ${project.description}"),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Paragraph(
                  text:
                      "Deadline/Due Date: ${project.dueDate}"), // Added null check
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
