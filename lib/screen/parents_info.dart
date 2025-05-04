import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/registration_provider.dart';

class ParentsInfo extends StatefulWidget {
  const ParentsInfo({super.key});

  @override
  State<ParentsInfo> createState() => _ParentsInfoState();
}

class _ParentsInfoState extends State<ParentsInfo> {
  File? _fatherImage;
  File? _motherImage;

  final ImagePicker _picker = ImagePicker();

  // Controllers for text fields
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherEmailController = TextEditingController();
  final TextEditingController _fatherPhoneController = TextEditingController();
  final TextEditingController _fatherOccupationController = TextEditingController();

  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherEmailController = TextEditingController();
  final TextEditingController _motherPhoneController = TextEditingController();
  final TextEditingController _motherOccupationController = TextEditingController();

  Future<void> _pickImage(bool isFather) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isFather) {
          _fatherImage = File(pickedFile.path);
        } else {
          _motherImage = File(pickedFile.path);
        }
      });
    }
  }

  void _removeImage(bool isFather) {
    setState(() {
      if (isFather) {
        _fatherImage = null;
      } else {
        _motherImage = null;
      }
    });
  }

  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: SizedBox(
        height: 32,
        width: 332,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 10),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageUploader({required bool isFather}) {
    final image = isFather ? _fatherImage : _motherImage;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(image, fit: BoxFit.cover),
                )
              : const Icon(Icons.image, size: 18),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(isFather),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: const Size(50, 28),
                    textStyle: const TextStyle(fontSize: 10),
                  ),
                  child: const Text("Upload"),
                ),
                const SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () => _removeImage(isFather),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: const Size(50, 28),
                    textStyle: const TextStyle(fontSize: 10),
                  ),
                  child: const Text("Remove", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              "Upload image size 4MB, Format JPG,PNG,SVG",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
    _fatherNameController.dispose();
    _fatherEmailController.dispose();
    _fatherPhoneController.dispose();
    _fatherOccupationController.dispose();

    _motherNameController.dispose();
    _motherEmailController.dispose();
    _motherPhoneController.dispose();
    _motherOccupationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF5182A8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                "Parents Info",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _imageUploader(isFather: true),
          const SizedBox(height: 8),
          const Text("Father's Info", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: Colors.black)),
          _textField("Father Name", _fatherNameController),
          _textField("Father Email", _fatherEmailController),
          _textField("Father Phone No", _fatherPhoneController),
          _textField("Father Occupation", _fatherOccupationController),
          const SizedBox(height: 8),
          _imageUploader(isFather: false),
          const SizedBox(height: 8),
          const Text("Mother's Info", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: Colors.black)),
          _textField("Mother Name", _motherNameController),
          _textField("Mother Email", _motherEmailController),
          _textField("Mother Phone No", _motherPhoneController),
          _textField("Mother Occupation", _motherOccupationController),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => provider.prevStep(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(70, 34),
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: const Text("Back", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => provider.nextStep(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(70, 34),
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: const Text("Next", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
