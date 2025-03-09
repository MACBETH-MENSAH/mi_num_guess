import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GuessingGame(),
    );
  }
}

class GuessingGame extends StatefulWidget {
  @override
  _GuessingGameState createState() => _GuessingGameState();
}

class _GuessingGameState extends State<GuessingGame> {
  final TextEditingController _controller = TextEditingController();
  late int _numberToGuess;
  int _userGuess = 0;
  int _numberOfAttempts = 0;
  String _feedbackMessage =
      "I have chosen a number between 1 and 100. Try to guess it!";
  final int _maxAttempts = 99;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    _numberToGuess = Random().nextInt(100) + 1;
    _numberOfAttempts = 0;
    _feedbackMessage =
        "I have chosen a number between 1 and 100. Try to guess it!";
  }

  void _checkGuess() {
    setState(() {
      _userGuess = int.tryParse(_controller.text) ?? 0;
      _numberOfAttempts++;

      if (_numberOfAttempts > _maxAttempts) {
        _feedbackMessage =
            "Sorry! You have exceeded the maximum number of attempts.";
        return;
      }

      if (_userGuess > _numberToGuess) {
        _feedbackMessage = "Too high! Try again.";
      } else if (_userGuess < _numberToGuess) {
        _feedbackMessage = "Too low! Try again.";
      } else {
        _feedbackMessage =
            "Congratulations! You guessed the number in $_numberOfAttempts attempts.";
      }

      _controller.clear(); // Clear the input field after each guess
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Guessing Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _feedbackMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your guess',
              ),
              onSubmitted: (_) =>
                  _checkGuess(), // Allows submission on pressing "Enter"
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkGuess,
              child: const Text('Guess'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resetGame();
                });
              },
              child: const Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}
