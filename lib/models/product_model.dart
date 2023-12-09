class ProductModel {
  ProductModel(
      {required this.name,
      required this.priceInDollar,
      required this.imageURL,
      this.description = "No description available",
      this.fav = false,
      this.discount = 0.0});
  String name;
  double priceInDollar;
  String imageURL;
  String description;
  bool fav;
  double discount;
}
