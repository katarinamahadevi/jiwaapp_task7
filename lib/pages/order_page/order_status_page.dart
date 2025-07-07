import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/order_page/button_status_payment.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_tnc_voucher.dart';

//DETAIL ORDER YANG MASIH BISA MELAKUKAN PEMBAYARAN

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({super.key});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  late OrderController orderController;
  int? orderId;

  @override
  void initState() {
    super.initState();
    orderController = Get.find<OrderController>();

    final arguments = Get.arguments as Map<String, dynamic>?;
    orderId = arguments?['orderId'];

    if (orderId != null) {
      orderController.fetchOrderDetail(orderId!);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getOrderStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'pending payment':
        return 'Menunggu Pembayaran';
      case 'completed':
        return 'Sudah Dibayar';
      case 'processing':
        return 'Sedang Diproses';
      case 'ready':
        return 'Siap Diambil';
      case 'completed':
        return 'Selesai';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status;
    }
  }

  String _getStatusDescription(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'pending payment':
        return 'Silahkan buka aplikasi E-Wallet untuk menyelesaikan pembayaran kamu';
      case 'completed':
        return 'Pembayaran berhasil, pesanan sedang diproses';
      case 'processing':
        return 'Pesanan sedang dalam proses pembuatan';
      case 'ready':
        return 'Pesanan sudah siap untuk diambil atau diantar';
      case 'completed':
        return 'Pesanan telah selesai';
      case 'cancelled':
        return 'Pesanan telah dibatalkan';
      default:
        return 'Status pesanan';
    }
  }

  String _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'pending payment':
        return 'assets/image/image_awaiting_payment.png';
      case 'completed':
        return 'assets/image/image_awaiting_payment.png';
      case 'processing':
        return 'assets/image/image_awaiting_payment.png';
      case 'ready':
        return 'assets/image/image_awaiting_payment.png';
      case 'completed':
        return 'assets/image/image_awaiting_payment.png';
      case 'cancelled':
        return 'assets/image/image_awaiting_payment.png';
      default:
        return 'assets/image/image_awaiting_payment.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppbarPrimary(title: 'Detail Status Pesanan'),
      body: Obx(() {
        if (orderController.isLoadingOrderDetail) {
          return const Center(child: CircularProgressIndicator());
        }

        final order = orderController.orderDetail;
        if (order == null) {
          return const Center(child: Text('Order tidak ditemukan'));
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getOrderStatusText(order.orderStatus),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _getStatusDescription(order.orderStatus),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text(
                                          'ORDER ID: ${order.orderCode ?? 'N/A'}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                text: order.orderCode ?? '',
                                              ),
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Order ID copied to clipboard',
                                                ),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.copy,
                                            size: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                width: 65,
                                height: 65,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFE65952),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(
                                    _getStatusIcon(order.orderStatus),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal: ${orderController.formatDateTime(order.createdAt)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomTNCVoucher(
                                    context: context,
                                    title:
                                        "Syarat dan Ketentuan ${order.orderType}",
                                    terms: [
                                      'Harap pastikan alamat dan nomor telepon yang dimasukkan sudah benar dan dapat dihubungi oleh driver.',
                                      'Customer harus mengambil produk yang dikembalikan oleh driver ke outlet jika tidak ada respons dari pembeli saat proses pengantaran. Outlet tidak berkewajiban mengantarkan kembali produk yang dikembalikan oleh driver.',
                                      'Pesanan yang tidak diambil oleh customer apabila driver mengembalikan produk akan dianggap terjual dan tidak dapat di-refund atau digantikan.',
                                      'Tunjukkan kode pick up kepada staf/barista saat mengambil pesanan Anda di outlet.',
                                    ],
                                  );
                                },
                                child: const Text(
                                  'Syarat Dan Ketentuan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color(0xFFE25C4B),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detail ${order.orderType}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFE65952),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    order.orderType.toLowerCase() == 'take away'
                                        ? 'assets/image/image_time.png'
                                        : 'assets/image/image_delivery.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.orderType.toLowerCase() ==
                                              'take away'
                                          ? 'Waktu Pick Up'
                                          : 'Estimasi Pengiriman',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: BaseColors.black,
                                      ),
                                    ),
                                    Text(
                                      orderController.formatDateTime(
                                        order.createdAt,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (order.orderType.toLowerCase() ==
                                            'delivery' &&
                                        order.courier != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          'Kurir: ${order.courier}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Daftar Pesanan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),

                          ...order.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.product.imageUrlText,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.quantity}x ${item.product?.name ?? 'Unknown Item'}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        if (item.note?.isNotEmpty == true) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            'Note: ${item.note}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Text(
                                      //   orderController.formatPrice(
                                      //     item.productId * item.quantity,
                                      //   ),
                                      //   style: const TextStyle(
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.black,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ringkasan Pembayaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Subtotal',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                orderController.formatPrice(
                                  order.subtotalPrice,
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          if (order.deliveryFee != null &&
                              order.deliveryFee! > 0) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Ongkos Kirim',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  orderController.formatPrice(
                                    order.deliveryFee!,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: 16),
                          Divider(color: Colors.grey[300]),
                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                orderController.formatPrice(
                                  order.subtotalPrice,
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
            ),
            if (order.orderStatus.toLowerCase().contains('pending'))
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ButtonStatusPayment(
                  timeoutSeconds: 270,
                  orderId: order.id,
                  onContinuePayment: () {
                    orderController.processPayment(order.id);
                  },
                  onCancelSuccess: () {
                    Get.offAllNamed('/orderpage');
                  },
                  showSnackbar: (message, {bool isError = false}) {
                    Get.snackbar(
                      isError ? 'Error' : 'Sukses',
                      message,
                      backgroundColor: isError ? Colors.red : Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  cancelPaymentFunction: (int orderId) async {
                    await orderController.cancelPayment(orderId);
                  },
                ),
              ),
          ],
        );
      }),
    );
  }
}
