class CheckboxListItemModel {
  final item;
  bool selected;

  CheckboxListItemModel(this.item, {this.selected = false});
}

class CheckboxListModel {
  List<CheckboxListItemModel> list;

  CheckboxListModel(List newList) {
    list = newList.map((item) => CheckboxListItemModel(item)).toList();
  }

  List<int> getIdsSelected() => list
      .where((element) => element.selected)
      .map((checkboxItem) => checkboxItem.item.id)
      .toList()
      .cast<int>();
}
