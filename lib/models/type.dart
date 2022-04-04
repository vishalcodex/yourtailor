class DressType {
  final String title;
  final String haveFabricPrice;
  final String needFabricPrice;
  final int type;
  bool selected;

  DressType(
      {this.title,
      this.selected = false,
      this.haveFabricPrice,
      this.needFabricPrice,
      this.type});

  factory DressType.fromMap(Map<String, dynamic> json) => DressType(
        title: json["name"],
        type: json["gender"] is int
            ? json["gender"]
            : int.parse(
                json["gender"],
              ),
        haveFabricPrice: json["have_fabric_price"],
        needFabricPrice: json["need_fabric_price"],
      );
}
