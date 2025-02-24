import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:rcs_portal_eaze/common/text.dart';
import 'package:rcs_portal_eaze/model/response/response_denom.dart';
import 'package:rcs_portal_eaze/ui/virtual_account/virtual_account_controller.dart';
import 'package:rcs_portal_eaze/ui/virtual_account/virtual_account_screen.dart';
import 'package:rcs_portal_eaze/utils/util.dart';
import 'package:rcs_portal_eaze/utils/widgets.dart';
import 'payment_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<PaymentController>();
        return true;
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => Get.focusScope?.unfocus(),
          child: Container(
            color: Colors.white,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(context),
                      Obx(
                        () => controller.loading.value
                            ? const LoadingWidget()
                            : controller.listPaymentTypeGroup.isEmpty
                                ? const NoDataWidget()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: paymentTypeChooser(),
                                  ),
                      ),
                      phoneNumber(),
                      total(),
                      paymentMethod(isSelected: false),
                      // const SizedBox(height: 12),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: bank(context),
                      // ),
                      // const SizedBox(height: 12),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: paymentMethodPopup(context),
                      // ),
                      alert(),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget footer() {
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
          () => controller.loadingPayment.value
              ? const LoadingWidget()
              : GestureDetector(
                  onTap: () async {
                    Get.focusScope?.unfocus();
                    var result = await controller.postPayment(context);

                    if (result != null) {
                      Get.lazyPut(() => PortalEazeVirtualAccountController());
                      Get.to(() => PortalEazeVirtualAccountScreen(),
                          arguments: result);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF425BA7),
                    ),
                    child: Center(
                      child: Text(
                        'Lakukan Pembayaran',
                        style: textSub2(color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void showSheetPaymentType() {
    showSheetCustom(
      context: context,
      content: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 2,
              width: 24,
              color: Colors.grey,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        controller.selectedPaymentMethodIndex.value = index;
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller
                                        .listPaymentTypeGroup[controller
                                            .selectedPaymentTypeGroupIndex
                                            .value]
                                        .bankCategory?[index]
                                        .paymentTypeName ??
                                    "-",
                                style: textBody2(),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    index ==
                            ((controller
                                        .listPaymentTypeGroup[controller
                                            .selectedPaymentTypeGroupIndex
                                            .value]
                                        .bankCategory
                                        ?.length ??
                                    0) -
                                1)
                        ? const SizedBox()
                        : const Divider(
                            color: Colors.grey,
                          ),
                  ],
                );
              },
              itemCount: controller
                  .listPaymentTypeGroup[
                      controller.selectedPaymentTypeGroupIndex.value]
                  .bankCategory
                  ?.length,
            ),
          ],
        ),
      ),
    );
  }

  void showSheetPayment() {
    showSheetCustom(
      context: context,
      content: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 2,
              width: 24,
              color: Colors.grey,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        controller.tfPaymentTypeController.text =
                            controller.listPaymentTypeGroup[index].name ?? "";
                        controller.selectedPaymentTypeGroupIndex.value = index;
                        if (controller
                                .listPaymentTypeGroup[index].isManualInput ==
                            "2") {
                          controller.getDenom();
                        }
                        controller.tfTotalController.text = "";
                        controller.selectedRecommend.value = 999;
                        controller.selectedIndexPulse.value = 999;
                        controller.selectedPaymentMethodIndex.value = 999;
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.network(
                                    controller.data.icon ?? "",
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.close);
                                    },
                                    width: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    controller
                                            .listPaymentTypeGroup[index].name ??
                                        "-",
                                    style: textBody2(),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    index == (controller.listPaymentTypeGroup.length - 1)
                        ? const SizedBox()
                        : const Divider(
                            color: Colors.grey,
                          ),
                  ],
                );
              },
              itemCount: controller.listPaymentTypeGroup.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentTypeChooser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Jenis Pembayaran',
            style: textCaption(),
          ),
        ),
        GestureDetector(
          onTap: () {
            showSheetPayment();
          },
          child: SizedBox(
            height: 48,
            child: TextField(
              enabled: false,
              controller: controller.tfPaymentTypeController,
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintStyle: textCaption(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ),
              style: textCaption(),
            ),
          ),
        ),
      ],
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: AppBar().preferredSize.height,
        bottom: 40,
      ),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  controller.data.name ?? "-",
                  style: textH7(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bank(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bank",
          style: textCaption(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        TextField(
          onTap: () {
            showSheetCustom(
              context: context,
              content: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: 24,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    searchBank(),
                    // Obx(
                    //   () => controller.loadingPaymentType.value
                    //       ? Container(
                    //           margin: const EdgeInsets.only(top: 16),
                    //           child: const Center(
                    //             child: CircularProgressIndicator(),
                    //           ),
                    //         )
                    //       : ListView.builder(
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           shrinkWrap: true,
                    //           itemBuilder: (context, index) {
                    //             return Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 itemPaymentType(
                    //                   context,
                    //                   controller.listPaymentTypeFilter[index],
                    //                 ),
                    //                 index != controller.listPaymentTypeFilter.length - 1
                    //                     ? Divider(
                    //                         color: Colors.grey.shade500,
                    //                       )
                    //                     : const SizedBox(),
                    //               ],
                    //             );
                    //           },
                    //           itemCount: controller.listPaymentTypeFilter.length,
                    //         ),
                    // ),
                  ],
                ),
              ),
            );
          },
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            hintText: 'Pilih Bank',
            hintStyle: textBody2(color: Colors.grey.shade400),
          ),
        ),
      ],
    );
  }

  Widget paymentMethodPopup(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Metode Pembayaran",
          style: textCaption(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        TextField(
          onTap: () {
            showSheetCustom(
              context: context,
              content: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: 24,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.credit_card,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Virtual Account",
                                    style: textBody2(),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.qr_code,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "QRIS",
                                    style: textBody2(),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            hintText: 'Pilih Metode Pembayaran',
            hintStyle: textBody2(color: Colors.grey.shade400),
          ),
        ),
      ],
    );
  }

  Widget searchBank() {
    return TextField(
      onChanged: (value) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Icon(Icons.search),
        ),
        hintText: 'Cari Bank',
        hintStyle: textBody2(color: Colors.grey.shade400),
      ),
    );
  }

  Widget phoneNumber() {
    return Obx(
      () => controller.selectedPaymentTypeGroupIndex.value == 999
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      controller
                              .listPaymentTypeGroup[controller
                                  .selectedPaymentTypeGroupIndex.value]
                              .label ??
                          "",
                      style: textCaption(),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      controller: controller.tfIdBillingController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                      ),
                      style: textCaption(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget itemPulseMenu(int index) {
    Denom data = controller.listDenom[index];
    return GestureDetector(
      onTap: () {
        controller.tfTotalController.text = (data.total ?? 0).toString();
        controller.selectedIndexPulse.value = index;
      },
      child: Obx(
        () => Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: (controller.selectedIndexPulse.value) == index
                    ? Strings.primaryColor
                    : Colors.grey),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (data.total ?? 0).toString(),
                style: textCaption(
                    color: (controller.selectedIndexPulse.value) == index
                        ? Strings.primaryColor
                        : Colors.grey),
              ),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  data.label ?? "-",
                  style: textCaption(
                      color: (controller.selectedIndexPulse.value) == index
                          ? Strings.primaryColor
                          : Colors.grey),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  (data.amount ?? 0).toString(),
                  style: textSub2(
                      color: (controller.selectedIndexPulse.value) == index
                          ? Strings.primaryColor
                          : Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pulseMenu() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: controller.listDenom.length,
      itemBuilder: (context, index) {
        return itemPulseMenu(index);
      },
    );
  }

  Widget total() {
    return Obx(() {
      if (controller.selectedPaymentTypeGroupIndex.value == 999) {
        return const SizedBox();
      } else {
        var data = controller.listPaymentTypeGroup[
            controller.selectedPaymentTypeGroupIndex.value];
        if (data.isManualInput == "1") {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Nominal",
                  style: textCaption(),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 48,
                  child: TextFormField(
                    onChanged: (value) {
                      controller.selectedRecommend.value = 5;
                    },
                    controller: controller.tfTotalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RupiahInputFormatter(),
                    ],
                    style: textCaption(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              recommendation(),
              const SizedBox(height: 16),
            ],
          );
        } else if (data.isManualInput == "2") {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.loadingDenom.value
                  ? const LoadingWidget()
                  : pulseMenu(),
              const SizedBox(height: 16),
            ],
          );
        } else {
          return const SizedBox();
        }
      }
    });
  }

  Widget alert() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: AlertWidget(
          text:
              'Info Layanan\nPembayaran dapat dilakukan sebelum masa kadaluarsa berakhir'),
    );
  }

  Widget paymentMethod({required bool isSelected}) {
    return Obx(
      () => controller.selectedPaymentTypeGroupIndex.value != 999
          ? Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 40,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      showSheetPaymentType();
                    },
                    child: Container(
                      height: 64,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              controller.selectedPaymentMethodIndex.value == 999
                                  ? Text(
                                      "Pilih Metode Pembayaran",
                                      style: textCaption(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : Text(
                                      controller
                                              .listPaymentTypeGroup[controller
                                                  .selectedPaymentTypeGroupIndex
                                                  .value]
                                              .bankCategory?[controller
                                                  .selectedPaymentMethodIndex
                                                  .value]
                                              .paymentTypeName ??
                                          "-",
                                      style: textCaption(
                                        color: Colors.black,
                                      ),
                                    ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget itemRecommendation(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: index == 0 ? 16 : 8),
        Obx(
          () => index < controller.listRecommendation.length
              ? GestureDetector(
                  onTap: () {
                    controller.tfTotalController.text =
                        controller.listRecommendation[index]['title'] ?? "";
                    controller.selectedRecommend.value = index;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: controller.selectedRecommend.value == index
                              ? Strings.primaryColor
                              : Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text(
                        controller.listRecommendation[index]['title'] ?? "",
                        style: textCaption(
                          color: controller.selectedRecommend.value == index
                              ? Strings.primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.selectedRecommend.value == index
                                ? Strings.primaryColor
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: Text(
                          'Lainnya',
                          style: textCaption(
                              color: controller.selectedRecommend.value == index
                                  ? Strings.primaryColor
                                  : Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
        ),
      ],
    );
  }

  Widget recommendation() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 32,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => itemRecommendation(index),
          itemCount: controller.listRecommendation.length + 1,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
