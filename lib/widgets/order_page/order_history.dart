import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/order_detail_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_order_repeat.dart';

//ORDER YANG SUDAH MELAKUKAN PEMBAYARAN/BATAL/POKOKNYA HISTORI TRANSAKSI

class OrderHistoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Delivery',
          deliveryIconAsset: 'assets/image/image_take_away.png',
          price: 'Rp41.500',
          orderId: 'J+202512617405493000001',
          dateTime: '26 Feb 2025 | 12:55',
          promo: 'Buy 1 Get 1 Free Minuman',
          address:
              'Ordo apps - Taman Jemursari Selatan 1, Jemur Wonosari, Surabaya, Ja...',
          itemCount: '1 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 80),
      ],
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final String orderStatus;
  final String deliveryMethod;
  final String deliveryIconAsset;
  final String price;
  final String orderId;
  final String dateTime;
  final String promo;
  final String address;
  final String itemCount;

  const OrderHistoryCard({
    required this.orderStatus,
    required this.deliveryMethod,
    required this.deliveryIconAsset,
    required this.price,
    required this.orderId,
    required this.dateTime,
    required this.promo,
    required this.address,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFDDE1E4)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFF46234C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              orderStatus,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE65952),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          deliveryIconAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      deliveryMethod,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  price,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),

          Divider(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Order ID: ',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          orderId,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.copy, size: 14),
                    ],
                  ),
                ),
                Text(dateTime, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemCount,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          if (promo.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                promo,
                style: TextStyle(color: Colors.grey, fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
            ),

          if (address.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: BaseColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.flag, size: 14, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showModalBottomOrderRepeat(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  ),
                  child: Text(
                    'Pesan Ulang',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderDetailPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  child: Text(
                    'Detail Pesanan',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
