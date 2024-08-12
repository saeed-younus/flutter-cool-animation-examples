import 'dart:ui' as ui;
import 'package:image/image.dart' as image;
import 'package:flutter/services.dart';

Future<image.Image> getUiImage(
    ByteData assetImageByteData, int height, int width) async {
  image.Image? baseSizeImage =
      image.decodeImage(assetImageByteData.buffer.asUint8List());

  image.Image resizeImage =
      image.copyResize(baseSizeImage!, height: height, width: width);
  // ui.Codec codec = await ui.instantiateImageCodec(image.encodeJpg(resizeImage));
  // ui.FrameInfo frameInfo = await codec.getNextFrame();
  // return frameInfo.image;
  return resizeImage;
}
