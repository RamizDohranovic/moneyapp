import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/const.dart';
import 'package:moneyapp/page/pay.dart';
import 'package:moneyapp/page/towhom.dart';
import 'package:moneyapp/page/transactions.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd. MMMM yyyy. HH:mm:ss');

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  bool switchvalue = false;
  bool split = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: b2Color,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: bColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => const Transactions());
          },
        ),
        title: const Text('MoneyApp'),
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Positioned(
              top: 5,
              right: 10,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const Text(
              'MoneyApp',
              style: TextStyle(color: Colors.white),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: bColor,
                            ),
                            child: Icon(
                              paymentController.paymentList[id.value].pay ==
                                      true
                                  ? Icons.shopping_bag
                                  : Icons.add_circle,
                              size: 42.0,
                              color: Colors.white,
                            ),
                          ),
                          Obx(
                            () => RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: paymentController
                                        .paymentList[id.value].amount
                                        .toInt()
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 50.0),
                                  ),
                                  TextSpan(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    text: '.' +
                                        paymentController
                                            .paymentList[id.value].amount
                                            .toStringAsFixed(2)
                                            .split('.')[1],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 30.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        paymentController.paymentList[id.value].name,
                        style: const TextStyle(fontSize: 32),
                      ),
                      Text(formatter.format(
                          paymentController.paymentList[id.value].dateTime)),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: bColor,
                              borderRadius: BorderRadius.circular(4),
                              image: const DecorationImage(
                                  image: AssetImage('image/icon2.png'))),
                        ),
                        const Text(
                          '  Add Receipt',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Text(
                        'SHARE THE COST',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (paymentController.paymentList[id.value].pay ==
                            true) {
                          var payment = Payment(
                              name:
                                  paymentController.paymentList[id.value].name,
                              amount: paymentController
                                      .paymentList[id.value].amount /
                                  2,
                              pay: true,
                              dateTime: paymentController
                                  .paymentList[id.value].dateTime,
                              idtransaction: paymentController
                                  .paymentList[id.value].idtransaction,
                              idmerchant: paymentController
                                  .paymentList[id.value].idmerchant);

                          //  paymentController.paymentList[id.value] = payment;
                          Get.find<PaymentController>().paymentList[id.value] =
                              payment;
                          final payment2 = Payment(
                              name: 'Top Up',
                              amount: paymentController
                                  .paymentList[id.value].amount,
                              pay: false,
                              dateTime: DateTime.now(),
                              idtransaction: random.nextInt(90000000),
                              idmerchant: random.nextInt(9999));
                          split = true;
                          paymentController.paymentList.add(payment2);

                          RxDouble sum = (money.value +
                                  (paymentController
                                      .paymentList[id.value].amount))
                              .obs;
                          money = sum;
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: bColor,
                                    borderRadius: BorderRadius.circular(4),
                                    image: const DecorationImage(
                                        image: AssetImage('image/icon1.png'))),
                              ),
                              const Text(
                                '  Split this bill',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Text(
                        'SUBSCRIPTION',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '  Repeating payment',
                              style: TextStyle(fontSize: 18),
                            ),
                            Obx(
                              () => Switch(
                                value: paymentController.switchvalue1.value,
                                onChanged: (value) {
                                  if (paymentController
                                          .paymentList[id.value].pay ==
                                      true) {
                                    if (value == true) {
                                      paymentController.toggleValue1();

                                      RxDouble sum = (money.value -
                                              paymentController
                                                  .paymentList[id.value].amount)
                                          .obs;
                                      money = sum;
                                      final payment = Payment(
                                          name: paymentController
                                              .paymentList[id.value].name,
                                          amount: paymentController
                                              .paymentList[id.value].amount,
                                          pay: true,
                                          dateTime: DateTime.now(),
                                          idtransaction:
                                              random.nextInt(90000000),
                                          idmerchant: random.nextInt(9999));
                                      Get.find<PaymentController>()
                                          .paymentList
                                          .add(payment);
                                    } else {
                                      paymentController.toggleValue1();
                                      Get.find<PaymentController>()
                                          .paymentList
                                          .removeLast();
                                    }
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Help is on the way, stay put!'),
                        actions: [
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '  Something wrong? Get help',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                    'Transaction ID #${paymentController.paymentList[id.value].idtransaction}',
                    style: const TextStyle(color: tColor)),
                Text(
                  '${paymentController.paymentList[id.value].name} . Merchant ID #${paymentController.paymentList[id.value].idmerchant}',
                  style: const TextStyle(color: tColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
