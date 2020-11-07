import 'package:flutter/material.dart';
import 'package:junction2020/models/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key, @required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              GestureDetector(
                child: Icon(Icons.settings),
                onTap: () {
                  _onSettingsPressed(context);
                },
              )
            ],
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Hero(
              child: Image.network(
                "http://www.pngmart.com/files/12/Hand-Sanitizer-PNG-Transparent-Image.png",
                fit: BoxFit.cover,
              ),
              tag: 'card-0',
            )),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.amber),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.red),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.blue),
            ),
            
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.green),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.amber),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.red),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.blue),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.green),
            ),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(color: Colors.yellow),
            ),
          ]))
        ],
      ),
    );
  }

  void _onSettingsPressed(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30))),
            height: 180,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.compass_calibration),
                    title: Text('Retare scale'),
                    onTap: () {
                      print('retaring');
                    }),
                ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Set notification'),
                    onTap: () {
                      print('Setting notification');
                    }),
                ListTile(
                    leading: Icon(Icons.qr_code),
                    title: Text('Scan new item'),
                    onTap: () {
                      print('Scanning item');
                    }),
              ],
            ),
          );
        });
  }
}
