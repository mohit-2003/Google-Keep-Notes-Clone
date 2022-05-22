class Notes {
  int? id;
  String title;
  String notes;
  var addedTime;
  var editedTime;
  bool isPinned;

  Notes(
      {this.id,
      required this.title,
      required this.notes,
      required this.addedTime,
      required this.editedTime,
      this.isPinned = false});

  // Convert a Notes into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'title': title,
      'notes': notes,
      'addedTime': addedTime,
      'editedTime': editedTime,
      'isPinned': isPinned ? 1 : 0,
    };
  }

  fromMap(Map<String, dynamic> map) {
    title = map["title"];
    notes = map["notes"];
    addedTime = map["addedTime"];
    editedTime = map["editedTime"];
    isPinned = map["isPinned"];
  }
}
