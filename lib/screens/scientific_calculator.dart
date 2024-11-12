import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

class ScientificCalculator extends StatefulWidget {
  @override
  _ScientificCalculatorState createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  TextEditingController _controller = TextEditingController();
  String _expression = '';
  bool _isInverse = false;

  void _onPressed(String text) {
    int cursorPos = _controller.selection.base.offset;
    if (cursorPos == -1) {
      cursorPos = _controller.text.length;
    }

    String newText;
    if (text == 'sin' ||
        text == 'cos' ||
        text == 'tan' ||
        text == '√' ||
        text == 'ln' ||
        text == 'log') {
      newText = _controller.text.substring(0, cursorPos) +
          text +
          '(' +
          _controller.text.substring(cursorPos);
      cursorPos += text.length + 1;
    } else {
      newText = _controller.text.substring(0, cursorPos) +
          text +
          _controller.text.substring(cursorPos);
      cursorPos += text.length;
    }

    setState(() {
      _expression = newText;
      _controller.text = _expression;
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPos));
    });
  }

  void _evaluate() {
    try {
      // Menghitung jumlah kurung buka '(' dan kurung tutup ')'
      int openBrackets = '('.allMatches(_expression).length;
      int closeBrackets = ')'.allMatches(_expression).length;

      // Menambahkan kurung tutup yang hilang jika jumlahnya tidak seimbang
      String balancedExpression = _expression;
      if (openBrackets > closeBrackets) {
        balancedExpression += ')' * (openBrackets - closeBrackets);
      }

      // Lakukan penggantian log manual untuk log10(x) menjadi ln(x) / ln(10)
      String finalExpression = balancedExpression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('√', 'sqrt')
          .replaceAll('π', '3.141592653589793')
          .replaceAll('e', '2.718281828459045')
          .replaceAllMapped(
            RegExp(r'log\(([^)]+)\)'), // Temukan pola log(x)
            (match) =>
                '(ln(${match[1]}) / ln(10))', // Ganti log(x) dengan ln(x)/ln(10)
          );

      // Parsing dan evaluasi ekspresi
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        _expression = eval.toString();
        _controller.text = _expression;
      });
    } catch (e) {
      setState(() {
        _controller.text = 'Error';
      });
    }
  }

  void _clear() {
    setState(() {
      _expression = '';
      _controller.text = _expression;
    });
  }

  void _backspace() {
    if (_expression.isNotEmpty) {
      setState(() {
        _expression = _expression.substring(0, _expression.length - 1);
        _controller.text = _expression;
      });
    }
  }

  void _toggleInverse() {
    setState(() {
      _isInverse = !_isInverse;
    });
  }

  String _getFunctionText(String function) {
    if (_isInverse) {
      switch (function) {
        case 'sin':
          return 'arcsin';
        case 'cos':
          return 'arccos';
        case 'tan':
          return 'arctan';
        default:
          return function;
      }
    }
    return function;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scientific Calculator'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke HomeScreen
          },
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            readOnly: true,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 24),
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5, // Menambah kolom agar tombol lebih kecil
              padding: EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                CalculatorButton('7', _onPressed),
                CalculatorButton('8', _onPressed),
                CalculatorButton('9', _onPressed),
                CalculatorButton('÷', _onPressed),
                CalculatorButton('⌫', _backspace, isBackspace: true),
                CalculatorButton('4', _onPressed),
                CalculatorButton('5', _onPressed),
                CalculatorButton('6', _onPressed),
                CalculatorButton('×', _onPressed),
                CalculatorButton('C', _clear, isClear: true),
                CalculatorButton('1', _onPressed),
                CalculatorButton('2', _onPressed),
                CalculatorButton('3', _onPressed),
                CalculatorButton('-', _onPressed),
                CalculatorButton('(', _onPressed),
                CalculatorButton('0', _onPressed),
                CalculatorButton('.', _onPressed),
                CalculatorButton('=', _evaluate),
                CalculatorButton('+', _onPressed),
                CalculatorButton(')', _onPressed),
                CalculatorButton(_getFunctionText('sin'), _onPressed),
                CalculatorButton(_getFunctionText('cos'), _onPressed),
                CalculatorButton(_getFunctionText('tan'), _onPressed),
                CalculatorButton(_getFunctionText('log'), _onPressed),
                CalculatorButton('Inv', _toggleInverse, inverse: true),
                CalculatorButton('ln', _onPressed),
                CalculatorButton('e', _onPressed),
                CalculatorButton('π', _onPressed),
                CalculatorButton('√', _onPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function callback;
  final bool inverse;
  final bool isClear;
  final bool isBackspace;

  CalculatorButton(this.text, this.callback,
      {this.inverse = false, this.isClear = false, this.isBackspace = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (callback is Function(String)) {
          (callback as Function(String))(text);
        } else if (callback is Function()) {
          (callback as Function())();
        }
      },
      child: Container(
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: isClear
              ? Colors.redAccent
              : (isBackspace
                  ? Colors.blueAccent
                  : (inverse ? Colors.orangeAccent : Colors.grey[200])),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18.0,
                color: isClear || inverse || isBackspace
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
