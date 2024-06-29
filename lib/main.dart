import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  bool? ahmetbabba;

  @override
  void initState() {
    super.initState();
    sayfaAcilirkenVeriyeBak();
  }

  void sayfaAcilirkenVeriyeBak() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ahmetbabba = prefs.getBool("themeData") ??
          true; //?? işareti Eğer soldaki kısmın değeri yoksa sağdakini kullan demek
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ahmetbabba == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        backgroundColor: ahmetbabba! ? Colors.red : Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ahmetbabba! ? "Burası kırmızı" : "Burası Mavi"),
              CupertinoSwitch(
                value: ahmetbabba!,
                onChanged: (value) async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    ahmetbabba = value;
                  });
                  prefs.setBool("themeData", value);
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
