import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('AC')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('+/-')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('%')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('/')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('7')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('8')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('9')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('*')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('4')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('5')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('6')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('-')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('1')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('2')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('3')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('+')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('0')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('.')),
                ElevatedButton(
                    onPressed: DoNothingAction.new, child: const Text('=')),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
