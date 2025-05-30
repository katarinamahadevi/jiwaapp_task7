import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/add_to_cart_page/delivery_section.dart';
import 'package:jiwaapp_task7/widgets/add_to_cart_page/header_section.dart';
import 'package:jiwaapp_task7/widgets/add_to_cart_page/order_list.dart';
import 'package:jiwaapp_task7/widgets/add_to_cart_page/payment_summary.dart';
import 'package:jiwaapp_task7/widgets/add_to_cart_page/time_section.dart';
import 'package:jiwaapp_task7/widgets/button_payment.dart';
import 'package:jiwaapp_task7/widgets/button_payment_confirmation.dart';

class AddToCartPage extends StatelessWidget {
  AddToCartPage({super.key});
  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[50],
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                elevation: 0,
                leadingWidth: 40,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () => controller.goBack(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                title: const Text(
                  'Detail Pesanan',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: BaseColors.border),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          AnimatedAlign(
                            alignment:
                                controller.isTakeAwaySelected
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 32,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE15B4C),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap:
                                      () =>
                                          controller.toggleDeliveryOption(true),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Take Away',
                                          style: TextStyle(
                                            color:
                                                controller.isTakeAwaySelected
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.directions_walk_outlined,
                                          color:
                                              controller.isTakeAwaySelected
                                                  ? Colors.white
                                                  : Colors.black54,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap:
                                      () => controller.toggleDeliveryOption(
                                        false,
                                      ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivery',
                                          style: TextStyle(
                                            color:
                                                !controller.isTakeAwaySelected
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.delivery_dining,
                                          color:
                                              !controller.isTakeAwaySelected
                                                  ? Colors.white
                                                  : BaseColors.secondary,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(bottom: 200),
                children: [
                  buildHeaderSection(),
                  if (!controller.isTakeAwaySelected) buildDeliverySection(),
                  if (controller.isTakeAwaySelected) buildTimeSection(),
                  buildOrderListSection(),
                  // buildAdditionalItem(),
                  buildPaymentSummarySection(controller.currentOrderId.value),

                  // buildPromoSection(),
                  const SizedBox(height: 100),
                ],
              ),
              _buildBottomPaymentButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPaymentButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child:
          controller.hasSelectedPayment
              ? ButtonPaymentConfirmation(
                onPressed: () => controller.showCheckOrderModal(Get.context!),
                paymentMethod: controller.selectedPaymentMethod,
                // amount: controller.totalPaymentFormatted,
                paymentLogoPath: controller.selectedPaymentLogoPath,
              )
              : ButtonPayment(
                onPressed: () => controller.navigateToPaymentMethod(),
              ),
    );
  }
}
