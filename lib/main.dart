import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/providers/product_list_provider.dart';
import 'package:shopapp/routes/add_edit_product.dart';
import 'package:shopapp/routes/auth_screen.dart';
import 'package:shopapp/routes/cart_home.dart';
import 'package:shopapp/routes/manage_product.dart';
import 'package:shopapp/routes/order_home.dart';
import 'package:shopapp/routes/product_overview.dart';
import './routes/product_detail.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (ctx) => ProductList(),
          update: (ctx, authData, previousProductList) =>
              previousProductList..authData = authData,
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, auth, orders) => orders..token = auth.token,
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'Shop App',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.green[400],
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  headline1: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                  headline2: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
          ),
          home: auth.isAuth ? ProductOverview() : AuthScreen(),
          routes: {
            ProductDetail.routeName: (ctx) => ProductDetail(),
            CartHome.routeName: (ctx) => CartHome(),
            OrderHome.routeName: (ctx) => OrderHome(),
            ManageProduct.routeName: (ctx) => ManageProduct(),
            AddEditProduct.routeName: (ctx) => AddEditProduct(),
            ProductOverview.routeName: (ctx) => ProductOverview(),
          },
        ),
      ),
    );
  }
}
