import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var ageValue = 0.0;
  var weigthValue = 0.0;
  var feetValue = 0.0;
  var inchValue = 0.0;
  var resultValue = 0.0;
  var resultAns = "Set Value and Calcuate your bmi";
  var imgValue = 'assets/images/img (5).png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            'Your BMI is : ${resultValue.toStringAsFixed(0)}',
            style: GoogleFonts.quicksand(
                fontSize: 35, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          Image.asset(
            imgValue,
            height: 100,
          ),
          const SizedBox(height: 8),
          Text(
            resultAns,
            style: GoogleFonts.quicksand(
                fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          CustomSlider('Age', ageValue, 100, 100, (double value) {
            setState(() {
              ageValue = value;
            });
          }),
          const SizedBox(height: 10),
          CustomSlider('Weight', weigthValue, 150, 150, (double value) {
            setState(() {
              weigthValue = value;
            });
          }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomSlider('Feet', feetValue, 10, 10, (double value) {
                setState(() {
                  feetValue = value;
                });
              }),
              CustomSlider('Inch', inchValue, 12, 12, (double value) {
                setState(() {
                  inchValue = value;
                });
              })
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (ageValue != 0.0 && feetValue != 0.0 && weigthValue != 0.0) {
                var tInch = (feetValue.toInt() * 12) + inchValue;
                var tCm = tInch * 2.54;
                var tM = tCm / 100;
                resultValue = weigthValue.toInt() / (tM * tM);
                if (resultValue > 25) {
                  //overWeight
                  setState(() {
                    resultAns = 'Over Weight';
                    imgValue = 'assets/images/img (2).png';
                  });
                } else if (resultValue < 18) {
                  //under Weight
                  setState(() {
                    resultAns = 'Under Weight';
                    imgValue = 'assets/images/img (3).png';
                  });
                } else {
                  //healthy
                  setState(() {
                    resultAns = 'Normal';
                    imgValue = 'assets/images/img (4).png';
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please set all Values'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(350, 60),
            ),
            child: Text(
              'Calculate',
              style: GoogleFonts.quicksand(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  final String title;
  final ValueChanged<double> onChanged;
  final double value;
  final double maxSliderValue;
  final int divisionssliderValue;
  const CustomSlider(this.title, this.value, this.maxSliderValue,
      this.divisionssliderValue, this.onChanged,
      {super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 25,
          child: Text(
            widget.title,
            style: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Positioned(
          right: 25,
          child: Text(
            widget.value.toStringAsFixed(0),
            style: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Slider(
            value: widget.value,
            min: 0,
            max: widget.maxSliderValue,
            divisions: widget.divisionssliderValue,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
