import 'package:flutter/material.dart';

class ProductRecommendation extends StatelessWidget {
  const ProductRecommendation({Key key, @required this.url}) : super(key: key);

  final String url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              offset: Offset(1.0, 4.0),
              blurRadius: 12.0,
            ),
          ],
        ),
        child: Center(
            child: Image.network(
          url,
          fit: BoxFit.contain,
        )),
      ),
    );
  }
}
