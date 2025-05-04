import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/registration_provider.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  final Map<String, TextEditingController> controllers = {};

  final List<List<String>> fieldPairs = const [
    ["name", "sex"],
    ["dob", "email"],
    ["phone", "caste"],
    ["motherTongue", "bloodGroup"],
    ["religion", "category"],
    ["primaryContact", "languageKnown"],
    ["allergies", "medicationName"],
    ["medicalCondition", "vehicleNumber"],
    ["status", "hostelName"],
    ["roomNumber", ""]
  ];

  final Map<String, String> labels = const {
    "name": "Name",
    "sex": "Sex",
    "dob": "DOB",
    "email": "Email",
    "phone": "Phone",
    "caste": "Caste",
    "motherTongue": "Mother Tongue",
    "bloodGroup": "Blood Group",
    "religion": "Religion",
    "category": "Category",
    "primaryContact": "Primary Contact No",
    "languageKnown": "Language Known",
    "allergies": "Allergies",
    "medicationName": "Medication Name",
    "medicalCondition": "Medical Condition",
    "vehicleNumber": "Vehicle Number",
    "status": "Status",
    "hostelName": "Hostel Name",
    "roomNumber": "Room Number",
  };

  @override
  void initState() {
    super.initState();
    for (var pair in fieldPairs) {
      for (var key in pair) {
        if (key.isNotEmpty) {
          controllers[key] = TextEditingController();
        }
      }
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildField(String key) {
    if (key.isEmpty) return const Expanded(child: SizedBox());

    if (key == "sex" || key == "bloodGroup") {
      List<String> options = key == "sex"
          ? ["Male", "Female", "Other"]
          : ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: SizedBox(
            height: 28,
            child: DropdownButtonFormField<String>(
              value: controllers[key]!.text.isNotEmpty ? controllers[key]!.text : null,
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 10)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  controllers[key]!.text = newValue ?? '';
                });
              },
              decoration: InputDecoration(
                labelText: labels[key],
                labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Default text field for other keys
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: SizedBox(
          height: 28,
          child: TextFormField(
            controller: controllers[key],
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              labelText: labels[key],
              labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
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
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Fields
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: fieldPairs.asMap().entries.map((entry) {
                  int index = entry.key;
                  List<String> pair = entry.value;

                  Widget row = Row(
                    children: [
                      _buildField(pair[0]),
                      const SizedBox(width: 6),
                      _buildField(pair[1]),
                    ],
                  );

                  // Add buttons in the last row
                  if (index == fieldPairs.length - 1) {
                    return Column(
                      children: [
                        row,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6, right: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Provider.of<RegistrationProvider>(context, listen: false).prevStep();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    minimumSize: const Size(80, 36),
                                  ),
                                  child: const Text("Back", style: TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    Provider.of<RegistrationProvider>(context, listen: false).nextStep();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    minimumSize: const Size(80, 36),
                                  ),
                                  child: const Text("Next", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return row;
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
