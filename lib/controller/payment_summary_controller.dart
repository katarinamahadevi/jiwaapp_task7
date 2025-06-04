import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/payment_summary_model.dart';
import 'package:jiwaapp_task7/services/payment_summary_service.dart';

class PaymentSummaryController extends GetxController {
  final PaymentSummaryService _service = PaymentSummaryService();

  var paymentSummary = Rxn<PaymentSummaryModel>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Fetch summary untuk cart
  Future<void> fetchPaymentSummary() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await _service.fetchPaymentSummary();
      paymentSummary.value = PaymentSummaryModel.fromJson(data['summary']);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchPaymentSummaryByOrderId(int orderId) async {
  //   try {
  //     isLoading.value = true;
  //     errorMessage.value = '';

  //     final data = await _service.fetchPaymentSummaryByOrderId(orderId);
  //     paymentSummary.value = PaymentSummaryModel.fromJson(data['summary']);
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
