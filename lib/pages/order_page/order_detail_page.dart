import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/model/address_model.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/order_page/modal_bottom_order_repeat.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_tnc_voucher.dart';

class OrderDetailPage extends StatefulWidget {
  final int orderId;

  const OrderDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final OrderController orderController = Get.find<OrderController>();
  final Rx<AddressModel?> _selectedAddress = Rx<AddressModel?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderController.fetchOrderDetail(widget.orderId);
    });
  }

  String _getOrderStatusMessage(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Terima kasih #temansejiwa!';
      case 'cancelled':
        return 'Pesanan Dibatalkan';
      case 'failed':
        return 'Pembayaran Gagal';
      case 'pending':
        return 'Menunggu Pembayaran';
      case 'processing':
        return 'Pesanan Sedang Diproses';
      case 'confirmed':
        return 'Pesanan Dikonfirmasi';
      case 'preparing':
        return 'Pesanan Sedang Disiapkan';
      case 'ready':
        return 'Pesanan Siap';
      case 'on delivery':
        return 'Pesanan Dalam Perjalanan';
      default:
        return 'Status Pesanan';
    }
  }

  String _getOrderStatusSubMessage(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Selamat menikmati dan terus gunakan JIWA+ ya!';
      case 'cancelled':
        return 'Pesanan Anda telah dibatalkan';
      case 'failed':
        return 'Silakan coba lagi atau hubungi customer service';
      case 'pending':
        return 'Silakan lakukan pembayaran untuk melanjutkan pesanan';
      case 'processing':
        return 'Pesanan Anda sedang diverifikasi';
      case 'confirmed':
        return 'Pesanan Anda telah dikonfirmasi dan akan segera disiapkan';
      case 'preparing':
        return 'Chef sedang menyiapkan pesanan Anda dengan penuh cinta';
      case 'ready':
        return 'Pesanan Anda sudah siap untuk diambil/diantar';
      case 'on delivery':
        return 'Driver sedang dalam perjalanan menuju lokasi Anda';
      default:
        return 'Pesanan Anda sedang diproses';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppbarPrimary(title: 'Detail Status Pesanan'),
      body: Obx(() {
        if (orderController.isLoadingOrderDetail) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFFE25C4B)),
          );
        }

        final order = orderController.orderDetail;
        if (order == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  'Detail pesanan tidak ditemukan',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE25C4B),
                  ),
                  child: Text('Kembali', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
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
                                      _getOrderStatusMessage(order.orderStatus),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _getOrderStatusSubMessage(
                                        order.orderStatus,
                                      ),
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
                                          style: TextStyle(
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
                                              SnackBar(
                                                content: Text(
                                                  'Order ID copied to clipboard',
                                                ),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.copy, size: 10),
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
                                    'assets/image/image_order.png',
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
                                style: TextStyle(
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
                                    terms:
                                        order.orderType.toLowerCase() ==
                                                'delivery'
                                            ? [
                                              'Harap pastikan alamat dan nomor telepon yang dimasukkan sudah benar dan dapat dihubungi oleh driver.',
                                              'Customer harus mengambil produk yang dikembalikan oleh driver ke outlet jika tidak ada respons dari pembeli saat proses pengantaran.',
                                              'Outlet tidak berkewajiban mengantarkan kembali produk yang dikembalikan oleh driver.',
                                              'Pesanan yang tidak diambil oleh customer apabila driver mengembalikan produk akan dianggap terjual dan tidak dapat di-refund atau digantikan.',
                                            ]
                                            : [
                                              'Tunjukkan kode pick up kepada staf/barista saat mengambil pesanan Anda di outlet.',
                                              'Pesanan dapat diambil sesuai dengan waktu yang telah ditentukan.',
                                              'Jika pesanan tidak diambil dalam waktu yang ditentukan, outlet berhak untuk membatalkan pesanan.',
                                            ],
                                  );
                                },
                                child: Text(
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
                    if (order.orderType.toLowerCase() == 'delivery' &&
                        order.courier != null &&
                        order.courier != 'none')
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Informasi Kurir',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF0BA90A),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child:
                                          order.courier?.toLowerCase() ==
                                                  'gosend'
                                              ? Image.asset(
                                                'assets/logo/logo_gosend.jpeg',
                                                fit: BoxFit.contain,
                                              )
                                              : Icon(
                                                Icons.delivery_dining,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      order.courier ?? 'Kurir',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 24),
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
                            style: TextStyle(
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
                                    order.orderType.toLowerCase() == 'delivery'
                                        ? 'assets/image/image_location.png'
                                        : 'assets/image/image_take_away.png',
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
                                              'delivery'
                                          ? 'Alamat Pengiriman'
                                          : 'Lokasi Pickup',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: BaseColors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (order.orderType.toLowerCase() ==
                                        'delivery')
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _selectedAddress.value?.address ??
                                                'Alamat belum dipilih',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),

                                          const SizedBox(height: 4),
                                          Text(
                                            'Alamat pengiriman akan ditampilkan sesuai data yang tersimpan',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'JIWA Coffee Outlet',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Silakan ambil pesanan Anda di outlet terdekat',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
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
                          ...order.items.map(
                            (item) => Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    item.product.imageUrlText,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.quantity}x ${item.product?.name ?? 'Item'}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        if (item.note != null &&
                                            item.note!.isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            'Catatan: ${item.note}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                        const SizedBox(height: 8),
                                        Text(
                                          orderController.formatPrice(
                                            item.productId,
                                          ),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                              Text(
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
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          if (order.orderType.toLowerCase() == 'delivery') ...[
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery Fee',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  orderController.formatPrice(
                                    order.deliveryFee ?? 0,
                                  ),
                                  style: TextStyle(
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
                              Text(
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
                                style: TextStyle(
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
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: BaseColors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Bantuan',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomOrderRepeat(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE25C4B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Pesan Ulang',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
