import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/const.dart';
import 'package:moneyapp/page/loan.dart';
import 'package:moneyapp/page/pay.dart';
import 'package:moneyapp/page/transactiondetails.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

var money = 150.00.obs;
var id = 0.obs;
var topup = false.obs;
PaymentController paymentController = Get.put(PaymentController());

class _TransactionsState extends State<Transactions> {
  List menu = ['Pay', 'Top up', 'Loan'].obs;
  List iconMenu = [
    'image/phone_icon.png',
    'image/wallet_icon.png',
    'image/loan_icon.png',
  ];

  @override
  Widget build(BuildContext context) {
    if (paymentController.paymentList.isEmpty) {
      paymentController.addautoyesterday();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 250,
                      color: bColor,
                    ),
                    Container(
                      height: 100,
                      color: b2Color,
                    ),
                  ],
                ),
                const Positioned(
                    top: 2,
                    child: Text(
                      'MoneyApp',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    )),
                Positioned(
                  top: 90.0,
                  child: Obx(
                    () => RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: '£',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: money.toInt().toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 50.0),
                          ),
                          TextSpan(
                            text: '.${money.toStringAsFixed(2).split('.')[1]}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  left: 20,
                  child: Text(
                    'Recent Activity',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 0.5,
                            offset: Offset(0.0, 0.15),
                            spreadRadius: 0.1)
                      ],
                      color: Colors.white,
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    paymentController.textInput = '';
                                    topup.value = false;
                                    Get.to(() => const Pay());
                                  } else if (index == 1) {
                                    topup.value = true;
                                    paymentController.textInput = '';

                                    Get.to(() => const Pay());
                                  } else if (index == 2) {
                                    id.value = index;

                                    Get.to(() => const Loan());
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  AssetImage(iconMenu[index]))),
                                    ),
                                    Text(menu[index]),
                                  ],
                                ),
                              )),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        color: b2Color,
                        width: MediaQuery.of(context).size.width,
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          child: Text(
                            'TODAY',
                            style: TextStyle(color: tColor),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12.0, right: 20.0),
                        child: Column(
                          children: paymentController.paymentList.reversed
                              .map((payment) {
                            int index =
                                paymentController.paymentList.indexOf(payment);
                            return GestureDetector(
                              onTap: () {
                                id.value = index;
                                paymentController.switchvalue1.value = false;
                                Get.to(() => const TransactionDetails());
                              },
                              child: paymentController
                                          .paymentList[index].dateTime.day ==
                                      DateTime.now().day
                                  ? ListTile(
                                      leading: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: bColor),
                                        child: Icon(
                                          paymentController
                                                      .paymentList[index].pay !=
                                                  false
                                              ? Icons.shopping_bag
                                              : Icons.add_circle,
                                          color: b2Color,
                                        ),
                                      ),
                                      title: Text(
                                        paymentController
                                            .paymentList[index].name,
                                        style: const TextStyle(
                                            fontSize: 16, color: textColor),
                                      ),
                                      trailing: Text(
                                        paymentController
                                                    .paymentList[index].pay ==
                                                false
                                            ? "+${paymentController.paymentList[index].amount.toStringAsFixed(2)}"
                                            : paymentController
                                                .paymentList[index].amount
                                                .toStringAsFixed(2),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: paymentController
                                                      .paymentList[index].pay ==
                                                  false
                                              ? bColor
                                              : textColor,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        color: b2Color,
                        width: MediaQuery.of(context).size.width,
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          child: Text(
                            'YESTERDAY',
                            style: TextStyle(color: tColor),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12.0, right: 20.0),
                        child: Column(
                          children: paymentController.paymentList.reversed
                              .map((payment) {
                            int index =
                                paymentController.paymentList.indexOf(payment);
                            return GestureDetector(
                              onTap: () {
                                id.value = index;
                                paymentController.switchvalue1.value = false;
                                Get.to(() => const TransactionDetails());
                              },
                              child: paymentController
                                          .paymentList[index].dateTime.day ==
                                      DateTime.now()
                                          .add(const Duration(days: -1))
                                          .day
                                  ? ListTile(
                                      leading: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: bColor),
                                        child: Icon(
                                          paymentController
                                                      .paymentList[index].pay !=
                                                  false
                                              ? Icons.shopping_bag
                                              : Icons.add_circle,
                                          color: b2Color,
                                        ),
                                      ),
                                      title: Text(
                                        paymentController
                                            .paymentList[index].name,
                                        style: const TextStyle(
                                            fontSize: 16, color: textColor),
                                      ),
                                      trailing: Text(
                                        paymentController
                                                    .paymentList[index].pay ==
                                                false
                                            ? "+${paymentController.paymentList[index].amount.toStringAsFixed(2)}"
                                            : paymentController
                                                .paymentList[index].amount
                                                .toStringAsFixed(2),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: paymentController
                                                      .paymentList[index].pay ==
                                                  false
                                              ? bColor
                                              : textColor,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
