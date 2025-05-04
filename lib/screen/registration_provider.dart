import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  bool _showRegistration = false;
  String? _selected; 
  int currentStep = 0;

    String? get selected => _selected; 

  bool get showRegistration => _showRegistration;

  void openRegistration(bool value) {
    _showRegistration = value;
    notifyListeners();
  }
                   
  void select(String? value) {        
    _selected = value;
    notifyListeners();              
  }

    void nextStep() {
    if (currentStep < 9) {  // Assuming 9 steps in total (index 0 to 8)
      currentStep++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  void reset() {
    currentStep = 0;
    notifyListeners();
  }
    void next(int? step) {
    if (step != null) {
      currentStep = step;
      notifyListeners();
    }
  }

}
