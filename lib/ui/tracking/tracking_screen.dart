import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:rcs_portal_eaze/common/text.dart';
import 'package:rcs_portal_eaze/utils/widgets.dart';
import 'tracking_controller.dart';

class TrackingScreen extends GetView<TrackingController> {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.focusScope?.unfocus(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.maxFinite,
              color: Colors.white,
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  header(),
                  search(),
                  history(),
                ],
              ),
            ),
          ),
          footer(context),
        ],
      ),
    );
  }

  Widget history() {
    return Obx(
      () => controller.list.isEmpty
          ? const SizedBox()
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              child: Column(
                children: [
                  ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Icon(
                              Icons.timer_outlined,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.getTransactionTrack(
                                  billing: controller.list[index]['id_billing'],
                                );
                              },
                              child: Container(
                                color: Colors.grey.shade200,
                                child: Text(
                                  controller.list[index]['id_billing'],
                                  style: textCaption(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.deleteHistoryTracking(
                                controller.list[index]['id']),
                            child: Container(
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: controller.list.length,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => controller.deleteAllHistoryTracking(),
                        child: Container(
                          color: Colors.grey.shade200,
                          child: Text(
                            'Hapus riwayat pencarian',
                            style: textCustom(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget search() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cari transaksi anda',
            style: textCustom(size: 14, weight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Masukan kode transaksi yang tertera pada bukti transaksi atau masukan ID Billing',
              style: textCaption(),
            ),
          ),
          TextField(
            controller: controller.tfBillingController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Strings.primaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Contoh : DND0100192399',
              hintStyle: textBody2(color: Colors.grey),
            ),
            cursorColor: Strings.primaryColor,
            style: textBody2(),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () {
              Get.back();
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
    );
  }

  Widget footer(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.only(
          left: 16,
          top: 12,
          right: 16,
          bottom: 24,
        ),
        child: Obx(
          () => controller.loading.value
              ? LoadingWidget()
              : GestureDetector(
                  onTap: () {
                    Get.focusScope?.unfocus();
                    controller.getTransactionTrack();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Strings.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Cari Transaksi',
                        style: textSub2(color: Colors.white),
                      ),
                    ),
                  ),
                  // ),
                ),
        ),
      ),
    );
  }
}
