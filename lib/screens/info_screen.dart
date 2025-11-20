import 'package:flutter/material.dart';
import 'package:kaprekar/constants.dart';
import 'package:share_plus/share_plus.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  void _shareApp() {
    Share.share(
      'Check out this Kaprekar app! Discover the magic of Kaprekar\'s constant 6174. #Kaprekar #MathMagic',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Kaprekar', style: style),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareApp,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            color: themeColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kaprekar's Routine",
                    style: style.copyWith(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Kaprekar's routine is a mathematical operation on four-digit numbers that, when repeated, often leads to the number 6174, known as Kaprekar's constant.",
                    style: style.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'How it works:',
                    style: style.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. Take any four-digit number (with at least two different digits).\n'
                    '2. Arrange the digits in descending order to form the largest number.\n'
                    '3. Arrange the digits in ascending order to form the smallest number.\n'
                    '4. Subtract the smaller number from the larger number.\n'
                    '5. Repeat the process with the result.',
                    style: style.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Example:',
                    style: style.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const AnimatedExample(),
                  const SizedBox(height: 16),
                  Text(
                    "Named after the Indian mathematician D. R. Kaprekar.",
                    style: style.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/kaprekar.png'),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    '---\n\n3270 NerdFont by Ryan L McIntyre - nerdfonts.com\nMade with ❤️ by Emanuele MEK Tozzato - ainzcorp.com',
                    style: style.copyWith(fontSize: 12, color: colorGrey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedExample extends StatefulWidget {
  const AnimatedExample({Key? key}) : super(key: key);

  @override
  State<AnimatedExample> createState() => _AnimatedExampleState();
}

class _AnimatedExampleState extends State<AnimatedExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _originalOpacity;
  late Animation<double> _descOpacity;
  late Animation<double> _ascOpacity;
  late Animation<double> _resultOpacity;

  final List<Map<String, String>> steps = [
    {'original': '1234', 'desc': '4321', 'asc': '1234', 'result': '3087'},
    {'original': '3087', 'desc': '8730', 'asc': '0378', 'result': '8352'},
    {'original': '8352', 'desc': '8532', 'asc': '2358', 'result': '6174'},
    {'original': '6174', 'desc': '7641', 'asc': '1467', 'result': '6174'},
  ];

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _originalOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );
    _descOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.5, curve: Curves.easeIn),
      ),
    );
    _ascOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeIn),
      ),
    );
    _resultOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );

    _startAnimation();
  }

  void _startAnimation() {
    _controller.forward(from: 0).then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          currentStep = (currentStep + 1) % steps.length;
        });
        _startAnimation();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = steps[currentStep];
    return Card(
      color: themeColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _originalOpacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Original:',
                          style:
                              style.copyWith(fontSize: 16, color: colorBlue)),
                      Text(step['original']!,
                          style:
                              style.copyWith(fontSize: 16, color: colorBlue)),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _descOpacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Descending:',
                          style:
                              style.copyWith(fontSize: 16, color: colorGreen)),
                      Text(step['desc']!,
                          style:
                              style.copyWith(fontSize: 16, color: colorGreen)),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _ascOpacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ascending:',
                          style:
                              style.copyWith(fontSize: 16, color: colorOrange)),
                      Text(step['asc']!,
                          style:
                              style.copyWith(fontSize: 16, color: colorOrange)),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _resultOpacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Result:',
                          style:
                              style.copyWith(fontSize: 16, color: colorBlue)),
                      Text(step['result']!,
                          style:
                              style.copyWith(fontSize: 16, color: colorBlue)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
