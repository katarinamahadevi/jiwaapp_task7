import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/widgets/home_page/order_option.dart';

class OrderOptions extends StatelessWidget {
  const OrderOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Expanded(
          child: OrderOptionButton(
            icon: Icons.directions_walk,
            label: "TAKE AWAY",
            marginRight: 8,
          ),
        ),
        Expanded(
          child: OrderOptionButton(
            icon: Icons.delivery_dining,
            label: "DELIVERY",
            marginLeft: 8,
          ),
        ),
      ],
    );
  }
}