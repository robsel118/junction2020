import 'package:flutter/material.dart';
import 'package:junction2020/models/product.dart';
import 'package:junction2020/views/product_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key key, @required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 4.0),
                  blurRadius: 4.0,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),

            FractionallySizedBox(
              widthFactor: 1,
              heightFactor: product.remainingPercent / 100,
              child: Container(
                  decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
              )),
            ),
            Center(
              child: Hero(
                child: FractionallySizedBox(
                  widthFactor: 0.66,
                  heightFactor: 0.66,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                tag: 'card-${product.name}',
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: _getIndicatorColor(product.remainingPercent),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topRight: Radius.circular(12))),
                height: 30,
                width: 100,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                  child: Center(
                    child: Text(
                      '${product.remainingPercent}% left',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
                key: ValueKey(product.remainingPercent), product: product),
          ),
        );
      },
    );
  }

  Color _getIndicatorColor(int percentRemaining) {
    if (percentRemaining < 20) {
      return Colors.redAccent;
    } else if (percentRemaining < 50) {
      return Colors.orangeAccent;
    } else {
      return Colors.greenAccent;
    }
  }

}
