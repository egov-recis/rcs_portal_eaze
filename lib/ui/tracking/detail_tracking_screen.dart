import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:rcs_portal_eaze/common/text.dart';
import 'package:rcs_portal_eaze/model/response/response_payment_history.dart';
import 'package:rcs_portal_eaze/ui/tracking/tracking_controller.dart';
import 'package:rcs_portal_eaze/utils/widgets.dart';

class DetailTrackingScreen extends StatelessWidget {
  final TrackingController controller;
  const DetailTrackingScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            header(),
            Expanded(
              child: SingleChildScrollView(
                child: list(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
        bottom: 40,
      ),
      itemBuilder: (context, index) => Column(
        children: [
          ItemTransactionWidget(
            paymentHistory: PaymentHistory.fromJson(
              controller.listTransaction[index].toJson(),
            ),
          ),
          index == (controller.listTransaction.length - 1)
              ? const SizedBox()
              : const Divider(),
        ],
      ),
      itemCount: controller.listTransaction.length,
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height,
        bottom: 24,
        left: 16,
        right: 16,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.back(result: true);
                    },
                    child: Container(
                      color: Colors.white,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Strings.primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Tracking',
                    style: textCustom(size: 14, weight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade400,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        '?',
                        style: textCaption(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Kode Transaksi/ID Billing :',
            style: textCaption(),
          ),
          Text(
            'VTX0021671992791',
            style: textCustom(size: 14, weight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
