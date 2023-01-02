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

Widget gestureImageWidget(BuildContext context, String imageUrl, double width) {
  return SizedBox(
      width: width,
      child: GestureDetector(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        onTap: () {
          showGeneralDialog(
            transitionDuration: Duration(milliseconds: 1000),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {
              return DefaultTextStyle(
                style: Theme.of(context).primaryTextTheme.bodyText1!,
                child: Center(
                  child: Container(
                    // height: 500,
                    width: double.infinity, // 500,
                    child: SingleChildScrollView(
                      child: InteractiveViewer(
                        minScale: 0.1,
                        maxScale: 5,
                        child: Stack(children: <Widget>[
                          Container(
                            child: Image.network(imageUrl),
                          ),
                          Material(
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ));
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
      setState(() {
        imageList = response;
      });
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

  List<Widget> _makeWidgetsForLoop(BuildContext context, List imageList) {
    List<Widget> tmpContentWidgets = [];
    for (int i = 0; i < imageList.length - 1; i++) {
      tmpContentWidgets
          .add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        gestureImageWidget(context, imageList[i], _width),
        gestureImageWidget(context, imageList[i + 1], _width),
      ]));
    }
    return tmpContentWidgets;
  }

  @override
  void initState() {
    super.initState();
    getImage(widget.isSelectedItem);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('isSelectedItem');
    debugPrint(isSelectedItem);
    debugPrint('widget.isSelectedItem');
    debugPrint(widget.isSelectedItem);

    return SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _makeWidgetsForLoop(context, imageList)));
  }
}
