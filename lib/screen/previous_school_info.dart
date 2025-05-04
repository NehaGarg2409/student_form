import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/registration_provider.dart';

class PreviousSchoolInfo extends StatefulWidget {
  const PreviousSchoolInfo({super.key});

  @override
  State<PreviousSchoolInfo> createState() => _PreviousSchoolInfoState();
}

class _PreviousSchoolInfoState extends State<PreviousSchoolInfo> {
  late TextEditingController schoolNameController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    schoolNameController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    schoolNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFD9E3E4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 49,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF5182A8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  "Previous School Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _textField("School Name", schoolNameController),
            const SizedBox(height: 15),
            _textField("Address", addressController),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => provider.prevStep(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(60, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    textStyle: const TextStyle(fontSize: 11),
                  ),
                  child: const Text("Back", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    print("School Name: ${schoolNameController.text}");
                    print("Address: ${addressController.text}");
                    provider.nextStep(); // or handle submission here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(60, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    textStyle: const TextStyle(fontSize: 11),
                  ),
                  child: const Text("Submit", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
