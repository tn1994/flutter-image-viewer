import 'package:flutter/material.dart';
import 'package:src/providers/providers_category.dart';

class ImageViewer extends StatefulWidget {
  final String isSelectedItem;

  const ImageViewer({
    Key? key,
    required this.isSelectedItem,
  }) : super(key: key);

  @override
  ImageViewerState createState() => ImageViewerState();
}

class ImageViewerState extends State<ImageViewer> {
  // ref: https://teratail.com/questions/335484?link=qa_related_sp
  // ref: https://docs.flutter.dev/development/ui/layout
  // ref: https://zenn.dev/tomofyro/articles/a78fadeaa07efa

  // iPhone XS Max: width 414px, height 896px
  final double _width = 200;
  List imageList = [];

  /*
  String? _url =
      'https://1.bp.blogspot.com/-7uiCs6dI4a0/YEGQA-8JOrI/AAAAAAABddA/qPFt2E8vDfQwPQsAYLvk4lowkwP-GN7VQCNcBGAsYHQ/s896/buranko_girl_smile.png';
  void changeUrl() {
    setState(() {
      if (widget.isSelectedItem == 'aaa') {
        _url =
            'https://2.bp.blogspot.com/-tVKhDc9GKXU/ULxuAO4F9eI/AAAAAAAAHm8/XAl0zToQtVM/s1600/animal_taka.png';
      } else if (widget.isSelectedItem == 'bbb') {
        _url =
            'https://4.bp.blogspot.com/-mfqbB0DfCDo/UTbWrZXNlPI/AAAAAAAAOic/lkRI5dseik4/s1600/bird_hato.png';
      }
    });
  }
  */

  // void getImage() async {
  void getImage() {
    ImageProviders imageProviders = ImageProviders();
    imageProviders
        .getImages(widget.isSelectedItem)
        .then((value) => imageList = value);
    // imageList = imageProviders.getImages() as List;
    debugPrint('imageList:');
    debugPrint(imageList.toString());
  }

  List<Widget> _makeWidgets(List imageList) {
    return imageList
        .map((link) => SizedBox(
              width: _width,
              child: Image.network(link),
            ))
        .toList();
  }

  List<Widget> _makeWidgetsForLoop(List imageList) {
    List<Widget> tmpContentWidgets = [];
    for (int i = 0; i < imageList.length - 1; i++) {
      tmpContentWidgets
          .add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: _width,
          child: Image.network(imageList[i]),
        ),
        SizedBox(
          width: _width,
          child: Image.network(imageList[i + 1]),
        )
      ]));
    }
    return tmpContentWidgets;
  }

  void setImage() async {
    setState(() {
      getImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    // changeUrl();
    setImage();
    // var contentWidgets = _makeWidgetsForLoop(imageList);

    if (imageList.isNotEmpty) {
      return SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _makeWidgetsForLoop(imageList)));
    } else {
      return const Text('No Image');
    }

    /*
    return Column(children: [
      Column(children: [
        Text(widget.isSelectedItem),
        Text('$_url'),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: _width,
          child: Image.network('$_url'),
        ),
        SizedBox(
          width: _width,
          child: Image.network(
              'https://4.bp.blogspot.com/-mfqbB0DfCDo/UTbWrZXNlPI/AAAAAAAAOic/lkRI5dseik4/s1600/bird_hato.png'),
        ),
      ]),
    ]);
    */
  }
}
