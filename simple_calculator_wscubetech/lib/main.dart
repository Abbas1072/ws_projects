import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff08c7b9)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController totalPersonController = TextEditingController();
  final TextEditingController billAmountController = TextEditingController();
  double tipPercentage = 0.0;
  double tipAmount = 0.0;
  double billAmount = 0.0;
  double totalBill = 0.0;
  int totalPerson = 0;
  double splitAmount = 0.0;

  void calculateTip(double percentage) {
    setState(() {
      billAmount = double.tryParse(billAmountController.text) ?? 0.0;
      totalPerson = int.tryParse(totalPersonController.text) ?? 0;
      tipPercentage = percentage;
      tipAmount = billAmount * tipPercentage / 100;
      totalBill = tipAmount + billAmount;
      if (totalPerson > 0) {
        splitAmount = totalBill / totalPerson;
      } else {
        splitAmount = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/hat.png'),
                const SizedBox(width: 8.0),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Mr',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        SizedBox(width: 2.0),
                        Text(
                          'TIP',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      'Calculator',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 235,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0xffFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(),
                    blurRadius: 15.0,
                  ),
                ],
              ),
              margin: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Total p/person',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        height: 3,
                      ),
                    ),
                    Text(
                      '\$${splitAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                    const Text(
                      '-------------------------------------------------------------------------------------------------------------------',
                      style: TextStyle(
                        letterSpacing: -1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Total bill',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                ' \$${totalBill.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Color(0xff08c7b9),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'Total Tip',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\$${tipAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff08c7b9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      'Enter',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'your bill',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8.0),
                Container(
                  color: const Color(0xffFFFFFF),
                  height: 60,
                  width: 270,
                  child: TextField(
                    controller: billAmountController,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixText: '\$ ',
                      prefixStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      'Choose',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'your tip',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8.0),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff08c7b9),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 55,
                      width: 80,
                      child: TextButton(
                        onPressed: () {
                          calculateTip(10);
                        },
                        child: const Text(
                          '10%',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff08c7b9),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 55,
                      width: 80,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            calculateTip(15.0);
                          });
                        },
                        child: const Text(
                          '15%',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff08c7b9),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 55,
                      width: 80,
                      child: TextButton(
                        onPressed: () {
                          calculateTip(20.0);
                        },
                        child: const Text(
                          '20%',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.only(left: 150),
              height: 55,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xff08c7b9),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    calculateTip(5.0);
                  });
                },
                child: const Text(
                  'custom tip',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      'Split',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'the total',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8.0),
                Container(
                  color: const Color(0xffFFFFFF),
                  height: 60,
                  width: 270,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff08c7b9),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        height: 55,
                        width: 80,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              totalPerson--;
                              if (totalPerson <= 0) {
                                totalPerson = 0;
                              }
                              totalPersonController.text =
                                  totalPerson.toString();
                            });
                          },
                          child: const Text(
                            '-',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Text(
                        '$totalPerson',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff08c7b9),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        height: 55,
                        width: 80,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              totalPerson++;
                              totalPersonController.text =
                                  totalPerson.toString();
                            });
                          },
                          child: const Text(
                            '+',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
