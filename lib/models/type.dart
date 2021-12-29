class DressType {
  final String title;
  final String price;
  final int type;
  bool selected;

  DressType({this.title, this.selected = false, this.price, this.type});

  factory DressType.fromMap(Map<String, dynamic> json) => DressType(
        title: json["name"],
        type: json["type"] is int
            ? json["type"]
            : int.parse(
                json["type"],
              ),
        price: json["price"],
      );
}
