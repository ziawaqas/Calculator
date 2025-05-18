import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ماشین حساب کامل',
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';
  String _result = '';

  void _numClick(String text) {
    setState(() {
      _expression += text;
    });
  }

  void _clear(String text) {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  void _evaluate(String text) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        _result = eval.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'خطا';
      });
    }
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () {
            if (text == '=') {
              _evaluate(text);
            } else if (text == 'C') {
              _clear(text);
            } else {
              _numClick(text);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color ?? Colors.white,
            textStyle: TextStyle(fontSize: 22),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 225, 226),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_expression, style: TextStyle(fontSize: 32, color: Colors.white70)),
                    SizedBox(height: 12),
                    Text(_result, style: TextStyle(fontSize: 40, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.white24),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('7'), _buildButton('8'), _buildButton('9'), _buildButton('÷', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'), _buildButton('5'), _buildButton('6'), _buildButton('×', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'), _buildButton('2'), _buildButton('3'), _buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'), _buildButton('.'), _buildButton('C', color: Colors.red), _buildButton('+', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('=', color: Colors.green),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
