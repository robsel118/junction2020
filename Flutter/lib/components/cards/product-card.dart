import 'package:flutter/material.dart';
import 'package:junction2020/models/product.dart';
import 'package:junction2020/views/product_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key key, @required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(color: Colors.white),
            FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.6,
              child: Container(
                color: Colors.grey[400],
              ),
            ),
            Center(
              child: Hero(
                child: Image.network(
                  "http://www.pngmart.com/files/12/Hand-Sanitizer-PNG-Transparent-Image.png",
                  fit: BoxFit.cover,
                ),
                tag: 'card-$product.item',
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductScreen(product: Product(item: "hand sanitzer")),
          ),
        );
      },
    );
  }
}
