class ProductModel {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  double discount = 0.0;
  bool fav = false;

  ProductModel(
      {this.id, this.title, this.price, this.description, this.images});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }
}
