import 'package:flutter/material.dart';

class ProductStatus extends StatelessWidget {
  const ProductStatus(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.value})
      : super(key: key);

  final String title;
  final String subtitle;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      width: MediaQuery.of(context).size.width * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Text(subtitle),
            SizedBox(
              height: 10,
            ),
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
