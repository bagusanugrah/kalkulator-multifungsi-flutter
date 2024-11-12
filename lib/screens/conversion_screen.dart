import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'IDR';
  double _result = 0.0;

  final List<String> _currencies = ['USD', 'IDR', 'EUR', 'JPY', 'GBP'];

  // Tabel kurs tetap (contoh perhitungan)
  final Map<String, double> _exchangeRates = {
    'USD': 1.0, // Base currency
    'IDR': 15000.0, // USD to IDR
    'EUR': 0.85, // USD to EUR
    'JPY': 110.0, // USD to JPY
    'GBP': 0.75 // USD to GBP
  };

  void _convertCurrency() {
    setState(() {
      double amount = double.tryParse(_amountController.text) ?? 0.0;

      // Konversi jumlah dari mata uang asal (fromCurrency) ke USD, kemudian ke mata uang tujuan (toCurrency)
      double amountInUSD =
          amount / _exchangeRates[_fromCurrency]!; // Mengonversi ke USD
      _result = amountInUSD *
          _exchangeRates[
              _toCurrency]!; // Mengonversi dari USD ke mata uang tujuan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah ($_fromCurrency)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  items: _currencies
                      .map((currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value!;
                    });
                  },
                ),
                Icon(Icons.swap_horiz),
                DropdownButton<String>(
                  value: _toCurrency,
                  items: _currencies
                      .map((currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Konversi'),
            ),
            SizedBox(height: 20),
            Text(
              'Hasil: ${_result.toStringAsFixed(2)} $_toCurrency',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
