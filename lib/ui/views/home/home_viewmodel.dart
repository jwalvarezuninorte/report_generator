import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final QuillController _quillController = QuillController.basic();

  double _scale = 1;

  QuillController get quillController => _quillController;

  double get scale => _scale;

  void increaseScale() {
    _scale += 0.1;
    notifyListeners();
  }

  void decreaseScale() {
    _scale -= 0.1;
    notifyListeners();
  }

  double getAppBarHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1036) {
      return 60;
    }

    if (width > 580) {
      return 120;
    }

    return 180;
  }
}
