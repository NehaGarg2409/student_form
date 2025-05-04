import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/registration_provider.dart';

class GuardianAndSiblingsInfo extends StatefulWidget {
  const GuardianAndSiblingsInfo({super.key});

  @override
  State<GuardianAndSiblingsInfo> createState() => _GuardianAndSiblingsInfoState();
}

class _GuardianAndSiblingsInfoState extends State<GuardianAndSiblingsInfo> {
  File? _guardianImage;
  final ImagePicker _picker = ImagePicker();

  // Variable to track sibling's school status (Yes/No)
  bool? _isSiblingInSameSchool = null;

  // Controllers for text fields
  final TextEditingController _guardianNameController = TextEditingController();
  final TextEditingController _guardianRelationController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _siblingNameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _admissionNoController = TextEditingController();
  final TextEditingController _classController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _guardianImage = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _guardianImage = null;
    });
  }

  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 24,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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

  Widget _imageUploader() {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _guardianImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(_guardianImage!, fit: BoxFit.cover),
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
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: const Size(50, 28),
                    textStyle: const TextStyle(fontSize: 10),
                  ),
                  child: const Text("Upload"),
                ),
                const SizedBox(width: 4),
                ElevatedButton(
                  onPressed: _removeImage,
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
            const Text("Upload image size 4MB, Format JPG,PNG,SVG", style: TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed
    _guardianNameController.dispose();
    _guardianRelationController.dispose();
    _phoneNoController.dispose();
    _emailController.dispose();
    _occupationController.dispose();
    _addressController.dispose();
    _siblingNameController.dispose();
    _rollNoController.dispose();
    _admissionNoController.dispose();
    _classController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);

    return SingleChildScrollView(
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
                "Guardian Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _imageUploader(),
          const SizedBox(height: 8),
          _textField("Guardian Name", _guardianNameController),
          _textField("Guardian Relation", _guardianRelationController),
          _textField("Phone No", _phoneNoController),
          _textField("Email", _emailController),
          _textField("Occupation", _occupationController),
          _textField("Address", _addressController),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            color: Colors.blue.shade700,
            child: const Center(
              child: Text("Siblings", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Siblings Info", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("Is Sibling studying in same school?", style: TextStyle(fontSize: 10)),
              const SizedBox(width: 8),
              Row(
                children: [
                  Radio<bool?>(
                    value: true,
                    groupValue: _isSiblingInSameSchool,
                    onChanged: (value) {
                      setState(() {
                        _isSiblingInSameSchool = value;
                      });
                    },
                  ),
                  const Text("Yes", style: TextStyle(fontSize: 10)),
                ],
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Radio<bool?>(
                    value: false,
                    groupValue: _isSiblingInSameSchool,
                    onChanged: (value) {
                      setState(() {
                        _isSiblingInSameSchool = value;
                      });
                    },
                  ),
                  const Text("No", style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
          _textField("Sibling Name", _siblingNameController),
          _textField("Roll No", _rollNoController),
          _textField("Admission No", _admissionNoController),
          _textField("Class", _classController),
          const SizedBox(height: 16),
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
