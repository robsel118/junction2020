import 'package:flutter/material.dart';
import 'package:junction2020/models/product.dart';
import 'package:junction2020/components/cards/product-recommendation.dart';
import 'package:junction2020/components/cards/product-status.dart';
import 'package:junction2020/constants.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key, @required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                actions: [
                  GestureDetector(
                    child: Icon(Icons.settings),
                    onTap: () {
                      _onSettingsPressed(context);
                    },
                  )
                ],
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Hero(
                    child: Image.network(
                      "http://www.pngmart.com/files/12/Hand-Sanitizer-PNG-Transparent-Image.png",
                      fit: BoxFit.contain,
                    ),
                    tag: 'card-Hand sanitizer',
                  ),
                )),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hand Sanitizer', style: TextStyle(fontSize: 26)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('East Entrance', style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProductStatus(
                            title: "Quantity",
                            subtitle: 'Remaining',
                            value: '50%',
                          ),
                          ProductStatus(
                            title: "Uses",
                            subtitle: 'Remaining',
                            value: '~100',
                          ),
                          ProductStatus(
                            title: "Days",
                            subtitle: 'Remaining',
                            value: '~60',
                          ),
                          ProductStatus(
                            title: "Price",
                            subtitle: 'per ues',
                            value: '.25€',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text('Details', style: TextStyle(fontSize: 26)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Doppio, single shot aromatic cortado eu, galão half and half to go frappuccino instant. Cup, cappuccino single origin coffee, cup doppio cultivar sit redeye. ',
                          style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Sustainable alternatives',
                        style: TextStyle(fontSize: 26),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  child: PageView.builder(
                    itemCount: 4,
                    controller:
                        PageController(initialPage: 0, viewportFraction: 0.5),
                    itemBuilder: (context, index) {
                      return ProductRecommendation(
                          url:
                              "http://www.pngmart.com/files/12/Hand-Sanitizer-PNG-Transparent-Image.png");
                    },
                  ),
                ),
              ],
            ),
          )),
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
