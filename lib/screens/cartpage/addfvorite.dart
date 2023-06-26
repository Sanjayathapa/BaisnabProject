import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  bool isFavorite;

  Product({required this.id, required this.name, this.isFavorite = false});
}

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.product.name),
      trailing: IconButton(
        icon: Icon(
          widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: widget.product.isFavorite ? Colors.red : null,
        ),
        onPressed: () {
          setState(() {
            widget.product.isFavorite = !widget.product.isFavorite;
          });
        },
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  final List<Product> favoriteProducts;

  const FavoritePage({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return ListTile(
            title: Text(product.name),
          );
        },
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Product> products = [
    Product(id: 1, name: 'Product 1'),
    Product(id: 2, name: 'Product 2'),
    Product(id: 3, name: 'Product 3'),
    // Add more products as needed
  ];

  List<Product> getFavoriteProducts() {
    return products.where((product) => product.isFavorite).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My App'),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductItem(product: product);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final favoriteProducts = getFavoriteProducts();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritePage(favoriteProducts: favoriteProducts),
              ),
            );
          },
          child: const Icon(Icons.favorite),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
