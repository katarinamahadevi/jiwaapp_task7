import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/login_controller.dart';
import '../../theme/color.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildCarouselSlider(context),
          _buildBottomContainer(context),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.3,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        autoPlayInterval: Duration(seconds: 4),
      ),
      items:
          controller.bannerImages.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            );
          }).toList(),
    );
  }

  Widget _buildBottomContainer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masuk',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Silahkan masuk dengan alamat email yang terdaftar. Pastikan email kamu aktif.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 24),
            _buildEmailField(),
            SizedBox(height: 20),
            _buildTermsAndConditions(context),
            SizedBox(height: 24),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Alamat Email',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: controller.toggleCheckbox,
          child: Obx(
            () => Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color:
                    controller.isChecked.value
                        ? BaseColors.primary
                        : Colors.transparent,
                border: Border.all(color: BaseColors.greyText),
                borderRadius: BorderRadius.circular(4),
              ),
              child:
                  controller.isChecked.value
                      ? Icon(Icons.check, size: 20, color: Colors.white)
                      : null,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
              children: [
                const TextSpan(text: 'Dengan masuk kamu menyetujui '),
                TextSpan(
                  text: 'Syarat & Ketentuan dan kebijakan Privasi',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' Jiwa+'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: () async {
        await controller.handleLogin();
      },
      child: Obx(
        () => Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color:
                controller.isButtonEnabled.value
                    ? BaseColors.primary
                    : BaseColors.border,
            borderRadius: BorderRadius.circular(32),
          ),
          alignment: Alignment.center,
          child:
              controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ),
    );
  }
}
