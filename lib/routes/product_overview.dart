import 'package:flutter/material.dart';

import '../widgets/grid_item_builder.dart';

class ProductOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
      ),
      body: GridItemBuilder(),
    );
  }
}
