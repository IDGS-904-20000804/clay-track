class Product {
  List<int> colorIds;
  List<String> colorDescriptions;
  List<String> colorHexadecimals;
  int idCatRecipe;
  String name;
  int quantityStock;
  double price;
  bool status;
  int fkCatImage;
  String? filePath;
  int fkCatSize;
  String description;
  String abbreviation;

  Product({
    required this.colorIds,
    required this.colorDescriptions,
    required this.colorHexadecimals,
    required this.idCatRecipe,
    required this.name,
    required this.quantityStock,
    required this.price,
    required this.status,
    required this.fkCatImage,
    this.filePath,
    required this.fkCatSize,
    required this.description,
    required this.abbreviation,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        colorIds: List<int>.from(json["colorIds"]),
        colorDescriptions:
            List<String>.from(json["colorDescriptions"].map((x) => x)),
        colorHexadecimals:
            List<String>.from(json["colorHexadecimals"].map((x) => x)),
        idCatRecipe: json["idCatRecipe"],
        name: json["name"],
        quantityStock: json["quantityStock"],
        price: json["price"].toDouble(),
        status: json["status"],
        fkCatImage: json["fkCatImage"],
        filePath: json["filePath"],
        fkCatSize: json["fkCatSize"],
        description: json["description"],
        abbreviation: json["abbreviation"],
      );

  Map<String, dynamic> toJson() => {
        "colorIds": List<dynamic>.from(colorIds),
        "colorDescriptions":
            List<dynamic>.from(colorDescriptions.map((x) => x)),
        "colorHexadecimals":
            List<dynamic>.from(colorHexadecimals.map((x) => x)),
        "idCatRecipe": idCatRecipe,
        "name": name,
        "quantityStock": quantityStock,
        "price": price,
        "status": status,
        "fkCatImage": fkCatImage,
        "filePath": filePath,
        "fkCatSize": fkCatSize,
        "description": description,
        "abbreviation": abbreviation,
      };
}

// class Product {
//   bool available;
//   String name;
//   String? picture;
//   double price;
//   String? id;

//   Product(
//       {required this.available,
//       required this.name,
//       this.picture,
//       required this.price,
//       this.id});

//   factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//         available: json["available"],
//         name: json["name"],
//         picture: json["picture"],
//         price: json["price"].toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "available": available,
//         "name": name,
//         "picture": picture,
//         "price": price,
//       };

//   Product copy() => Product(
//         available: available,
//         name: name,
//         picture: picture,
//         price: price,
//         id: id,
//       );
// }
