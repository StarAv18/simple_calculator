import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _display = '0';
  double _firstOperand = 0;
  String _operator = '';
  bool _shouldClear = false;

  void _onPressed(String value) {
    setState(() {
      if ('0123456789.'.contains(value)) {
        if (_shouldClear || _display == '0') {
          _display = value;
          _shouldClear = false;
        } else {
          _display += value;
        }
      } else if ('+\u2212\u00d7\u00f7'.contains(value)) {
        _firstOperand = double.parse(_display);
        _operator = value;
        _shouldClear = true;
      } else if (value == '=') {
        double secondOperand = double.parse(_display);
        double result;
        try {
          switch (_operator) {
            case '+':
              result = _firstOperand + secondOperand;
              break;
            case '−':
              result = _firstOperand - secondOperand;
              break;
            case '×':
              result = _firstOperand * secondOperand;
              break;
            case '÷':
              if (secondOperand == 0) throw Exception('Division by zero');
              result = _firstOperand / secondOperand;
              break;
            default:
              result = secondOperand;
          }
          _display = result.toString();
        } catch (e) {
          _display = 'Error';
        }
        _shouldClear = true;
      } else if (value == 'C') {
        _display = '0';
        _firstOperand = 0;
        _operator = '';
        _shouldClear = false;
      }
    });
  }

  Widget _buildButton(String value, {Color color = Colors.teal, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => _onPressed(value),
          child: Text(
            value,
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: Text(
                  _display,
                  style: const TextStyle(fontSize: 60, color: Colors.white),
                ),
              ),
            ),
            Row(children: [
              _buildButton('C'),
              _buildButton('÷'),
              _buildButton('×'),
              _buildButton('−'),
            ]),
            Row(children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('+'),
            ]),
            Row(children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('='),
            ]),
            Row(children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('0', flex: 2),
              _buildButton('.'),
            ]),
          ],
        ),
      ),
    );
  }
}
