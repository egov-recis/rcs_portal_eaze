import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/sql_service.dart';
import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:rcs_portal_eaze/common/text.dart';
import 'package:rcs_portal_eaze/model/news.dart';
import 'package:rcs_portal_eaze/model/payment_group.dart';
import 'package:rcs_portal_eaze/ui/home/home_controller.dart';
import 'package:rcs_portal_eaze/ui/payment/payment_controller.dart';
import 'package:rcs_portal_eaze/ui/payment/payment_screen.dart';
import 'package:rcs_portal_eaze/ui/tracking/tracking_controller.dart';
import 'package:rcs_portal_eaze/ui/tracking/tracking_screen.dart';
import 'package:rcs_portal_eaze/utils/util.dart';
import 'package:rcs_portal_eaze/utils/widgets.dart';

class PortalEazeHomeScreen extends GetView<PortalEazeHomeController> {
  final String uniqueCode;
  const PortalEazeHomeScreen({super.key, required this.uniqueCode});

  @override
  Widget build(BuildContext context) {
    controller.service.login().then((value) {
      controller.getPaymentGroup();
    });
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.maxFinite,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            search(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  return controller.getPaymentGroup();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => controller.loadingPaymentGroup.value
                            ? const CircularProgressIndicator()
                            : menu(),
                      ),
                      tracking(),
                      lastTransaction(),
                      carousel(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerLastTransaction() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transaksi Terakhir',
                  style: textBody2(),
                ),
                Obx(
                  () => Text(
                    'update terakhir ${controller.lastUpdateHistory}',
                    style: textCustom(
                      size: 8,
                      weight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Get.to(() => const HistoryScreen());
              Get.toNamed(Strings.historyRoute);
            },
            child: Container(
              color: Colors.white,
              child: Text(
                'Lihat Semua',
                style: textCustom(
                  size: 10,
                  weight: FontWeight.w700,
                  color: Strings.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lastTransaction() {
    return Obx(
      () => controller.listHistory.isEmpty
          ? const SizedBox()
          : Column(
              children: [
                headerLastTransaction(),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                        children: [
                          ItemTransactionWidget(
                            paymentHistory: controller.listHistory[index],
                          ),
                          index == controller.listHistory.length - 1
                              ? const SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                        ],
                      ),
                      itemCount: controller.listHistory.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget tracking() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: () {
          Get.lazyPut(() => TrackingController());
          Get.to(() => TrackingScreen());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            // color: Colors.blue.shade50,
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
                child: Image.network(
                  "https://github.com/egov-recis/rcs_portal_eaze/blob/main/assets/images/tracking.png?raw=true",
                  width: 24,
                  errorBuilder: (context, error, stackTrace) => Container(),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tracking transaksi',
                      style: textCustom(
                        size: 12,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Cari status terakhir transaksi anda menggunakan kode transaki atau id billing',
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

  showSheetMenuAll({bool? autoFocus}) {
    showSheetCustom(
      context: Get.context!,
      content: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pilih Menu"),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(Get.context!);
                    controller.resetPaymentGroupFilter();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                height: 40,
                child: TextField(
                  autofocus: autoFocus ?? false,
                  onChanged: (value) {
                    controller.changePaymentGroupFilter(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Strings.primaryColor,
                      size: 16,
                    ),
                    hintText: 'Cari Pembayaran',
                    hintStyle: textCaption(color: Colors.grey.shade400),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  style: textCaption(),
                ),
              ),
            ),
            Obx(() => Text(
                  controller.listPaymentGroupFilter.isEmpty
                      ? 'Menu tidak tersedia'
                      : 'Menu yang tersedia',
                  style: textBody2(),
                )),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 12),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = controller.listPaymentGroupFilter[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          Get.lazyPut(() => PaymentController());
                          await Get.to(() => PaymentScreen(), arguments: data)
                              ?.then(
                            (value) => controller.getHistory(),
                          );
                          // await Get.toNamed(Strings.paymentRoute,
                          //         arguments: data)
                          //     ?.then(
                          //   (value) => controller.getHistory(),
                          // );
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
                                      data.icon ?? "",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.close);
                                      },
                                      width: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      data.name ?? "-",
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
                      index == (controller.listPaymentGroupFilter.length - 1)
                          ? const SizedBox()
                          : const Divider(
                              color: Colors.grey,
                            ),
                    ],
                  );
                },
                itemCount: controller.listPaymentGroupFilter.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemMenuShowAll() {
    return GestureDetector(
      onTap: () {
        showSheetMenuAll();
      },
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(10),
                child: const SizedBox(
                  width: double.maxFinite,
                  child: Icon(
                    Icons.dataset_outlined,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Lihat Semua",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textCaption(),
          ),
        ],
      ),
    );
  }

  Widget itemMenuNormal(ItemPaymentGroup data) {
    return GestureDetector(
      onTap: () async {
        // Get.back();
        Get.lazyPut(() => PortalEazeSqlService());
        Get.lazyPut(() => PaymentController());
        await Get.to(() => PaymentScreen(), arguments: data)?.then(
          (value) => controller.getHistory(),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Image.network(
                    data.icon ?? "",
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.close);
                    },
                    width: 24,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              data.name ?? "-",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textCaption(),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemMenu(Map<String, int> availableMenu, int index) {
    var expand = availableMenu['expand'];
    var maxIndexExpand = availableMenu['result'];
    ItemPaymentGroup data = controller.listPaymentGroup[index];
    if (expand == 0) {
      return itemMenuNormal(data);
    } else {
      if (index + 1 == maxIndexExpand) {
        return itemMenuShowAll();
      } else {
        return itemMenuNormal(data);
      }
    }
  }

  Widget menu() {
    Map<String, int> availableManu = getLengthAvailableMenu(
      controller.listPaymentGroup.length,
    );
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 80,
        childAspectRatio: 9 / 12,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemCount: availableManu['result'],
      itemBuilder: (context, index) {
        return itemMenu(availableManu, index);
      },
    );
  }

  Widget search() {
    return Padding(
      padding: EdgeInsets.only(
        top: 12 + AppBar().preferredSize.height,
        bottom: 20,
      ),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onTap: () {
                  showSheetMenuAll(autoFocus: true);
                },
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Strings.primaryColor,
                    size: 20,
                  ),
                  hintText: 'Cari Pembayaran',
                  hintStyle: textCaption(color: Colors.grey.shade400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  child: Icon(
                    Icons.headphones_rounded,
                    color: Strings.primaryColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Get.to(() => const NotificationScreen());
              },
              child: Container(
                color: Colors.white,
                child: Icon(
                  Icons.notifications_outlined,
                  color: Strings.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget carousel() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 40),
      child: Container(
        width: double.maxFinite,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Obx(
          () => controller.loadingNews.value
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : controller.listNews.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          "Tidak Ada Berita Acara",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items: controller.listNews
                          .map((item) => itemCarousel(item))
                          .toList(),
                    ),
        ),
      ),
    );
  }

  Widget itemCarousel(News data) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => NewsScreen(news: data));
      },
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Image.network(
                data.image.toString(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.close),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                width: double.maxFinite,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(139, 0, 0, 0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: double.maxFinite,
                      width: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        data.title.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
