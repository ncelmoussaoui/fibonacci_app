import 'package:flutter/material.dart';

class FibonacciCalculator extends StatefulWidget {
  const FibonacciCalculator({super.key});

  @override
  State<FibonacciCalculator> createState() => _FibonacciCalculatorState();
}

class _FibonacciCalculatorState extends State<FibonacciCalculator> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  int fibonacci(int n) {
    if (n < 0) {
      throw ArgumentError("n muss eine nicht-negative ganze Zahl sein.");
    } else if (n == 0) {
      return 0;
    } else if (n == 1) {
      return 1;
    } else {
      int a = 0, b = 1, c;
      for (int i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
      }
      return b;
    }
  }

  void _calculateFibonacci() {
    setState(() {
      try {
        final n = int.parse(_controller.text);
        final result = fibonacci(n);
        _result = 'Die ${n}te Fibonacci-Zahl ist: $result';
      } catch (e) {
        if (e is FormatException) {
          _result = 'Bitte geben Sie eine gültige Zahl ein';
        } else if (e is ArgumentError) {
          _result = e.message.toString();
        } else {
          _result = 'Ein Fehler ist aufgetreten';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fibonacci Rechner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Geben Sie eine Zahl ein',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateFibonacci,
              child: const Text('Berechnen'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
