import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:junction2020/constants.dart';
import 'package:junction2020/models/product.dart';
import 'package:junction2020/components/cards/product-card.dart';
import 'package:junction2020/locator.dart';
import 'package:junction2020/services/push-notification-sevices.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  List<Product> productList = [];
  StreamSubscription<Event> _productsSubscription;

  void getData() {
    _productsSubscription =
        databaseReference.child('scales').onValue.listen((event) {
      var snapshot = new Map<String, dynamic>.from(event.snapshot.value)
          .entries
          .map((e) => Product.fromJson(e.key, e.value))
          .toList();

      setState(() {
        productList = snapshot ?? [];
      });
      print(productList);
    });
  }

  @override
  void initState() {
    super.initState();
    handleStartupLogic();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _productsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {getData()},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.menu),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    CircleAvatar(
                      child: Text('RS'),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'How is my shelf',
                  style: TextStyle(fontSize: 26),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search)),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildStaggeredGrid(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStaggeredGrid(BuildContext context) {
    // return Text('teats');
    return StaggeredGridView.countBuilder(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 6,
      itemCount: productList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return index == productList.length
            ? DottedBorder(
                dashPattern: [20, 20],
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                color: Colors.grey[500],
                strokeWidth: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Center(
                    child: Text('Add'),
                  ),
                ),
              )
            : ProductCard(product: productList[index]);
      },
      staggeredTileBuilder: (int index) {
        return StaggeredTile.count(3, index.isEven ? 4 : 3);
      },
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
    );
  }

  void handleStartupLogic() async {
    await _pushNotificationService.initialise();
  }
}
