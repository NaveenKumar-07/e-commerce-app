import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  Future<void> _getProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    final json = jsonDecode(response.body);
    setState(() {
      _products = List<Product>.from(json.map((product) => Product(
            id: product['id'],
            title: product['title'],
            price: product['price'].toDouble(),
            description: product['description'],
            category: product['category'],
            image: product['image'],
          )));
    });
  }

  void _toggleFavorite(Product product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });
  }

  Future<void> _toggleFavoriteAPI(Product product) async {
    final response = await http.post(Uri.parse('https://fakestoreapi.com/products/${product.id}'),
        body: {'title': product.title, 'price': product.price.toString(), 'description': product.description, 'category': product.category, 'image': product.image, 'isFavorite': product.isFavorite.toString()});
    final json = jsonDecode(response.body);
    setState(() {
      product.isFavorite = json['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = _products[index];
          return ListTile(
            leading: Image.network(product.image),
            title: Text(product.title),
            subtitle: Text('${product.price}'),
            trailing: IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () => _toggleFavoriteAPI(product),
            ),
          );
        },
      ),
    );
  }
}
