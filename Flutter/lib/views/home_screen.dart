import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:junction2020/constants.dart';
import 'package:junction2020/models/product.dart';
import 'package:junction2020/components/cards/product-card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();

  var productList = [];

  void getData() {
    databaseReference.child('scales').onValue.listen((event) {
      var snapshot =
          new Map<String, dynamic>.from(event.snapshot.value).values.toList();
      print(snapshot);
      setState(() {
        productList = snapshot ?? [];
      });
      // print(Product.fromJson(snapshot[0]));
      // print(
      //     new Map<String, dynamic>.from(event.snapshot.value).values.toList());
      // print(new Map<String, dynamic>.from(
      //     new Map<String, dynamic>.from(event.snapshot.value)
      //         .values
      //         .toList()[0])['current_item']);
    });
    // databaseReference.child('scales').once().then((DataSnapshot snapshot) {
    //   print(snapshot.value);
    // });
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
            padding: const EdgeInsets.all(30.0),
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
                      border: OutlineInputBorder(),
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
      itemCount: productList.length,
      itemBuilder: (BuildContext context, int index) => ProductCard(
        product: Product.fromJson(productList[index]),
      ),
      staggeredTileBuilder: (int index) {
        return StaggeredTile.count(3, index.isEven ? 4 : 3);
      },
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    );
    // return FutureBuilder(
    //   future: databaseReference.child('scales').once(),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasData) {
    //       return StaggeredGridView.countBuilder(
    //         primary: false,
    //         shrinkWrap: true,
    //         crossAxisCount: 6,
    //         itemCount: snapshot.data.value.length,
    //         itemBuilder: (BuildContext context, int index) =>
    //             ProductCard(index: index),
    //         staggeredTileBuilder: (int index) {
    //           return StaggeredTile.count(3, index.isEven ? 4 : 3);
    //         },
    //         mainAxisSpacing: 10.0,
    //         crossAxisSpacing: 10.0,
    //       );
    //     }
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }
}
