import 'package:flutter/material.dart';
import 'image_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Image Viewer Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage

  ({super.key, required this.title});

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

  String? isSelectedItem = 'aaa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            //dropdown
            //ref: https://blog.flutteruniv.com/flutter-dropdownbutton/
            DropdownButton(
              items: const [
                DropdownMenuItem(
                  child: Text('aaa'),
                  value: 'aaa',
                ),
                DropdownMenuItem(
                  child: Text('bbb'),
                  value: 'bbb',
                ),
                DropdownMenuItem(
                  child: Text('ccc'),
                  value: 'ccc',
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  isSelectedItem = value;
                  // _key.currentState?.setState(() {});
                });
              },
              value: isSelectedItem,
            ),

            // _image_view(isSelectedItem),
            ImageViewer(isSelectedItem: isSelectedItem.toString()),

            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget _image_view(isSelectedItem) {
  double _width = 300;
  String _url = 'https://1.bp.blogspot.com/-7uiCs6dI4a0/YEGQA-8JOrI/AAAAAAABddA/qPFt2E8vDfQwPQsAYLvk4lowkwP-GN7VQCNcBGAsYHQ/s896/buranko_girl_smile.png';

  if (isSelectedItem == 'aaa') {
    String _url = 'https://2.bp.blogspot.com/-tVKhDc9GKXU/ULxuAO4F9eI/AAAAAAAAHm8/XAl0zToQtVM/s1600/animal_taka.png';
  }
  else if (isSelectedItem == 'bbb') {
    String _url = 'https://4.bp.blogspot.com/-mfqbB0DfCDo/UTbWrZXNlPI/AAAAAAAAOic/lkRI5dseik4/s1600/bird_hato.png';
  }
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(isSelectedItem),
        Container(
          width: _width,
          child: Image.network('$_url'),
        ),
        Container(
          width: _width,
          child: Image.network(
              'https://4.bp.blogspot.com/-mfqbB0DfCDo/UTbWrZXNlPI/AAAAAAAAOic/lkRI5dseik4/s1600/bird_hato.png'
          ),
        ),
      ]
  );
}