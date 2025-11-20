import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:kaprekar/constants.dart';
import 'package:kaprekar/screens/process_screen.dart';
import 'package:kaprekar/screens/info_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  List<int> digits = [1, 2, 3, 4]; // default to 1234
  List<FixedExtentScrollController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      controllers.add(FixedExtentScrollController(initialItem: digits[i]));
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _generateRandom() {
    final random = Random();
    setState(() {
      digits = List.generate(4, (_) => random.nextInt(10));
      for (int i = 0; i < 4; i++) {
        controllers[i].jumpToItem(digits[i]);
      }
    });
  }

  void _validateAndProceed() {
    int number =
        digits[0] * 1000 + digits[1] * 100 + digits[2] * 10 + digits[3];
    if (number < 1000) {
      // Show error, but since we have digits 0-9, and at least one non-zero probably, but allow
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProcessScreen(number: number),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName, style: style),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select a 4-digit number:',
              style: style.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 60,
                  height: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: accentColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CupertinoPicker(
                    scrollController: controllers[index],
                    itemExtent: 40,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        digits[index] = value;
                      });
                    },
                    children: List.generate(10, (i) {
                      return Center(
                        child: Text(
                          '$i',
                          style: style.copyWith(fontSize: 24),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
            if (digits.toSet().length == 1) ...[
              const SizedBox(height: 10),
              Text(
                '⚠️ This will end in 0000',
                style: style.copyWith(color: colorRed, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _generateRandom,
                  child: const Text('Random', style: style),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _validateAndProceed,
                  child: const Text('Process', style: style),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
