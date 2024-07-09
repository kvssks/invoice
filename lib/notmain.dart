import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InstallationReportForm(),
    );
  }
}

class InstallationReportForm extends StatefulWidget {
  @override
  _InstallationReportFormState createState() => _InstallationReportFormState();
}

class _InstallationReportFormState extends State<InstallationReportForm> {
  final _formKey = GlobalKey<FormState>();
  String ccrNumber = '';
  String dateTime = '';
  String customerName = '';
  String distributorName = '';
  String contactNumber = '';
  // Add other fields as required

  void _generateReport() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                padding: pw.EdgeInsets.all(8),
                child: pw.Text(
                  'FIELD SERVICE REPORT',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('CCR No.: $ccrNumber'),
                          pw.Text('Date & Time: $dateTime'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                padding: pw.EdgeInsets.all(8),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Customer Name & Address: $customerName'),
                    pw.Text('Distributor / Retailer Name & Location: $distributorName'),
                    pw.Text('Customer Contact No: $contactNumber'),
                  ],
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('UPS Details:'),
                          pw.Text('Model:'),
                          pw.Text('Rating:'),
                          pw.Text('Serial No:'),
                          pw.Text('Mfg.Date:'),
                          pw.Text('Date of Sale:'),
                          pw.Text('Warranty Status:'),
                        ],
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Battery Details:'),
                          pw.Text('Model:'),
                          pw.Text('Rating:'),
                          pw.Text('Serial No:'),
                          pw.Text('Mfg.Date:'),
                          pw.Text('Date of Sale:'),
                          pw.Text('Warranty Status:'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                padding: pw.EdgeInsets.all(8),
                child: pw.Text('Remarks:'),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                padding: pw.EdgeInsets.all(8),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Technician Name:'),
                    pw.Text('Signature:'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/installation_report.pdf");
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report generated: ${file.path}')),
    );

    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Installation Report Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'CCR No'),
                  onChanged: (value) {
                    ccrNumber = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Date & Time'),
                  onChanged: (value) {
                    dateTime = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Customer Name & Address'),
                  onChanged: (value) {
                    customerName = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Distributor / Retailer Name & Location'),
                  onChanged: (value) {
                    distributorName = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Customer Contact No'),
                  onChanged: (value) {
                    contactNumber = value;
                  },
                ),
                ElevatedButton(
                  onPressed: _generateReport,
                  child: Text('Generate Report'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
