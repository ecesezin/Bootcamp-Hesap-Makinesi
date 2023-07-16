import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayValue = '0';
  double _result = 0;
  String? _operator;
  bool _shouldClear = false;

  void _updateDisplay(String value) {
    setState(() {
      if (_shouldClear) {
        _displayValue = '0';
        _shouldClear = false;
      }

      if (_displayValue == '0') {
        _displayValue = value;
      } else {
        _displayValue += value;
      }
    });
  }

  void _performOperation(String value) {
    if (_operator == null) {
      _result = double.parse(_displayValue);
    } else {
      double currentValue = double.parse(_displayValue);
      switch (_operator) {
        case '+':
          _result += currentValue;
          break;
        case '-':
          _result -= currentValue;
          break;
        case '*':
          _result *= currentValue;
          break;
        case '/':
          _result /= currentValue;
          break;
      }
    }

    _operator = value;
    _shouldClear = true;
  }

  void _calculateResult() {
    if (_operator != null) {
      double currentValue = double.parse(_displayValue);
      switch (_operator) {
        case '+':
          _result += currentValue;
          break;
        case '-':
          _result -= currentValue;
          break;
        case '*':
          _result *= currentValue;
          break;
        case '/':
          _result /= currentValue;
          break;
      }
    }

    setState(() {
      _displayValue = _result.toString();
      _operator = null;
    });
  }

  void _clearDisplay() {
    setState(() {
      _displayValue = '0';
      _result = 0;
      _operator = null;
      _shouldClear = false;
    });
  }

  Widget _buildButton(String buttonText, {Color? color, required void Function() onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color ?? Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
	onPressed: () {  },
	child: ElevatedButton(
        	onPressed: onPressed,
        	child: Text(
          	buttonText,
          	style: TextStyle(fontSize: 24),
	 ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayValue,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(height: 0),
          Row(
            children: <Widget>[
              _buildButton('7', onPressed: () => _updateDisplay('7')),
              _buildButton('8', onPressed: () => _updateDisplay('8')),
              _buildButton('9', onPressed: () => _updateDisplay('9')),
              _buildButton(
                '/',
                color: Colors.orange,
                onPressed: () => _performOperation('/'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4', onPressed: () => _updateDisplay('4')),
              _buildButton('5', onPressed: () => _updateDisplay('5')),
              _buildButton('6', onPressed: () => _updateDisplay('6')),
              _buildButton(
                '*',
                color: Colors.orange,
                onPressed: () => _performOperation('*'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1', onPressed: () => _updateDisplay('1')),
              _buildButton('2', onPressed: () => _updateDisplay('2')),
              _buildButton('3', onPressed: () => _updateDisplay('3')),
              _buildButton(
                '-',
                color: Colors.orange,
                onPressed: () => _performOperation('-'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('0', onPressed: () => _updateDisplay('0')),
              _buildButton('.',
                  onPressed: () {
                    if (!_displayValue.contains('.')) {
                      _updateDisplay('.');
                    }
                  }),
              _buildButton('=',
                  color: Colors.orange,
                  onPressed: () => _calculateResult()),
              _buildButton(
                '+',
                color: Colors.orange,
                onPressed: () => _performOperation('+'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('C',
                  color: Colors.red,
                  onPressed: () => _clearDisplay()),
            ],
          ),
        ],
      ),
    );
  }
}
