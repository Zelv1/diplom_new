import 'package:diplom_new/features/models/order_model/order_model.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePdf(OrderModel order) async {
  final pdf = pw.Document();
  final Map<String, String> productTypes = {
    '1': 'Скоропортящийся',
    '2': 'Насыпной',
    '3': 'Генеральный',
    '4': 'Негабаритный',
    '5': 'Газообразный',
    '6': 'Пылевидный',
    '7': 'Наливной',
    '8': 'Опасный',
  };

  final Map<String, String> paymentMethods = {
    '1': 'Терминал',
    '2': 'Наличные',
  };

  String productType = productTypes[order.goodType] ?? '';
  String paymentMethod = paymentMethods[order.payment] ?? '';

  final Uint8List fontBytes =
      (await rootBundle.load('assets/fonts/Roboto-Regular.ttf'))
          .buffer
          .asUint8List();
  final pw.Font robotoFont = pw.Font.ttf(fontBytes.buffer.asByteData());

  pdf.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Add a header
          pw.Container(
            width: double.infinity,
            height: 50,
            child: pw.Center(
              child: pw.Text(
                'Отчет о выполненной доставке',
                style: pw.TextStyle(
                  font: robotoFont,
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Номер заказа: ${order.id}',
              style: pw.TextStyle(font: robotoFont, fontSize: 18)),
          pw.SizedBox(height: 10),
          pw.Text('Заказчик: ${order.iDVendor?.nameOfOrganization}',
              style: pw.TextStyle(font: robotoFont, fontSize: 16)),
          pw.SizedBox(height: 10),
          pw.Text('Был доставлен: ${order.iDCourier?.name}',
              style: pw.TextStyle(font: robotoFont, fontSize: 16)),
          pw.SizedBox(height: 20),
          pw.Text('Тип товара: $productType',
              style: pw.TextStyle(font: robotoFont, fontSize: 16)),
          pw.SizedBox(height: 20),
          pw.Text('Способ оплаты: $paymentMethod',
              style: pw.TextStyle(font: robotoFont, fontSize: 16)),
          pw.SizedBox(height: 20),
          pw.Text('Связь с заказчиком : ${order.phoneNumber}',
              style: pw.TextStyle(font: robotoFont, fontSize: 16)),
          pw.SizedBox(height: 20),
          // Add a table
        ],
      );
    },
  ));

  return pdf.save();
}

Future<void> printOrder(OrderModel order) async {
  final bytes = await generatePdf(order);

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) => Future.value(bytes),
  );
}
