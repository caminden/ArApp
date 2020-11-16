import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class AugImageMap{
  Map<String, ArCoreAugmentedImage> augmentedImagesMap;
  Map<String, Uint8List> bytesMap = Map();
}