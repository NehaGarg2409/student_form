import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/registration_provider.dart';

class TransportInfo extends StatefulWidget {
  const TransportInfo({super.key});

  @override
  State<TransportInfo> createState() => _TransportInfoState();
}

class _TransportInfoState extends State<TransportInfo> {
  // Controllers for text fields
  final TextEditingController _routeController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController _pickupPointController = TextEditingController();

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
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
              width: 391,
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
                  "Transport Info",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _textField("Route", _routeController),
            const SizedBox(height: 20),
            _textField("Vehicle No", _vehicleNoController),
            const SizedBox(height: 20),
            _textField("Pickup Point", _pickupPointController),
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
                  onPressed: () => provider.nextStep(),
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

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _routeController.dispose();
    _vehicleNoController.dispose();
    _pickupPointController.dispose();
    super.dispose();
  }
}
