import 'package:flutter/material.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  @override
  _ExpenseTrackerScreenState createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedCategory = 'Makanan';
  bool _isCash = false;
  bool _isCard = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<Map<String, dynamic>> _expenses = [];

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _saveExpense() {
    if (_expenseNameController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lengkapi nama pengeluaran dan jumlah')),
      );
      return;
    }

    setState(() {
      _expenses.add({
        'name': _expenseNameController.text,
        'amount': double.parse(_amountController.text),
        'category': _selectedCategory,
        'type': _isCash ? 'Cash' : (_isCard ? 'Card' : 'Other'),
        'date': _selectedDate ?? DateTime.now(),
        'time': _selectedTime ?? TimeOfDay.now(),
      });
      _expenseNameController.clear();
      _amountController.clear();
      _isCash = false;
      _isCard = false;
      _selectedDate = null;
      _selectedTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pengeluaran berhasil disimpan')),
    );
  }

  double _getTotalExpense() {
    return _expenses.fold(0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _expenseNameController,
              decoration: InputDecoration(labelText: 'Nama Pengeluaran'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah Uang'),
            ),
            SizedBox(height: 16),
            Text('Kategori Pengeluaran',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<String>(
                  value: 'Makanan',
                  groupValue: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                Text('Makanan'),
                Radio<String>(
                  value: 'Transportasi',
                  groupValue: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                Text('Transportasi'),
                Radio<String>(
                  value: 'Hiburan',
                  groupValue: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                Text('Hiburan'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _isCash,
                  onChanged: (value) {
                    setState(() {
                      _isCash = value!;
                      if (_isCash) _isCard = false;
                    });
                  },
                ),
                Text('Cash'),
                Checkbox(
                  value: _isCard,
                  onChanged: (value) {
                    setState(() {
                      _isCard = value!;
                      if (_isCard) _isCash = false;
                    });
                  },
                ),
                Text('Card'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickDate,
                    child: Text(_selectedDate == null
                        ? 'Pilih Tanggal'
                        : 'Tanggal: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickTime,
                    child: Text(_selectedTime == null
                        ? 'Pilih Waktu'
                        : 'Waktu: ${_selectedTime!.format(context)}'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveExpense,
              child: Text('Simpan Pengeluaran'),
            ),
            SizedBox(height: 16),
            Text(
                'Total Pengeluaran: Rp${_getTotalExpense().toStringAsFixed(2)}'),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return ListTile(
                    title: Text('${expense['name']} - Rp${expense['amount']}'),
                    subtitle: Text(
                        'Kategori: ${expense['category']}, Pembayaran: ${expense['type']}\nTanggal: ${expense['date'].day}/${expense['date'].month}/${expense['date'].year}, Waktu: ${expense['time'].format(context)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
