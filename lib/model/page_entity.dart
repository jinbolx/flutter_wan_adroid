final PageEntity pageEntity = PageEntity();

class PageEntity {
  int _pageNum = 0;
  int _pageSize = 20;

  bool isFirstPage() => _pageNum == 0;

  void nextPage() => _pageNum++;

  void prePage() => _pageNum++;

  void resetPage() => _pageNum = 0;

  int get currentPage => _pageNum;

  int get pageSize => _pageSize;
}
