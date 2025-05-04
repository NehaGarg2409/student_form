import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:student_form/screen/registration_provider.dart';

class DocumentsInfo extends StatefulWidget {
  const DocumentsInfo({super.key});

  @override
  State<DocumentsInfo> createState() => _DocumentsInfoState();
}

class _DocumentsInfoState extends State<DocumentsInfo> {
  PlatformFile? _medicalFile;
  PlatformFile? _transferFile;

  Future<void> _pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'svg'],
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        if (type == 'medical') {
          _medicalFile = result.files.first;
        } else if (type == 'transfer') {
          _transferFile = result.files.first;
        }
      });
    }
  }

  void _removeFile(String type) {
    setState(() {
      if (type == 'medical') {
        _medicalFile = null;
      } else if (type == 'transfer') {
        _transferFile = null;
      }
    });
  }

  Widget _uploadSection(String title, PlatformFile? file, VoidCallback onUpload, VoidCallback onRemove) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const Text("Upload image size 4MB, Format JPG,PNG,SVG", style: TextStyle(fontSize: 10)),
        const SizedBox(height: 6),
        if (file != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text("Selected: ${file.name}", style: const TextStyle(fontSize: 10)),
          ),
        Row(
          children: [
            ElevatedButton(
              onPressed: onUpload,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(80, 30),
                textStyle: const TextStyle(fontSize: 12),
              ),
              child: const Text("Upload", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 8),
            if (file != null)
              ElevatedButton(
                onPressed: onRemove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(80, 30),
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: const Text("Remove", style: TextStyle(color: Colors.white)),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFD9E3E4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 49,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF5182A8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  "Documents",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _uploadSection(
              "Medical Condition",
              _medicalFile,
              () => _pickFile("medical"),
              () => _removeFile("medical"),
            ),
            const SizedBox(height: 20),
            _uploadSection(
              "Upload Transfer Certificate",
              _transferFile,
              () => _pickFile("transfer"),
              () => _removeFile("transfer"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => provider.prevStep(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(60, 32),
                    textStyle: const TextStyle(fontSize: 11),
                  ),
                  child: const Text("Back", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => provider.nextStep(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(60, 32),
                    textStyle: const TextStyle(fontSize: 11),
                  ),
                  child: const Text("Next", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
