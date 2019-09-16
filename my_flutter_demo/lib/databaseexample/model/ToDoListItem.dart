class ToDoListItem{
  final int id;
  final String item;
  final bool isDone;

  ToDoListItem({this.id, this.item, this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id' : id, 'item' : item, 'isDone' : isDone
    };
  }
}