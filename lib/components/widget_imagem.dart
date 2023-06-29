import 'package:flutter/material.dart';

class WidgetImage extends StatefulWidget {
  final String url;
  final double width;
  final double height;

  const WidgetImage({
    Key? key,
    required this.url,
    this.width = 190,
    this.height = 130,
  }) : super(key: key);

  @override
  WidgetImageState createState() => WidgetImageState();
}

class WidgetImageState extends State<WidgetImage> {
  bool _isValid = false;
  bool _isMounted = false;

  @override
  Widget build(BuildContext context) {
    return _isValid
        ? Image.network(
            widget.url,
            width: widget.width,
            height: widget.height,
          )
        : Container(
            width: widget.width,
            height: widget.height,
            color: Colors.grey,
          );
  }

  @override
  void initState() {
    super.initState();
    _isMounted = true;

    Image.network(widget.url).image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, _) {
              if (_isMounted) {
                setState(() {
                  _isValid = true;
                });
              }
            },
            onError: (_, __) {
              if (_isMounted) {
                setState(() {
                  _isValid = false;
                });
              }
            },
          ),
        );
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }
}
