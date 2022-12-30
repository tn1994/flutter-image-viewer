import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final String isSelectedItem;

  const ImageViewer({
    Key? key,
    required this.isSelectedItem,
  }) : super(key: key);

  @override
  ImageViewerState createState() => ImageViewerState();
// State<ImageViewer> createState() => ImageViewerState();
}

class ImageViewerState extends State<ImageViewer> {
  //ref: https://teratail.com/questions/335484?link=qa_related_sp
  //ref: https://docs.flutter.dev/development/ui/layout

  double _width = 300;
  String? _url = 'https://1.bp.blogspot.com/-7uiCs6dI4a0/YEGQA-8JOrI/AAAAAAABddA/qPFt2E8vDfQwPQsAYLvk4lowkwP-GN7VQCNcBGAsYHQ/s896/buranko_girl_smile.png';

  void changeUrl() {
    setState(() {
      if (widget.isSelectedItem == 'aaa') {
        _url =
        'https://2.bp.blogspot.com/-tVKhDc9GKXU/ULxuAO4F9eI/AAAAAAAAHm8/XAl0zToQtVM/s1600/animal_taka.png';
      }
      else if (widget.isSelectedItem == 'bbb') {
        _url =
        'https://4.bp.blogspot.com/-mfqbB0DfCDo/UTbWrZXNlPI/AAAAAAAAOic/lkRI5dseik4/s1600/bird_hato.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    changeUrl();
    return Container(
        child: Column(
            children: [
              Column(
                  children: [
                    Text(widget.isSelectedItem),
                    Text('$_url'),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              ),

            ]
        )
    );
  }
}