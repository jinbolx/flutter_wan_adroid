import 'package:flutter/cupertino.dart';

class TapToTopModel with ChangeNotifier {
  ScrollController _scrollController;
  double _height;
  bool _showTopBtn = false;

  ScrollController get scrollController => _scrollController;

  bool get showTopBtn => _showTopBtn;

  TapToTopModel(this._scrollController, {double height = 200}) {
    _height = height;
  }

  init() {
    _scrollController.addListener(() {
      if(_scrollController.offset>_height&&!_showTopBtn){
        _showTopBtn=true;
        notifyListeners();
      }else if(_scrollController.offset<_height&&_showTopBtn){
        _showTopBtn=false;
        notifyListeners();
      }
    });
  }

  void scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeOutCubic);
  }
}
