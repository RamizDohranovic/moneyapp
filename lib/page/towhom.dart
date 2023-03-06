import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/const.dart';
import 'package:moneyapp/page/pay.dart';
import 'package:moneyapp/page/transactions.dart';

class PayTo extends StatefulWidget {
  const PayTo({super.key});

  @override
  State<PayTo> createState() => _PayToState();
}

Random random = Random();

class _PayToState extends State<PayTo> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Positioned(
              top: 5,
              child: Text(
                'MoneyApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5, right: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('image/close.png'))),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'To whom?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        margin: const EdgeInsets.all(50.0),
                        child: TextField(
                            controller: textController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: '',
                              hintText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Container(
                      margin: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: 20, bottom: 20),
                        child: Text(
                          "Pay",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      )),
                  onTap: () {
                    if (textController.text.trim().isEmpty) {
                    } else {
                      var b = double.tryParse(paymentController.textInput);
                      RxDouble rxNum = RxDouble(b!);
                      RxDouble sum = (money.value - rxNum.value).obs;
                      money = sum;
                      final payment = Payment(
                          name: textController.text.trim(),
                          amount: b,
                          pay: true,
                          dateTime: DateTime.now(),
                          idtransaction: random.nextInt(90000000),
                          idmerchant: random.nextInt(9999));
                      paymentController.paymentList.add(payment);

                      Get.to(() => const Transactions());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
