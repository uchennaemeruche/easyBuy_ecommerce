class Category {
  String id, name, iconPath;
  bool isReadOnly;

  Category({this.id, this.name, this.iconPath, this.isReadOnly = true});

  Map<String, dynamic> toMap() {
    return {'name': name, 'id': id};
  }

  static Category fromMap(Map<String, dynamic> map, docId) {
    // print("MAP: $map ID: $docId");
    if (map == null) return null;
    return Category(
      name: map['name'] ?? "",
      id: docId,
    );
  }
}

List<Category> categories = [
  Category(
      id: "1", name: "Flash Deal", iconPath: "assets/icons/Flash Icon.svg"),
  Category(id: "2", name: "Bill", iconPath: "assets/icons/Bill Icon.svg"),
  Category(id: "3", name: "Game", iconPath: "assets/icons/Game Icon.svg"),
  Category(id: "4", name: "Daily Gift", iconPath: "assets/icons/Gift Icon.svg"),
  Category(id: "5", name: "More", iconPath: "assets/icons/Discover.svg"),
];
