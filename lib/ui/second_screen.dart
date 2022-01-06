import 'package:flutter/material.dart';
import 'package:suitmedia_apps_zufar/model/people.dart';
import 'package:suitmedia_apps_zufar/common/style.dart';
import 'package:suitmedia_apps_zufar/ui/third_screen.dart';

class SecondPage extends StatefulWidget {
  final String message;

  const SecondPage(this.message);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isDataAda = false;
  late Datum? resultData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Second Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.message,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: !isDataAda
                ? const Text(
                    "Selected User Name",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal),
                  )
                : Text(
                    "${resultData!.firstName} ${resultData!.lastName}",
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal),
                  ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: ElevatedButton(
              onPressed: () async {
                var result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThirdPage()));

                setState(() {
                  if (result != null) {
                    resultData = result;
                    isDataAda = true;
                  } else {
                    isDataAda = false;
                  }
                });
              },
              child: const Text(
                "Choose a User",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  primary: secondaryColor,
                  minimumSize: const Size(450, 50)),
            ),
          ),
        ],
      ),
    );
  }
}
