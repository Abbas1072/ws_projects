import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffFFFFFF)),
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
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double bmi = 0.0;
  String result = 'Tell My Health Status';
  String selectedGender = '';
  String imagePath = '';

  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void calculateBmi() {
    if (ageController.text.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty) {
      setState(() {
        result = 'Please Enter All Fields';
        imagePath = '';
      });
      return;
    }
    try {
      setState(() {
        final height = double.parse(heightController.text);
        final weight = double.parse(weightController.text);
        bmi = weight / pow(height / 100, 2);

        if (selectedGender == 'Male') {
          if (bmi < 18) {
            result = 'You are underweight';
            imagePath = 'assets/images/underWeightMan.png';
          } else if (bmi >= 18 && bmi <= 25) {
            result = 'You are healthy';
            imagePath = 'assets/images/healthyMan.png';
          } else {
            result = 'You are OverWeight';
            imagePath = 'assets/images/overWeightMan.png';
          }
        } else if (selectedGender == 'Female') {
          if (bmi < 18) {
            result = 'You are underweight';
            imagePath = 'assets/images/underWeightWoman.png';
          } else if (bmi > 18 && bmi < 25) {
            result = 'You are healthy';
            imagePath = 'assets/images/healthyWoman.png';
          } else {
            result = 'You are OverWeight';
            imagePath = 'assets/images/overWeightWoman.png';
          }
        }
      });
    } catch (e) {
      setState(() {
        result = 'Invalid Input. Please Enter Valid Numbers';
        imagePath = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'BMI CALCULATOR',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/heart.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                color: Colors.red,
              ),
              Text(
                bmi.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(result,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xff269880),
              )),
          const SizedBox(height: 20),
          Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Color(0xffddd9d9),
              ),
              child: imagePath.isNotEmpty
                  ? Image.asset(imagePath, fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        'No Image',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    )),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              genderIcon('Male', Icons.male, Colors.blue[200]),
              genderIcon('Female', Icons.female, Colors.pink[200]),
            ],
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              requiredField('Age', ageController),
              Text('|',
                  style: TextStyle(
                    fontSize: 80,
                    color: Color(0xffD9D9D9),
                  )),
              requiredField('Height', heightController),
              Text('|',
                  style: TextStyle(
                    fontSize: 80,
                    color: Color(0xffD9D9D9),
                  )),
              requiredField('Weight', weightController),
            ],
          ),
          const SizedBox(height: 80.0),
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: TextButton(
              onPressed: () {
                calculateBmi();
              },
              child: Text(
                'CALCULATE BMI',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget genderIcon(String gender, IconData icon, Color? color) {
    return Column(children: [
      Text(
        gender,
        style: TextStyle(fontSize: 25, color: Colors.green),
      ),
      IconButton(
          onPressed: () {
            selectGender(gender);
          },
          icon: Icon(
            icon,
            size: 50,
            color: selectedGender == gender ? color : const Color(0xffD9D9D9),
          )),
    ]);
  }

  Widget requiredField(String label, TextEditingController controller) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 30,
              color: Color(0xffD9D9D9),
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            textAlign: TextAlign.center,
            controller: controller,
            style: TextStyle(
              fontSize: 30,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
