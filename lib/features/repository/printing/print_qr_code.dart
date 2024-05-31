import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> printDoc(Uint8List? imageBytes) async {
  final doc = pw.Document();

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return buildPrintableData(imageBytes);
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => doc.save(),
  );
}

pw.Widget buildPrintableData(Uint8List? imageBytes) {
  return pw.Center(
    child: imageBytes != null
        ? pw.Image(
            pw.MemoryImage(imageBytes),
          )
        : pw.Text('No image provided'),
  );
}

Future<Uint8List> getImageBytes(String imageUrl) async {
  log(imageUrl);
  log(imageUrl);
  final response = await http.get(Uri.parse(imageUrl));
  return response.bodyBytes;
  // final response = await http.get(Uri.parse(imageUrl));
  // final blob = html.Blob([response.bodyBytes]);
  // final reader = html.FileReader();
  // reader.readAsArrayBuffer(blob);
  // final bytes = await Future.wait([reader.onLoadEnd.first])
  //     .then((_) => reader.result as Uint8List);
  // return bytes;
}
