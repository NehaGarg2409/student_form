import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/registration_provider.dart';

class HostelInfo extends StatefulWidget {
  const HostelInfo({super.key});

  @override
  State<HostelInfo> createState() => _HostelInfoState();
}

class _HostelInfoState extends State<HostelInfo> {
  late TextEditingController hostelController;
  late TextEditingController roomNoController;

  @override
  void initState() {
    super.initState();
    hostelController = TextEditingController();
    roomNoController = TextEditingController();
  }

  @override
  void dispose() {
    hostelController.dispose();
    roomNoController.dispose();
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
                  "Hostel Info",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _textField("Hostel", hostelController),
            const SizedBox(height: 24),
            _textField("Room No", roomNoController),
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
                    // Example: You can access the input like this
                    print("Hostel: ${hostelController.text}");
                    print("Room No: ${roomNoController.text}");
                    provider.nextStep();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(60, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
