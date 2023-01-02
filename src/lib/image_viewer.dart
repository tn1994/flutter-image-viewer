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
  String isSelectedItem = '';

  Future<void> getImage(String boardId) async {
    try {
      ImageProviders imageProviders = ImageProviders();
      // imageProviders
      //     .getImages(widget.isSelectedItem)
      //     .then((value) => imageList = value);
      var response = await imageProviders.getImages(boardId);
      // imageList = imageProviders.getImages() as List;
      setState(() {
        imageList = response;
      });
      // debugPrint('imageList:');
      // debugPrint(imageList.toString());
    } catch (_) {
      debugPrint('getImage: error');
    }
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

  // void setImage() {
  //   setState(() {
  //     isSelectedItem = widget.isSelectedItem;
  //     debugPrint(isSelectedItem);
  //     getImage();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getImage(widget.isSelectedItem);
    // isSelectedItem = widget.isSelectedItem;
  }

  @override
  Widget build(BuildContext context) {
    // changeUrl();
    debugPrint('isSelectedItem');
    debugPrint(isSelectedItem);
    debugPrint('widget.isSelectedItem');
    debugPrint(widget.isSelectedItem);
    // getImage();

    return SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _makeWidgetsForLoop(imageList)));

    var contentWidgets = _makeWidgetsForLoop(imageList);
    if (imageList.isNotEmpty) {
      return SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: contentWidgets));
    } else {
      return const Text('No Image');
    }
  }
}
