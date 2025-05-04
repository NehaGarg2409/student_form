import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/address_info.dart';
import 'package:student_form/screen/documents_upload.dart';
import 'package:student_form/screen/guardians_siblings_info.dart';
import 'package:student_form/screen/hostel_info.dart';
import 'package:student_form/screen/medical_history.dart';
import 'package:student_form/screen/parents_info.dart';
import 'package:student_form/screen/previous_school_info.dart';
import 'package:student_form/screen/student_registration.dart';
import 'package:student_form/screen/transport_info.dart';
import 'registration_provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final List<String> options = [
    'STUDENT',
     'TEACHER'
     
     ];
  String? selected;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context);

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 391,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected == null)
              const Text(
                "Registration",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            if (selected == null)
              SizedBox(
                width: 292,
                child: SingleChildScrollView(
                  child: Column(
                    children: options.map((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selected == option
                                ? Colors.blueAccent
                                : Colors.grey.shade300,
                            foregroundColor: selected == option
                                ? Colors.white
                                : Colors.black,
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selected = option;
                            });
                            provider.select(option);
                          },
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (selected == 'STUDENT')
              Expanded(
                child: [
                  const StudentRegistration(),
                  const ParentsInfo(),
                  const GuardianAndSiblingsInfo(),
                  const AddressInfo(),
                  const TransportInfo(),
                  const HostelInfo(),
                  const DocumentsInfo(),
                  const MedicalHistory(),
                  const PreviousSchoolInfo(),
                ][provider.currentStep],
              ),
          ],
        ),
      ),
    );
  }
}
