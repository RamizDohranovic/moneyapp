import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/const.dart';
import 'package:moneyapp/page/towhom.dart';
import 'package:moneyapp/page/transactions.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

/*double paymoney = 0.0;
String addmoney = "0.0";
String textInput = '';*/

class PaymentController extends GetxController {
  final paymentList = <Payment>[].obs;
  var switchvalue1 = false.obs;
  var textInput = '0.00';

  void addautoyesterday() {
    final payment = Payment(
        name: 'Amazon',
        amount: 50.00,
        pay: true,
        dateTime: DateTime.now().add(const Duration(days: -1)),
        idtransaction: random.nextInt(90000000),
        idmerchant: random.nextInt(9999));
    paymentController.paymentList.add(payment);
    final payment2 = Payment(
        name: 'Top Up',
        amount: 200.00,
        pay: false,
        dateTime: DateTime.now().add(const Duration(days: -1)),
        idtransaction: random.nextInt(90000000),
        idmerchant: random.nextInt(9999));
    paymentController.paymentList.add(payment2);
  }

  void toggleValue1() {
    paymentController.switchvalue1.value =
        !paymentController.switchvalue1.value;
  }
}

class Payment {
  final String name;
  final double amount;
  final bool pay;
  final DateTime dateTime;
  final int idtransaction;
  final int idmerchant;

  Payment(
      {required this.name,
      required this.amount,
      required this.pay,
      required this.dateTime,
      required this.idtransaction,
      required this.idmerchant});
}

class _PayState extends State<Pay> {
  List<dynamic> typinfo = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    ".",
    "0",
    "<",
  ];

  void _onKeyPressed(String key) {
    setState(() {
      if (key == 'backspace') {
        if (paymentController.textInput.isNotEmpty) {
          paymentController.textInput = paymentController.textInput
              .substring(0, paymentController.textInput.length - 1);
        }
      } else {
        paymentController.textInput += key;
      }
    });
  }

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
                child: Container(
                  margin: const EdgeInsets.only(top: 5, right: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('image/close.png'))),
                ),
                onTap: () {
                  Get.to(() => const Transactions());
                },
              ),
            ),
            Column(
              children: [
                const SizedBox(),
                SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'How much?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      RichText(
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
                              text: paymentController.textInput.isEmpty
                                  ? '0.00'
                                  : paymentController.textInput,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 50.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GridView.count(
                    padding: const EdgeInsets.all(40.0),
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 4,
                    crossAxisCount: 3,
                    children: List.generate(
                        typinfo.length,
                        (index) => GestureDetector(
                              onTap: () {
                                if (index == 11) {
                                  _onKeyPressed('backspace');
                                } else if (index == 10) {
                                  _onKeyPressed("0");
                                } else if (index == 9) {
                                  _onKeyPressed('.');
                                } else {
                                  _onKeyPressed("${index + 1}");
                                }
                              },
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    typinfo[index].toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
                GestureDetector(
                  child: Container(
                      margin: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, top: 20, bottom: 20),
                        child: Text(
                          topup.value == false ? "Next" : 'Top Up',
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                      )),
                  onTap: () {
                    if (paymentController.textInput.isNotEmpty) {
                      if (topup.value == true) {
                        var b = double.tryParse(paymentController.textInput);
                        RxDouble rxNum = RxDouble(b!);
                        RxDouble sum = (money.value + rxNum.value).obs;
                        money = sum;
                        final payment = Payment(
                            name: 'Top Up',
                            amount: b,
                            pay: false,
                            dateTime: DateTime.now(),
                            idtransaction: random.nextInt(90000000),
                            idmerchant: random.nextInt(9999));
                        Get.find<PaymentController>().paymentList.add(payment);
                        Get.to(() => const Transactions());
                      } else {
                        Get.to(() => const PayTo());
                      }
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
