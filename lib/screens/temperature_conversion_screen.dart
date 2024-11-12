import 'package:flutter/material.dart';

class TemperatureConversionScreen extends StatefulWidget {
  @override
  _TemperatureConversionScreenState createState() =>
      _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState
    extends State<TemperatureConversionScreen> {
  final TextEditingController _tempController = TextEditingController();
  String _selectedUnit = 'Celsius';
  String _targetUnit = 'Fahrenheit';
  double _result = 0.0;

  // Fungsi konversi suhu
  void _convertTemperature() {
    double temp = double.tryParse(_tempController.text) ?? 0.0;

    setState(() {
      if (_selectedUnit == 'Celsius') {
        if (_targetUnit == 'Fahrenheit') {
          _result = (temp * 9 / 5) + 32; // Celsius ke Fahrenheit
        } else if (_targetUnit == 'Kelvin') {
          _result = temp + 273.15; // Celsius ke Kelvin
        } else {
          _result = temp; // Celsius ke Celsius
        }
      } else if (_selectedUnit == 'Fahrenheit') {
        if (_targetUnit == 'Celsius') {
          _result = (temp - 32) * 5 / 9; // Fahrenheit ke Celsius
        } else if (_targetUnit == 'Kelvin') {
          _result = (temp - 32) * 5 / 9 + 273.15; // Fahrenheit ke Kelvin
        } else {
          _result = temp; // Fahrenheit ke Fahrenheit
        }
      } else if (_selectedUnit == 'Kelvin') {
        if (_targetUnit == 'Celsius') {
          _result = temp - 273.15; // Kelvin ke Celsius
        } else if (_targetUnit == 'Fahrenheit') {
          _result = (temp - 273.15) * 9 / 5 + 32; // Kelvin ke Fahrenheit
        } else {
          _result = temp; // Kelvin ke Kelvin
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Suhu ($_selectedUnit)'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Dari:'),
                    DropdownButton<String>(
                      value: _selectedUnit,
                      items: ['Celsius', 'Fahrenheit', 'Kelvin']
                          .map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedUnit = value!;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Ke:'),
                    DropdownButton<String>(
                      value: _targetUnit,
                      items: ['Celsius', 'Fahrenheit', 'Kelvin']
                          .map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _targetUnit = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Konversi'),
            ),
            SizedBox(height: 20),
            Text(
              'Hasil: $_result $_targetUnit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
