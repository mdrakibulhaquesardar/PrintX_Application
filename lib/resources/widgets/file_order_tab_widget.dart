import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/safearea_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:pdfx/pdfx.dart';

import '../../bootstrap/helpers.dart';
import '../pages/order_details_page.dart';
import 'buttons/buttons.dart';

class FileOrderTab extends StatefulWidget {
  const FileOrderTab({super.key});

  @override
  createState() => _FileOrderTabState();
}

class _FileOrderTabState extends NyState<FileOrderTab> {
  File? selectedFile;
  String? pdfPath;
  String? pdfName;
  int totalPages = 0;

  Future<void> countPdfPages(String path) async {
    final document = await PdfDocument.openFile(path);
    setState(() {
      pdfPath = path;
      totalPages = document.pagesCount;
      pdfName = path.split('/').last;
    });
  }

  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: SafeAreaWidget(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40),
                      if (selectedFile != null) ...[
                        Text("You have selected the following file").bodyMedium(),
                        Text(selectedFile!.path.split('/').last).bodyMedium(
                          color: ThemeColor.get(context).primaryAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        Text("File Size: ${(selectedFile!.lengthSync() / 1024).toStringAsFixed(2)} KB").bodyMedium(),
                        Text("Total Pages: $totalPages").bodyMedium(),
                      ],
                      if (selectedFile == null) ...[
                        Center(
                          child: Image.network(
                            "https://cdni.iconscout.com/illustration/premium/thumb/upload-file-to-cloud-illustration-download-in-svg-png-gif-formats--uploading-storage-data-internet-web-and-mobile-application-pack-business-illustrations-3722766.png",
                            height: constraints.maxWidth * 0.4,
                          ),
                        ),
                      ],
                      if (selectedFile == null) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Place Your Custom File").titleLarge(),
                            Text("Upload your file and place your order").bodyMedium(),
                          ],
                        ),
                      ],
                      GestureDetector(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          if (result != null && result.files.single.path != null) {
                            setState(() {
                              selectedFile = File(result.files.single.path!);
                              countPdfPages(result.files.single.path!);
                            });
                          }
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          dashPattern: [6, 3],
                          color: selectedFile != null ? Colors.green : Colors.grey,
                          strokeWidth: 2,
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload_file, size: 40, color: selectedFile != null ? Colors.green : Colors.grey),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Drag and Drop your or").bodyMedium().paddingOnly(left: 10, right: 5),
                                      Text("Browse").bodyMedium(
                                        color: ThemeColor.get(context).primaryAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Text(" to upload your file").bodyMedium().paddingOnly(left: 5),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ).paddingOnly(top: 20, bottom: 20),
                      ),
                      SizedBox(height: 20),
                      Text("You can upload your file in pdf format only after uploading your file system will generate the price based on the number of pages and color").bodyMedium(),
                      SizedBox(height: 20),
                      Text("Note: You can upload Single File at a Single Order ").bodyMedium(color: Colors.red),
                      Text("If you want to upload multiple files please create multiple orders or Contact Us").bodyMedium(),
                      SizedBox(height: 20),
                      Button.primary(
                        text: "Next",
                        color: selectedFile != null ? ThemeColor.get(context).primaryAccent : Colors.grey,
                        onPressed: selectedFile != null
                            ? () {
                                routeTo(OrderDetailsPage.path, data: {
                                  "file": selectedFile,
                                  "fileName": pdfName,
                                  "totalPages": totalPages,
                                  "pdfPath": pdfPath,
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}