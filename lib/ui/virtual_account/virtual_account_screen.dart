import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:rcs_portal_eaze/common/text.dart';
import 'package:rcs_portal_eaze/model/tracking.dart';
import 'package:rcs_portal_eaze/utils/util.dart';
import 'package:rcs_portal_eaze/utils/widgets.dart';
import 'virtual_account_controller.dart';

class VirtualAccountScreen extends GetView<VirtualAccountController> {
  const VirtualAccountScreen({super.key});

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      controller.timer.value = differenceTime(
        DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(controller.tracking.expiredDate ?? ''),
      ).toString();
      if (int.parse(controller.timer.value) <= 0) {
        timer.cancel();
        controller.status.value = 9999;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.deleteRef();
        Get.delete<VirtualAccountController>();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: buildStreamData(context: context),
      ),
    );
  }

  Widget buildFailedVA({required String msg}) {
    return buildCard(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildHeaderFailed(),
          const SizedBox(height: 8),
          buildDetailBillFailed(msg: msg),
          const SizedBox(height: 8),
          buildButton(
            title: "Coba lagi",
            action: () {},
          ),
        ],
      ),
    );
  }

  Widget footer(BuildContext context, String? flag) {
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
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  sheetError(
                    context: context,
                    typeError: 500,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Strings.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      flag == '1' ? 'Bukti Transaksi' : 'Cek Status',
                      style: textCustom(
                        size: 14,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: () {
                  sheetShare(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Strings.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Icon(
                      Icons.share,
                      color: Strings.primaryColor,
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

  Widget itemShare() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade300,
      ),
    );
  }

  sheetShare(BuildContext context) {
    List<String> types = [
      'sms',
      'wa',
      'fb',
      'twitter',
      'ig',
    ];
    showSheetCustom(
      context: context,
      content: Container(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 80,
          top: 4,
        ),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 12),
                child: Container(
                  height: 2,
                  width: 24,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Bagikan',
                style: textCustom(size: 16, weight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    right: (index == types.length - 1) ? 0 : 12,
                  ),
                  child: itemShare(),
                ),
                itemCount: types.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  sheetGuide(BuildContext context) {
    showSheetCustom(
      context: context,
      content: Container(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 40,
          top: 4,
        ),
        width: double.maxFinite,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24, top: 12),
              child: Container(
                height: 2,
                width: 24,
                color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Panduan Pembayaran',
                style: textCustom(size: 16, weight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget purchaseGuide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: () {
          sheetGuide(context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade50,
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(
                  "assets/images/purchase_guide.png",
                  width: 24,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Panduan Pembayaran',
                      style: textCustom(
                        size: 12,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Cek panduan untuk melakukan pembayaran transaksi ',
                      style: textCustom(
                        size: 8,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Strings.primaryColor,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemDetail({required Widget text1, required Widget text2}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(child: text1),
          Expanded(child: text2),
        ],
      ),
    );
  }

  Widget detailTransaction() {
    return ExpansionTile(
      title: Text(
        'Rincian Transaksi',
        style: textH7(),
      ),
      tilePadding: EdgeInsets.zero,
      shape: const Border(),
      children: [
        itemDetail(
          text1: Text(
            'Nominal Tagihan',
            style: textCaption(),
          ),
          text2: Align(
            alignment: Alignment.centerRight,
            child: Text(
              formattingRp((controller.tracking.amount ?? 0).toString()),
              style: textCustom(size: 14, weight: FontWeight.w400),
            ),
          ),
        ),
        itemDetail(
          text1: Text(
            'Denda',
            style: textCaption(),
          ),
          text2: Align(
            alignment: Alignment.centerRight,
            child: Text(
              formattingRp((controller.tracking.penalty ?? 0).toString()),
              style: textCustom(size: 14, weight: FontWeight.w400),
            ),
          ),
        ),
        itemDetail(
          text1: Text(
            'Biaya Admin',
            style: textCaption(),
          ),
          text2: Align(
            alignment: Alignment.centerRight,
            child: Text(
              formattingRp((controller.tracking.admin ?? 0).toString()),
              style: textCustom(size: 14, weight: FontWeight.w400),
            ),
          ),
        ),
        itemDetail(
          text1: Text(
            'Total',
            style: textCaption(),
          ),
          text2: Align(
            alignment: Alignment.centerRight,
            child: Text(
              formattingRp((controller.tracking.trxAmount ?? 0).toString()),
              style: textCustom(size: 14, weight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  Widget customerInformation() {
    return controller.tracking.additionalData != null
        ? ExpansionTile(
            title: Text(
              'Informasi Pelanggan',
              style: textH7(),
            ),
            tilePadding: EdgeInsets.zero,
            shape: const Border(),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => itemDetail(
                  text1: Text(
                    'Test $index',
                    style: textCaption(),
                  ),
                  text2: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Value $index',
                      style: textCustom(size: 14, weight: FontWeight.w400),
                    ),
                  ),
                ),
                itemCount: 2,
              ),
              buildDotDividerHorizontal(lenght: 50),
            ],
          )
        : const SizedBox();
  }

  Widget detailVaNumber({required int? status}) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 12),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'VA BANK Danamon',
              style: textH7(),
            ),
          ),
          itemDetail(
            text1: Text(
              'Status',
              style: textCaption(),
            ),
            text2: Obx(
              () {
                if (controller.status.value == 9999 && status != 1) {
                  status = 0;
                }
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: status == 1
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      border: Border.all(
                          color: status == 1 ? Colors.green : Colors.red),
                    ),
                    child: Text(
                      status == null
                          ? 'Belum Dibayar'
                          : status == 1
                              ? 'Sudah Bayar'
                              : 'Kadarluarsa',
                      style: textCustom(
                        size: 8,
                        weight: FontWeight.w400,
                        color: status == 1 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          itemDetail(
            text1: Text(
              'Kode Transaksi',
              style: textCaption(),
            ),
            text2: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        controller.tracking.clientRefnum ?? '-',
                        style: textCustom(size: 14, weight: FontWeight.w700),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Clipboard.setData(ClipboardData(
                            text: controller.tracking.clientRefnum ?? '-'))
                        .then(
                      (_) {
                        ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(
                            content: Text('Kode Transaksi Telah Disalin'),
                          ),
                        );
                      },
                    ),
                    child: Container(
                      color: Colors.white,
                      child: const Icon(
                        Icons.copy,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemDetail(
            text1: Text(
              'ID Billing',
              style: textCaption(),
            ),
            text2: Align(
              alignment: Alignment.centerRight,
              child: Text(
                controller.tracking.idBilling ?? '-',
                style: textCustom(size: 14, weight: FontWeight.w700),
              ),
            ),
          ),
          itemDetail(
            text1: Text(
              'Berlaku sampai dengan',
              style: textCaption(),
            ),
            text2: Align(
              alignment: Alignment.centerRight,
              child: Text(
                controller.tracking.expiredDate ?? '-',
                style: textCustom(size: 14, weight: FontWeight.w400),
              ),
            ),
          ),
          itemDetail(
            text1: Text(
              'Sisa waktu pembayaran',
              style: textCaption(),
            ),
            text2: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Obx(
                      () => Text(
                        timeLeft(int.parse(controller.timer.value)),
                        style: textCustom(size: 14, weight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemDetail(
            text1: Text(
              'Jenis pembayaran',
              style: textCaption(),
            ),
            text2: Align(
              alignment: Alignment.centerRight,
              child: Text(
                controller.tracking.paymentType ?? '-',
                style: textCustom(size: 14, weight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vaNumber({required int? status}) {
    return Obx(() {
      if (controller.status.value == 9999 && status != 1) {
        status = 0;
      }
      return Column(
        children: [
          status == null
              ? const Icon(
                  Icons.timelapse,
                  color: Color(0xFF9298AF),
                  size: 48,
                )
              : status == 1
                  ? Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF07C675),
                        ),
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFD3EBE0),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.done,
                          color: Color(0xFF07C675),
                          size: 32,
                        ),
                      ),
                    )
                  : Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(28),
                        color: const Color(0xFFF3CECD),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 32,
                        ),
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              'Virtual Account Number',
              style: textBody2(),
            ),
          ),
          Text(
            '100139012781237001',
            style: textCustom(size: 24, weight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SalinVAWidget(
              enable: status == 0 ? false : null,
              value: '',
              msg: 'Virtual Account Sudah Tersalin',
            ),
          ),
        ],
      );
    });
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.deleteRef();
            Get.back();
          },
          child: Container(
            color: Colors.white,
            child: const Icon(Icons.close),
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

  Widget buildPendingVA({
    required String? flag,
    required BuildContext context,
  }) {
    startTimer();
    int? status;
    if (flag != null) {
      status = int.parse(flag);
    }
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height + 12,
            left: 16,
            right: 16,
            bottom: 80,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      vaNumber(status: status),
                      detailVaNumber(status: status),
                      buildDotDividerHorizontal(lenght: 50),
                      customerInformation(),
                      detailTransaction(),
                      purchaseGuide(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        footer(context, flag),
      ],
    );
  }

  Widget buildVA(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : buildPendingVA(flag: controller.tracking.flag, context: context),
    );
  }

  Widget buildSuccessVA() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildHeaderSuccess(),
        const SizedBox(height: 8),
        buildDotDividerHorizontal(lenght: 50),
        const SizedBox(height: 8),
        buildDetailBill(),
        const SizedBox(height: 8),
        buildDotDividerHorizontal(lenght: 50),
        const SizedBox(height: 16),
        buildButton(
          title: "Cetak Bukti Pembayaran",
          action: () {},
        ),
      ],
    );
  }

  Widget buildButton({required String title, required void Function() action}) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.blue),
        ),
        child: Center(
          child: Text(
            title,
            style: textBody1(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget buildDetailBillFailed({required String msg}) {
    return Column(
      children: [
        Text(
          "Generate pembayaran tidak dapat diproses",
          style: textH6(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Silahkan hubungi administrator",
          style: textBody1(),
        ),
        const SizedBox(height: 16),
        Text(
          msg,
          style: textBody1(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildDetailBillPending() {
    Tracking data = controller.tracking;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Virtual Account",
        //       style: textCaption(),
        //     ),
        //     const SizedBox(width: 4),
        //     Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text(
        //           data.virtualAccount ?? "",
        //           style: textSub1(),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             Clipboard.setData(ClipboardData(text: data.virtualAccount))
        //                 .then((_) {
        //               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //                   content: Text("Virtual Account telah disalin")));
        //             });
        //           },
        //           child: const Icon(
        //             Icons.copy,
        //             color: Colors.blue,
        //           ),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Berlaku sampai",
              style: textCaption(),
            ),
            Text(
              data.expiredDate ?? "",
              style: textBody2(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDetailBill() {
    Tracking data = controller.tracking;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rincian Pembayaran",
          style: textH7(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ID Billing",
              style: textCaption(),
            ),
            Text(
              data.idBilling ?? "",
              style: textSub1(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Jenis",
              style: textCaption(),
            ),
            Text(
              data.paymentType ?? "",
              style: textBody2(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nama",
              style: textCaption(),
            ),
            Text(
              data.vaNumber ?? "",
              style: textBody2(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nominal",
              style: textCaption(),
            ),
            Text(
              data.amount.toString(),
              style: textH7(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStreamData({required BuildContext context}) {
    return StreamBuilder(
      stream: controller.reference().onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height,
                    left: 16,
                  ),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      color: Colors.white,
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        } else {
          if (snapshot.hasError) {
            return buildFailedVA(msg: snapshot.error.toString());
          } else if (snapshot.hasData) {
            if (snapshot.data?.snapshot.value == null) {
              // startTimer();
              return buildVA(context);
            } else {
              // var dataString = snapshot.data?.snapshot.children;
              // var date = "";
              // dataString?.first.children.forEach((element) {
              //   if (element.key == "payment_date") {
              //     date = element.value.toString();
              //   }
              // });
              controller.getTracking();
              // snapshot.data?.snapshot.children.forEach((element) {
              //   print(element.value);
              // });
              return buildVA(context);
            }
          } else {
            return buildFailedVA(msg: snapshot.stackTrace.toString());
          }
        }
      },
    );
  }

  Widget buildDotDividerHorizontal({int lenght = 5}) {
    String divider = "";
    for (var i = 0; i < lenght; i++) {
      divider += " -";
    }
    return Text(
      divider,
      maxLines: 1,
    );
  }

  Widget buildHeaderFailed() {
    return Center(
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(28),
          color: const Color(0xFFF3CECD),
        ),
        child: const Center(
          child: Icon(
            Icons.close,
            color: Colors.red,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget buildHeaderPending() {
    return SizedBox(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              color: Colors.white,
              child: const Icon(Icons.close),
            ),
          ),
          const Expanded(
            child: Center(
              child: Center(
                child: Icon(
                  Icons.timelapse,
                  color: Color(0xFF9298AF),
                  size: 48,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Menunggu Pembayaran",
                  style: textH6(),
                ),
                Text(
                  "Silakan lakukan pembayaran",
                  style: textBody2(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderSuccess() {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              color: Colors.white,
              child: const Icon(Icons.close),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF07C675),
                  ),
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xFFD3EBE0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.done,
                    color: Color(0xFF07C675),
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Telah Dibayarkan",
                  style: textH6(),
                ),
                Text(
                  "Tanggal ${controller.tracking.paymentDate}",
                  style: textBody2(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard({required Widget content}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: content,
      ),
    );
  }

  Widget cardVA(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppBar().preferredSize.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.deleteRef();
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Image.asset(
                  "assets/images/eaze.png",
                  width: 120,
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Virtual Account Number",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              controller.virtualAccount.virtualAccount ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(
                        text: controller.virtualAccount.virtualAccount ?? ''))
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Virtual Account Copied To Clipboard")));
                });
              },
              child: Container(
                width: 150,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  color: Colors.white,
                ),
                child: const Center(
                  child: Text(
                    "Salin Virtual Account",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "VA Berlaku hingga",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        controller.virtualAccount.datetimeExpired ?? '',
                        style: textCaption(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.watch_later_outlined),
                          Obx(() {
                            if (int.parse(controller.timer.value) <= 0) {
                              // controller.deleteRef();
                              Get.delete<VirtualAccountController>();
                              Get.back();
                            }
                            return Text(
                              timeLeft(int.parse(controller.timer.value)),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: List.generate(60, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 4.0,
                    ),
                    child: Container(
                      height: 1,
                      color: const Color(0XFF9098B0),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 25),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Rincian Pembayaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "ID Billiing",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  controller.virtualAccount.idBilling ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Jenis",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  controller.virtualAccount.paymentType ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nama",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  controller.virtualAccount.customerName ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nominal",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  formattingRp(controller.virtualAccount.trxAmount == null
                      ? '0'
                      : controller.virtualAccount.trxAmount.toString()),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
