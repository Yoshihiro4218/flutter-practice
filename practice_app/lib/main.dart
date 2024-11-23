import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter StopWatch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter StopWatch Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {});
      });
    }
  }

  void _stopStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formattedTime() {
    final millis = _stopwatch.elapsedMilliseconds;
    final seconds = (millis / 1000).truncate();
    final minutes = (seconds / 60).truncate();
    final hours = (minutes / 60).truncate();
    final remainderSeconds = (seconds % 60).toString().padLeft(2, '0');
    final formattedMillis = ((millis % 1000) ~/ 100).toString().padLeft(1, '0');

    final formatted = [
      if (hours > 0) hours.toString().padLeft(2, '0'),
      minutes.toString().padLeft(2, '0'),
      remainderSeconds,
    ].join(':') + '.$formattedMillis';

    return formatted;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formattedTime(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _stopStopwatch,
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}