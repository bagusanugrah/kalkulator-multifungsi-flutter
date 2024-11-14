import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmi = 0.0;
  String _bmiCategory = '';

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    setState(() {
      _bmi = weight / ((height / 100) * (height / 100));
      _bmiCategory = _getBMICategory(_bmi);
    });
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Kurus.";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Ideal.";
    } else if (bmi >= 25 && bmi < 29.9) {
      return "Gemuk.";
    } else {
      return "Terlalu gemuk.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tinggi (cm)'),
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Berat (kg)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('Hitung BMI'),
            ),
            SizedBox(height: 20),
            Text('BMI: $_bmi'),
            Text('Kategori: $_bmiCategory'), // Menampilkan kategori BMI
          ],
        ),
      ),
    );
  }
}
