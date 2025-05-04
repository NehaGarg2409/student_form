import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_form/screen/registration_provider.dart';
// import 'registration_screen.dart';

class RegistrationCard extends StatelessWidget {
  const RegistrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345,
      height: 147,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Row(
          children: [
            // Left Image
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                   color: Colors.black,
                     height: double.infinity,
                     
                  )

              ),
            ),
            // Right Button
            Expanded(
              flex: 1,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                     context.read<RegistrationProvider>().openRegistration(true);

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Registration', style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
