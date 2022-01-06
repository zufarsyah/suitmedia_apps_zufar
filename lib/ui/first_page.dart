import 'package:flutter/material.dart';
import 'package:suitmedia_apps_zufar/ui/second_screen.dart';
import 'package:suitmedia_apps_zufar/common/style.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _polidromeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/btn_add_photo.png",
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _polidromeController,
                decoration: InputDecoration(
                  labelText: 'Palindrome',
                  hintText: 'Palindrome',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  String palindrome = _polidromeController.text.toLowerCase();
                  List<int> chars = palindrome.runes.toList();
                  if (_polidromeController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text(
                                'Mohon diisi bagian palindrom sebelum mengecek'),
                          );
                        });
                  } else if (checkpallindrom(chars)) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                '${_polidromeController.text} is a true palindrome'),
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                '${_polidromeController.text} is a false palindrome'),
                          );
                        });
                  }
                },
                child: const Text(
                  "CHECK",
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
                    minimumSize: const Size(500, 50)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text(
                                'Mohon diisi bagian palindrom sebelum berpindah halaman'),
                          );
                        });
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SecondPage(_nameController.text)));
                  }
                },
                child: const Text(
                  "NEXT",
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
                    minimumSize: const Size(500, 50)),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkpallindrom(List<int> chars) {
    for (int i = chars.length - 1, j = 0; i >= chars.length ~/ 2; i--, j++) {
      if (chars[i] != chars[j]) return false;
    }
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _polidromeController.dispose();
    super.dispose();
  }
}
