import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:flutter_application_1/exports.dart';


class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.isFavorite = false,
  });
}

class CartItem {
  final int productId;
  late final int quantity;

  CartItem({required this.productId, required this.quantity});
}

class Cart {
  final List<CartItem> items;

  Cart({required this.items});

  Future<double> get totalPrice async {
    double total = 0;
    for (CartItem item in items) {
      final product = await getProduct(item.productId);
      total += product.price! * item.quantity;
    }
    return total;
  }

  Future<Products> getProduct(int id) async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
  if (response.statusCode == 200) {
    return Products.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load product');
  }
}
}

class cs1 extends StatefulWidget {
  cs1({Key? key}) : super(key: key);

  @override
  _cs1State createState() => _cs1State();
}

class _cs1State extends State<cs1> {
  Cart? _cart;

  @override
  void initState() {
    super.initState();
    _getCart();
  }

  Future<void> _getCart() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/carts/1'));
    final json = jsonDecode(response.body);
    setState(() {
      _cart = Cart(
        items: List<CartItem>.from(json['products'].map((product) => CartItem(
              productId: product['productId'],
              quantity: product['quantity'],
            ))),
      );
    });
  }

  Future<void> _updateCart(Cart cart) async {
    final body = jsonEncode({'products': cart.items.map((item) => {'productId': item.productId, 'quantity': item.quantity}).toList()});
    final response = await http.patch(Uri.parse('https://fakestoreapi.com/carts/2'), body: body, headers: {'Content-Type': 'application/json'});
    final json = jsonDecode(response.body);
    setState(() {
      _cart = Cart(
        items: List<CartItem>.from(json['products'].map((product) => CartItem(
              productId: product['productId'],
              quantity: product['quantity'],
            ))),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: _cart == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cart!.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _cart!.items[index];
                final product = Product(id: item.productId, title: 'Product $index', price: index * 10.0, description: 'Product description', category: 'category', image: 'https://via.placeholder.com/150');
                return ListTile(
                  leading: Image.network(product.image),
                  title: Text(product.title),
                  subtitle: Text('${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (item.quantity > 1) {
                              item.quantity--;
                              _updateCart(_cart!);
                            } else {
                              _cart!.items.removeAt(index);
                            }
                          });
                        })]
                        ),
                        );
                        }),
                        bottomNavigationBar: Container(
                          height: 50,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FutureBuilder<double>(
                                  future: _cart!.totalPrice,
                                  builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                    if (snapshot.hasData) {
                                      return Text('Total price: ${snapshot.data}');
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text(
                                //     'Total:  ${_cart!.totalPrice}',
                                //     style: TextStyle(fontSize: 12),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: Text('Checkout'),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  
                    }