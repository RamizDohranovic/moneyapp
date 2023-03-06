import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/const.dart';
import 'package:moneyapp/page/towhom.dart';
import 'package:moneyapp/page/pay.dart';
import 'package:moneyapp/page/transactions.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd. MMMM yyyy. HH:mm:ss');

class Loan extends StatefulWidget {
  const Loan({super.key});

  @override
  State<Loan> createState() => _LoanState();
}

class Controller extends GetxController {
  var monthly = 0.obs;
  var firstApply = false.obs;
  var mexpenses = 0.obs;
  var amount = 0.obs;
  var term = 0.obs;
  var randNum = 0.obs;
  var switchvalue = false.obs;
  var waitapproved = false.obs;
  void waitapprovedchange() {
    waitapproved.value = false;
  }

  void toggleValue() {
    switchvalue.value = true;
  }

  void loanservice() {
    if (randNum > 50 &&
        money > 1000 &&
        monthly > 1000 &&
        mexpenses < (monthly / 3) &&
        (amount / term.value) < monthly.value) {
      waitapprovedchange();

      Get.dialog(
        AlertDialog(
          title: const Text(
            'APPROVED ',
            style: TextStyle(color: Colors.green),
          ),
          content: const Text(
              'Yeeeyyy !! Congrats. Your application has been approved. Don’t tell your friends you have money!'),
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

      double amountresult = amount.toDouble();
      RxDouble sum = (money.value + amountresult).obs;
      money = sum;
      final payment = Payment(
          name: 'Loan',
          amount: amountresult,
          pay: false,
          dateTime: DateTime.now(),
          idtransaction: random.nextInt(90000000),
          idmerchant: random.nextInt(9999));
      Get.find<PaymentController>().paymentList.add(payment);
    } else {
      if (monthly > 1000 &&
          mexpenses < (monthly / 3) &&
          (amount / term.value) < monthly.value) {
        waitapproved.value = true;
        Get.dialog(
          AlertDialog(
            title: const Text(
              'DECLINED',
              style: TextStyle(color: Colors.red),
            ),
            content: const Text(
                'Ooopsss. Your application has been declined. It’s not your fault, it’s a financial crisis. '),
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
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text(
              'DECLINED',
              style: TextStyle(color: Colors.red),
            ),
            content: const Text(
                'Ooopsss. Your application has been declined. It’s not your fault, it’s a financial crisis. '),
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
      }
    }
  }
}

class _LoanState extends State<Loan> {
  //bool switchvalue = false;
  var switchs = RxBool(false);
  Future<int> getRandomNumber() async {
    var url = Uri.parse(
        "https://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      return controller.randNum.value =
          jsonData[0] < 50 ? (jsonData[0] + 50) : jsonData[0];
    } else {
      throw Exception('Failed to get random number');
    }
  }

  final Controller controller = Get.put(Controller());
  final TextEditingController controllers = TextEditingController();
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
        title: const Text('Loan Application'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Terms and Conditions\n",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum enim non neque luctus, nec blandit ipsum sagittis. Sed fringilla blandit nibh, sit amet suscipit massa sollicitudin lacinia. Donec cursus, odio sit amet tincidunt sodales, odio nisl hendrerit sem, tempor tincidunt ligula nisl nec ante. Nulla aliquet aliquam justo, ac bibendum orci rhoncus non. Nullam quis ex elementum, pharetra ligula eleifend, convallis nulla. Nulla sit amet nisi viverra, semper nunc eu, posuere dui. Donec at metus ut eros rhoncus vestibulum vitae at lacus. Etiam imperdiet, nulla ac condimentum aliquam, enim lacus fringilla leo, vel hendrerit mi ipsum et ante. Vivamus finibus mauris eget diam sodales, eget efficitur orci laoreet. Sed feugiat odio quis mattis tristique. Mauris sit amet sem mauris.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
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
                            '  Accept Terms & Conditions',
                            style: TextStyle(fontSize: 18),
                          ),
                          Obx(() => Switch(
                                value: controller.switchvalue.value,
                                onChanged: (value) {
                                  controller.toggleValue();

                                  if (value == true) {
                                  } else {}
                                },
                              ))
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
                          'ABOUT YOU',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controllers.clear();
                          Get.dialog(AlertDialog(
                            title: const Text('Monthly Salary'),
                            content: TextFormField(
                              controller: controllers,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  String text = controllers.text.trim();
                                  int montlyresult = int.tryParse(text) ?? 0;

                                  controller.monthly.value = montlyresult;

                                  Get.back();
                                },
                              ),
                            ],
                          ));
                        },
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: const Text(
                              'Monthly Salary',
                              style: TextStyle(color: tColor),
                            ),
                            subtitle: Obx(
                              () => Text(
                                '£ ${controller.monthly}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controllers.clear();
                          Get.dialog(AlertDialog(
                            title: const Text('Monthly Expenses'),
                            content: TextFormField(
                              controller: controllers,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  String text = controllers.text.trim();
                                  int montlyresult = int.tryParse(text) ?? 0;

                                  controller.mexpenses.value = montlyresult;

                                  Get.back();
                                },
                              ),
                            ],
                          ));
                        },
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: const Text(
                              'Monthly Expenses',
                              style: TextStyle(color: tColor),
                            ),
                            subtitle: Obx(
                              () => Text(
                                '£ ${controller.mexpenses}',
                                style: const TextStyle(color: Colors.black),
                              ),
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
                          'LOAN',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controllers.clear();
                          Get.dialog(AlertDialog(
                            title: const Text('Amount'),
                            content: TextFormField(
                              controller: controllers,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  String text = controllers.text.trim();
                                  int montlyresult = int.tryParse(text) ?? 0;

                                  controller.amount.value = montlyresult;

                                  Get.back();
                                },
                              ),
                            ],
                          ));
                        },
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: const Text(
                              'Amount',
                              style: TextStyle(color: tColor),
                            ),
                            subtitle: Obx(
                              () => Text(
                                '£ ${controller.amount}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controllers.clear();
                          Get.dialog(AlertDialog(
                            title: const Text('Term'),
                            content: TextFormField(
                              controller: controllers,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  String text = controllers.text.trim();
                                  int montlyresult = int.tryParse(text) ?? 0;
                                  controller.term.value = montlyresult;
                                  Get.back();
                                  getRandomNumber();
                                },
                              ),
                            ],
                          ));
                        },
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: const Text(
                              'Term',
                              style: TextStyle(color: tColor),
                            ),
                            subtitle: Obx(
                              () => Text(
                                '${controller.term}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      child: Container(
                          margin: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: bColor,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 50, right: 50, top: 20, bottom: 20),
                            child: Text(
                              "Apply for loan",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          )),
                      onTap: () {
                        if (controller.firstApply.value == true) {
                          controller.firstApply.value = true;
                          if (controller.waitapproved.value == true) {
                            controller.loanservice();
                          } else {
                            Get.dialog(
                              AlertDialog(
                                title: const Text(
                                    'Ooopsss, you applied before. Wait for notification from us'),
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
                          }
                        } else {
                          controller.firstApply.value = true;
                          controller.loanservice();
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
