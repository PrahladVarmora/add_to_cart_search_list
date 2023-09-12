class ModelProductList {
  List<ProductData>? productData;

  ModelProductList({this.productData});

  ModelProductList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      productData = <ProductData>[];
      json['data'].forEach((v) {
        productData!.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productData != null) {
      data['data'] = productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String? name;
  int? id;
  String? description;
  String? price;
  String? image;

  ProductData({this.name, this.id, this.description, this.price, this.image});

  ProductData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}
