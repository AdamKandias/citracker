import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (format) => makePdf({
          'title': args['title'] ?? '',
          'description': args['description'] ?? '',
          'dueDate': args['dueDate'] ?? '',
        }),
      ),
    );
  }

  Future<Uint8List> makePdf(Map<String, dynamic> data) async {
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
                      text: "Analyst Of Project ${data['title']}", level: 1),
                  pw.Image(pw.MemoryImage(byteList),
                      fit: pw.BoxFit.fitHeight, height: 100, width: 100),
                ],
              ),
              pw.Text("Project Description: ${data['description']}"),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              pw.Paragraph(
                  text:
                      "Deadline/Due Date: ${data['dueDate']}"), // Added null check
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
