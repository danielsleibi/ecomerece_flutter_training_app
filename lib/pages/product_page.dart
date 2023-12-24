import 'package:ecommerce_task/models/cart_model.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _selectedColor = 0;
  int _selectedSize = 0;

  Widget buildColorCircle(double size, Color color, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = index;
        });
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Visibility(
          visible: index == _selectedColor,
          child: Center(
            child: Icon(Icons.check),
          ),
        ),
      ),
    );
  }

  Widget buildColorSelection(double size) {
    return Row(
      children: [
        buildColorCircle(size, Colors.red, 0),
        SizedBox(width: 10.0),
        buildColorCircle(size, Colors.black54, 1),
        SizedBox(width: 10.0),
        buildColorCircle(size, Colors.blue, 2),
      ],
    );
  }

  Widget buildSizeBox(double size, String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = index;
        });
      },
      child: Container(
        width: size / 1.3,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          shape: BoxShape.rectangle,
          color: index == _selectedSize ? Colors.grey : Colors.white,
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }

  Widget buildSizeSelection(double size) {
    return Row(
      children: [
        buildSizeBox(size, '13\"', 0),
        SizedBox(width: 10.0),
        buildSizeBox(size, '14\"', 1),
        SizedBox(width: 10.0),
        buildSizeBox(size, '15\"', 2),
        SizedBox(width: 10.0),
        buildSizeBox(size, '16\"', 3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    CartModel cart = CartModel.instance;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.productModel.images!.first),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          Positioned(
            top: 270,
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: 150,
              height: MediaQuery.of(context).size.height -
                  270 -
                  kToolbarHeight -
                  kBottomNavigationBarHeight -
                  60,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '\$${widget.productModel.price!}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Visibility(
                              visible: widget.productModel.discount != 0.0,
                              child: Text(
                                '\$${(widget.productModel.price! * widget.productModel.discount).toInt()}',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              )),
                          SizedBox(
                            width: 20.0,
                          ),
                          Visibility(
                              visible: widget.productModel.discount != 0.0,
                              child: Container(
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red)),
                                child: Text(
                                  '-${(widget.productModel.discount * 100).toInt()}% Off',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                          Expanded(
                            child: SizedBox(),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.productModel.fav =
                                    !widget.productModel.fav;
                              });
                            },
                            child: Image.asset(
                              'images/heart_icon.png',
                              width: 25, // Set width as needed
                              height: 25, // Set height as needed
                              color: widget.productModel.fav
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        widget.productModel.title ?? 'Failed to load',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Description',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        widget.productModel.description ?? 'Failed to load',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Color',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      buildColorSelection(50),
                      SizedBox(height: 20.0),
                      Text('Size'),
                      SizedBox(height: 10),
                      buildSizeSelection(50.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () {
              CartModel cart = CartModel.instance;
              bool inCart = cart.isInCart(widget.productModel);
              if(inCart) {
                setState(() {
                  cart.removeFromCart(widget.productModel);
                });

                return;
              }
              setState(() {
                cart.addToCart(widget.productModel);
              });

            },
            label: cart.isInCart(widget.productModel)
                ? Text('Remove from Cart')
                : Text('Add to cart'),
            icon: cart.isInCart(widget.productModel)
                ? Icon(Icons.remove_shopping_cart_outlined)
                : Icon(Icons.add_shopping_cart),
          ),
        ),
      ),
    );
  }
}
