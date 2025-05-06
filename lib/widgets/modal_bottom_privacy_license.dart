import 'package:flutter/material.dart';

void showModalBottomPrivacyLicense(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Terms of Service',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Notice',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Last updated on 12 October 2022',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      textAlign: TextAlign.justify,
                      'The protection of your personal data is of utmost importance to us. We are committed to protecting your personal data in compliance with the data protection laws applicable to you.\n\n'
                      'This privacy notice (the “Privacy Notice”) sets out the manner in which JIWA+ By Kopi Janji Jiwa collects, uses, processes and discloses your personal data. It may be supplemented by additional privacy statements, terms or notices provided to you from time to time. The JIWA+ By Kopi Janji Jiwa company that operates the relevant Service, as defined below, is the primary controller of the personal data that is provided to or collected by or for, the said Service.\n\n'
                      'This Privacy Notice applies to all the mobile applications, websites, products, features and other services globally (including our physical stores), owned or operated by JIWA+ By Kopi Janji Jiwa (each, a “Service” and collectively, the “Services”). By submitting any personal data to us and by using our Services, you consent to us collecting, using, processing and disclosing your personal data in accordance with the terms of this Privacy Notice.\n',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'What is "Personal Data"?\n',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      '“Personal Data” is any information which can be used to identify you or from which you are identifiable. This includes your name, your mobile number, email address, location, delivery address, your JIWA+ account profile photo, payment information and Service usage information insofar as you may be identified from such information.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
