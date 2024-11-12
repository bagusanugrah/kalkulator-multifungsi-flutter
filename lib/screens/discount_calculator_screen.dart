import 'package:flutter/material.dart';

class DiscountCalculatorScreen extends StatefulWidget {
  @override
  _DiscountCalculatorScreenState createState() =>
      _DiscountCalculatorScreenState();
}

class _DiscountCalculatorScreenState extends State<DiscountCalculatorScreen> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  double _finalPrice = 0.0;

  void _calculateDiscount() {
    double price = double.tryParse(_priceController.text) ?? 0.0;
    double discount = double.tryParse(_discountController.text) ?? 0.0;
    setState(() {
      _finalPrice = price - (price * discount / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Diskon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga Awal (Rp)'),
            ),
            TextField(
              controller: _discountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Diskon (%)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateDiscount,
              child: Text('Hitung Diskon'),
            ),
            SizedBox(height: 20),
            Text('Harga Akhir: Rp $_finalPrice'),
          ],
        ),
      ),
    );
  }
}
