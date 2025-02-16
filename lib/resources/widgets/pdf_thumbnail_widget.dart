import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfThumbnail extends StatefulWidget {
  final String pdfUrl;
  const PdfThumbnail({super.key, required this.pdfUrl});

  static String state = "pdf_thumbnail";

  @override
  createState() => _PdfThumbnailState();
}

class _PdfThumbnailState extends NyState<PdfThumbnail> {
  PdfDocument? pdfDocument;
  bool isThatLoading = true;
  String? localPdfPath;
  String? currentPdfUrl;

  _PdfThumbnailState() {
    stateName = PdfThumbnail.state;
  }

  @override
  get init => () async {
    await downloadAndLoadPdf();
  };

  @override
  void dispose() {
    pdfDocument?.close();
    super.dispose();
  }

  @override
  stateUpdated(dynamic data) {}

  Future<void> downloadAndLoadPdf() async {
    if (currentPdfUrl == widget.pdfUrl && localPdfPath != null) {
      // Use cached PDF
      pdfDocument = await PdfDocument.openFile(localPdfPath!);
      setState(() => isThatLoading = false);
      return;
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/temp_pdf.pdf');

      // Download PDF if not already downloaded
      if (!await file.exists() || currentPdfUrl != widget.pdfUrl) {
        final response = await http.get(Uri.parse(widget.pdfUrl));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          currentPdfUrl = widget.pdfUrl;
        } else {
          setState(() => isThatLoading = false);
          return;
        }
      }

      localPdfPath = file.path;
      pdfDocument = await PdfDocument.openFile(localPdfPath!);
      setState(() => isThatLoading = false);
    } catch (e) {
      setState(() => isThatLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isThatLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (pdfDocument == null) {
      return const Center(child: Icon(Icons.error, color: Colors.red));
    }

    return FutureBuilder<PdfPageImage>(
      future: pdfDocument!.getPage(1).then((page) async {
        final image = await page.render(width: 200, height: 200);
        return image ?? (throw Exception("Failed to render PDF page"));
      }),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Icon(Icons.broken_image, color: Colors.red));
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              snapshot.data!.bytes,
              fit: BoxFit.fill,
              width: double.infinity,
              height: 300,
            ),
          );
        }
      },
    );
  }
}