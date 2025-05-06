import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/delivery_page.dart';
import 'package:jiwaapp_task7/pages/menu_page.dart';
import 'package:jiwaapp_task7/widgets/home_page/order_option.dart';

//OPSI TAKEAWAY ATAU DELIVERY

class OrderOptions extends StatelessWidget {
  const OrderOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: OrderOptionButton(
            imageAsset: 'assets/image/image_take_away.png',
            label: "TAKE AWAY",
            marginRight: 8,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
          ),
        ),
        Expanded(
          child: OrderOptionButton(
            imageAsset: 'assets/image/image_delivery.png',
            label: "DELIVERY",
            marginLeft: 8,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeliveryPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}
