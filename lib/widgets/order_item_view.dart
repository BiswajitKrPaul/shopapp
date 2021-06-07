import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart';

class OrderItemView extends StatefulWidget {
  final OrderItem orderData;
  final int index;

  OrderItemView({this.orderData, this.index});

  @override
  _OrderItemViewState createState() => _OrderItemViewState();
}

class _OrderItemViewState extends State<OrderItemView> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ExpansionTile(
            leading: CircleAvatar(
              child: Text('# ${(widget.index + 1)}'),
            ),
            title: Text(
              DateFormat('dd/MM/yyyy hh:mm')
                  .format(widget.orderData.orderDateTime),
            ),
            subtitle: Text(
                'Total Amount : \$${widget.orderData.amount.toStringAsFixed(2)}'),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (val) {
              setState(() {
                isExpanded = val;
              });
            },
            children: [
              Container(
                height: 180,
                child: ListView(
                  children: [
                    ...widget.orderData.products.map((e) {
                      return ListTile(
                        title: Text(e.title),
                        subtitle: Text('Price : ${e.price}'),
                        trailing: Text('Quantity : ${e.quantity}'),
                      );
                    }).toList(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
