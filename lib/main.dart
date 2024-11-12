import 'package:flutter/material.dart';
import 'screens/scientific_calculator.dart';
import 'screens/conversion_screen.dart';
import 'screens/temperature_conversion_screen.dart';
import 'screens/bmi_calculator_screen.dart';
import 'screens/discount_calculator_screen.dart';
import 'screens/area_volume_screen.dart';
import 'screens/expense_tracker_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Set SplashScreen sebagai layar awal
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kalkulator Multifungsi',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(context, 'Scientific Calculator', Icons.calculate,
                ScientificCalculator()),
            _buildFeatureCard(context, 'Konversi Mata Uang', Icons.attach_money,
                ConversionScreen()),
            _buildFeatureCard(context, 'Konversi Suhu', Icons.thermostat,
                TemperatureConversionScreen()),
            _buildFeatureCard(context, 'BMI Calculator', Icons.accessibility,
                BMICalculatorScreen()),
            _buildFeatureCard(context, 'Perhitungan Diskon', Icons.percent,
                DiscountCalculatorScreen()),
            _buildFeatureCard(context, 'Luas & Volume', Icons.square_foot,
                AreaVolumeScreen()),
            _buildFeatureCard(context, 'Expense Tracker',
                Icons.account_balance_wallet, ExpenseTrackerScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, String title, IconData icon, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                const Color.fromARGB(255, 3, 244, 152)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
