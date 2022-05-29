// Abstract class for identifying search actions
abstract class SearchAction {}

class UpdateViewIndexAction {
  final int index;

  UpdateViewIndexAction(this.index);
}

class AppendSearchListAction implements SearchAction {
  final String keyword;

  AppendSearchListAction(this.keyword);
}

class RemoveSearchListAction implements SearchAction {
  final String keyword;

  RemoveSearchListAction(this.keyword);
}

class SetSearchListAction implements SearchAction {
  final List<String> history;

  SetSearchListAction(this.history);
}
