import 'package:flutter/material.dart';

class AreaVolumeScreen extends StatefulWidget {
  @override
  _AreaVolumeScreenState createState() => _AreaVolumeScreenState();
}

class _AreaVolumeScreenState extends State<AreaVolumeScreen> {
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController();
  double _resultArea = 0.0;
  double _resultVolume = 0.0;
  String _shape = 'Balok';

  void _calculate() {
    double length = double.tryParse(_lengthController.text) ?? 0.0;
    double width = double.tryParse(_widthController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double radius = double.tryParse(_radiusController.text) ?? 0.0;

    setState(() {
      if (_shape == 'Balok') {
        _resultArea =
            2 * ((length * width) + (length * height) + (width * height));
        _resultVolume = length * width * height;
      } else if (_shape == 'Kubus') {
        _resultArea = 6 * (length * length);
        _resultVolume = length * length * length;
      } else if (_shape == 'Silinder') {
        _resultArea = 2 * 3.14159 * radius * (radius + height);
        _resultVolume = 3.14159 * radius * radius * height;
      } else if (_shape == 'Bola') {
        _resultArea = 4 * 3.14159 * radius * radius;
        _resultVolume = (4 / 3) * 3.14159 * radius * radius * radius;
      }
    });
  }

  Widget _buildInputFields() {
    if (_shape == 'Balok') {
      return Column(
        children: [
          TextField(
            controller: _lengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Panjang (m)'),
          ),
          TextField(
            controller: _widthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Lebar (m)'),
          ),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Tinggi (m)'),
          ),
        ],
      );
    } else if (_shape == 'Kubus') {
      return TextField(
        controller: _lengthController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Sisi (m)'),
      );
    } else if (_shape == 'Silinder') {
      return Column(
        children: [
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Tinggi (m)'),
          ),
          TextField(
            controller: _radiusController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Jari-jari (m)'),
          ),
        ],
      );
    } else if (_shape == 'Bola') {
      return TextField(
        controller: _radiusController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Jari-jari (m)'),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perhitungan Luas & Volume'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _shape,
              items: ['Balok', 'Kubus', 'Silinder', 'Bola']
                  .map((shape) => DropdownMenuItem(
                        value: shape,
                        child: Text(shape),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _shape = value!;
                  _lengthController.clear();
                  _widthController.clear();
                  _heightController.clear();
                  _radiusController.clear();
                });
              },
            ),
            SizedBox(height: 20),
            _buildInputFields(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Hitung'),
            ),
            SizedBox(height: 20),
            Text(
              'Luas: ${_resultArea.toStringAsFixed(2)} m²',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Volume: ${_resultVolume.toStringAsFixed(2)} m³',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
