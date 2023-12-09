import 'package:ecommerce_task/models/product_model.dart';

class CartModel {
  // Private constructor
  CartModel._() {
    _cartItems = [];
    _cartItemsQuantity = {};
  }

  // Static instance of the class
  static final CartModel _instance = CartModel._();

  // Getter to access the instance
  static CartModel get instance => _instance;

  late List<ProductModel> _cartItems;
  late Map<ProductModel, int> _cartItemsQuantity;

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    _cartItemsQuantity[product] = 1;
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    _cartItemsQuantity.remove(product);
  }

  bool isInCart(ProductModel product) {
    return _cartItems.contains(product);
  }

  void clearCart() {
    _cartItems.clear();
    _cartItemsQuantity.clear();
  }

  List<ProductModel> getCartItems() {
    return _cartItems;
  }

  int getQuantityFor(ProductModel product) {
    return _cartItemsQuantity[product] ?? 0;
  }


  void addOneMoreFor(ProductModel product) {
    _cartItemsQuantity[product] = (_cartItemsQuantity[product] ?? 0) + 1;
  }

  void removeOneLessFor(ProductModel product) {
    int current = _cartItemsQuantity[product] ?? 0;
    if(current - 1 < 1){
      return;
    }
    _cartItemsQuantity[product] = current - 1;
  }
}
