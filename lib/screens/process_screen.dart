import 'package:flutter/material.dart';
import 'package:kaprekar/constants.dart';

class ProcessScreen extends StatefulWidget {
  final int number;

  const ProcessScreen({Key? key, required this.number}) : super(key: key);

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen>
    with TickerProviderStateMixin {
  List<Map<String, String>> stepsData = [];

  @override
  void initState() {
    super.initState();
    _computeSteps();
  }

  void _computeSteps() {
    int current = widget.number;
    Set<int> seen = {};
    int stepIndex = 0;
    while (!seen.contains(current) && current != 6174) {
      seen.add(current);
      String original = current.toString().padLeft(4, '0');
      List<int> digits = original.split('').map(int.parse).toList();
      digits.sort(); // ascending
      String asc = digits.map((d) => d.toString()).join('');
      digits = digits.reversed.toList(); // descending
      String desc = digits.map((d) => d.toString()).join('');
      int next = int.parse(desc) - int.parse(asc);
      stepsData.add({
        'original': original,
        'desc': desc,
        'asc': asc,
        'result': next.toString().padLeft(4, '0'),
      });
      current = next;
      stepIndex++;
      if (stepIndex > 10) break; // safety
    }
    if (current == 6174) {
      stepsData.add({
        'original': '6174',
        'desc': '7641',
        'asc': '1467',
        'result': '6174',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Processing ${widget.number}', style: style),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: stepsData.length,
        itemBuilder: (context, index) {
          return StepWidget(
            data: stepsData[index],
            delay: index * 2.0, // Each step takes 2 seconds
          );
        },
      ),
    );
  }
}

class StepWidget extends StatefulWidget {
  final Map<String, String> data;
  final double delay;

  const StepWidget({Key? key, required this.data, this.delay = 0})
      : super(key: key);

  @override
  State<StepWidget> createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _originalOpacity;
  late Animation<double> _descOpacity;
  late Animation<double> _ascOpacity;
  late Animation<double> _resultOpacity;

  @override
  bool get wantKeepAlive => true;

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
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                      Text('Initial:',
                          style:
                              style.copyWith(fontSize: 18, color: colorBlue)),
                      Text("${widget.data['original']!}  ",
                          style:
                              style.copyWith(fontSize: 18, color: colorBlue)),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
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
                              style.copyWith(fontSize: 18, color: colorGreen)),
                      Text("${widget.data['desc']!} -",
                          style:
                              style.copyWith(fontSize: 18, color: colorGreen)),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
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
                              style.copyWith(fontSize: 18, color: colorOrange)),
                      Text("${widget.data['asc']!} =",
                          style:
                              style.copyWith(fontSize: 18, color: colorOrange)),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
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
                              style.copyWith(fontSize: 18, color: colorBlue)),
                      Text("${widget.data['result']!}  ",
                          style:
                              style.copyWith(fontSize: 18, color: colorBlue)),
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
