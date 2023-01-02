import 'dart:convert';

import 'package:flutter/material.dart';
import 'image_viewer.dart';
import 'providers/providers_category.dart';

void main() {
  runApp(const MyApp());
}

const version = 'v0.0.1';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Image Viewer $version';
    return MaterialApp(
      title: 'Image Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: title),
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
  List<String> categoryList = [];
  List<String> groupList = [];
  List<String> queryList = [];
  List<String> boardIdList = [];

  final GlobalKey<ImageViewerState> _key = GlobalKey<ImageViewerState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String? isSelectedCategory = '';
  String? isSelectedGroup = 'TWICE';
  String? isSelectedQueryName = 'TWICE';
  String? isSelectedBoardId = ''; // default, must in DropdownItem value

  void getCategoryData() async {
    UserProviders userProviders = UserProviders();
    userProviders.getUser().then((value) => value.forEach((element) {
          print(element.response.categories.first.coverUrl);
        }));
  }

  // category
  Future<void> getCategoryList() async {
    try {
      ImageProviders imageProviders = ImageProviders();
      List<String> response = await imageProviders.getCategoryList();
      setState(() {
        categoryList = response;
        isSelectedCategory = response[0];
        getGroupList(isSelectedCategory.toString());
        // _key.currentState?.getImage(isSelectedBoardId.toString());
      });
    } catch (_) {
      debugPrint('getCategoryList: error');
    }
  }

  Widget categoryDropdownWidget(List<String> categoryList) {
    return DropdownButton(
      items: categoryList
          .map((boardId) =>
              DropdownMenuItem(value: boardId, child: Text(boardId)))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          isSelectedCategory = value;
          getGroupList(isSelectedCategory.toString());
          // _key.currentState?.getImage(value.toString()); // todo: success
        });
      },
      value: isSelectedCategory,
    );
  }

  // group
  Future<void> getGroupList(String categoryName) async {
    try {
      ImageProviders imageProviders = ImageProviders();
      List<String> response = await imageProviders.getGroupList(categoryName);
      setState(() {
        groupList = response;
        isSelectedGroup = response[0];
        getQueryList(categoryName, isSelectedGroup.toString());
        // _key.currentState?.getImage(isSelectedBoardId.toString());
      });
    } catch (_) {
      debugPrint('getCategoryList: error');
    }
  }

  Widget groupDropdownWidget(List<String> groupList) {
    return DropdownButton(
      items: groupList
          .map((groupName) =>
              DropdownMenuItem(value: groupName, child: Text(groupName)))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          isSelectedGroup = value;
          getQueryList(
              isSelectedCategory.toString(), isSelectedGroup.toString());
          // _key.currentState?.getImage(value.toString());
        });
      },
      value: isSelectedGroup,
    );
  }

  // query
  Future<void> getQueryList(String categoryName, String groupName) async {
    try {
      ImageProviders imageProviders = ImageProviders();
      List<String> response =
          await imageProviders.getQueryList(categoryName, groupName);
      setState(() {
        queryList = response;
        isSelectedQueryName = response[0];
        getBoardIdList(isSelectedQueryName.toString());
      });
    } catch (_) {
      debugPrint('getGroups: error');
    }
  }

  Widget queryDropdownWidget(List<String> queryList) {
    return DropdownButton(
      items: queryList
          .map((queryName) =>
              DropdownMenuItem(value: queryName, child: Text(queryName)))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          isSelectedQueryName = value;
          getBoardIdList(isSelectedQueryName.toString());
          // _key.currentState?.getImage(value.toString()); // todo: success
        });
      },
      value: isSelectedQueryName,
    );
  }

  // board
  Future<void> getBoardIdList(String queryName) async {
    try {
      ImageProviders imageProviders = ImageProviders();
      List<String> response = await imageProviders.getBoaedIdList(queryName);
      setState(() {
        boardIdList = response;
        isSelectedBoardId = response[0];
        _key.currentState?.getImage(isSelectedBoardId.toString());
      });
    } catch (_) {
      debugPrint('getGroups: error');
    }
  }

  Widget dropdownButtonWidget(List<String> boardIdList) {
    return DropdownButton(
      items: boardIdList
          .map((boardId) => DropdownMenuItem(
              value: boardId, child: Text(boardId.substring(0, 6))))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          isSelectedBoardId = value;
          _key.currentState?.getImage(value.toString()); // todo: success
        });
      },
      value: isSelectedBoardId,
    );
  }

  @override
  void initState() {
    super.initState();
    getCategoryList();
    // getBoardIdList(isSelectedGroup.toString());
  }

  @override
  Widget build(BuildContext context) {
    // todo: check provider
    // getCategoryData();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(child: categoryDropdownWidget(categoryList)),
                  Flexible(child: groupDropdownWidget(groupList)),
                  Flexible(child: queryDropdownWidget(queryList)),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(child: dropdownButtonWidget(boardIdList)),
                ]),

            // _image_view(isSelectedItem),
            ImageViewer(
                key: _key, isSelectedItem: isSelectedBoardId.toString()),

            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      )),
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
  String _url =
      'https://1.bp.blogspot.com/-7uiCs6dI4a0/YEGQA-8JOrI/AAAAAAABddA/qPFt2E8vDfQwPQsAYLvk4lowkwP-GN7VQCNcBGAsYHQ/s896/buranko_girl_smile.png';

  if (isSelectedItem == 'aaa') {
    String _url =
        'https://2.bp.blogspot.com/-tVKhDc9GKXU/ULxuAO4F9eI/AAAAAAAAHm8/XAl0zToQtVM/s1600/animal_taka.png';
  } else if (isSelectedItem == 'bbb') {
    String _url =
        'https://4.bp.blogspot.com/-mfqbB0DfCDo/UTbWrZXNlPI/AAAAAAAAOic/lkRI5dseik4/s1600/bird_hato.png';
  }
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text(isSelectedItem),
    Container(
      width: _width,
      child: Image.network('$_url'),
    ),
    Container(
      width: _width,
      child: Image.network(
          'https://4.bp.blogspot.com/-mfqbB0DfCDo/UTbWrZXNlPI/AAAAAAAAOic/lkRI5dseik4/s1600/bird_hato.png'),
    ),
  ]);
}
