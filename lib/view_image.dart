import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({
    super.key,
    required this.image,
  });

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sticky App'),
      ),
      body: PinchZoom(
        child: Image.memory(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
