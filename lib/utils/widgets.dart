import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:rcs_portal_eaze/common/text.dart';
import 'package:rcs_portal_eaze/model/response/response_payment_history.dart';

class ItemTransactionWidget extends StatelessWidget {
  final PaymentHistory? paymentHistory;
  const ItemTransactionWidget({
    super.key,
    this.paymentHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  paymentHistory?.paymentTypeName ?? 'PBB - OKU Timur',
                  style: textCustom(size: 10, weight: FontWeight.w400),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: paymentHistory?.flag != '1'
                                ? Colors.red
                                : Colors.green,
                          ),
                          color: paymentHistory?.flag != '1'
                              ? Colors.red.shade50
                              : Colors.green.shade50,
                        ),
                        child: Center(
                          child: Text(
                            paymentHistory?.flag != '1'
                                ? 'Belum Dibayar'
                                : 'Sudah Bayar',
                            style: textCustom(
                              size: 8,
                              weight: FontWeight.w400,
                              color: paymentHistory?.flag != '1'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [],
                      child: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentHistory?.clientRefnum ?? '3209019309012400',
                      style: textCustom(size: 10, weight: FontWeight.w700),
                    ),
                    Text(
                      paymentHistory?.generatedDate ?? '23 - 05 -2024 15:00:01',
                      style: textCustom(size: 8, weight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  (paymentHistory?.total ?? 0).toString(),
                  style: textCustom(size: 12, weight: FontWeight.w700),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Strings.primaryColor,
      ),
    );
  }
}

class AlertWidget extends StatelessWidget {
  final String text;
  const AlertWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Strings.primaryColor.withOpacity(0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24,
            width: 24,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Strings.primaryColor,
            ),
            child: const Center(
              child: Text(
                "!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              text,
              style: textCaption(),
            ),
          ),
        ],
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Tidak ada data.",
        style: textCaption(),
      ),
    );
  }
}

class SalinVAWidget extends StatelessWidget {
  final String? text;
  final bool? enable;
  final String value;
  final String msg;
  const SalinVAWidget({
    super.key,
    required this.value,
    required this.msg,
    this.text,
    this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable == false
          ? () {}
          : () {
              Clipboard.setData(ClipboardData(text: value)).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg)),
                );
              });
            },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: enable == false
              ? null
              : Border.all(
                  color: Strings.primaryColor,
                ),
          color: enable == false ? Colors.grey.shade200 : Colors.white,
        ),
        child: Text(
          text ?? "Salin Virtual Account",
          style: textBody2(
              color: enable == false ? Colors.grey : Strings.primaryColor),
        ),
      ),
    );
  }
}
