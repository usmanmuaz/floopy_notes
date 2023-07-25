import 'package:floopy_notes/resources/button.dart';
import 'package:floopy_notes/resources/colors.dart';
import 'package:floopy_notes/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

final nameCTRL = TextEditingController();
final _formKey = GlobalKey<FormState>();
bool autoValidate = false;

class _NameScreenState extends State<NameScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: purple,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/floopy_notes_logo.png",
                  height: size.height * 0.07,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: "Enter your ",
                ),
                TextSpan(
                  text: "Beautiful ",
                  style: TextStyle(color: pink, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "name",
                ),
              ])),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                autovalidateMode: autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: TextFormField(
                  controller: nameCTRL,
                  cursorColor: purple,
                  decoration: InputDecoration(
                    hintText: "Enter your Beautiful name",
                    hintStyle:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: green, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: pink, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: red, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your name";
                    } else if (value.length < 5) {
                      return "Name should be greater than 5";
                    } else if (value.length >= 11) {
                      return "Name should be less than 10 letters";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                  onPress: () async {
                    setState(() {
                      autoValidate = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setString("name", nameCTRL.text);
                      sp.setBool("userRegistered", true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    name: sp.getString('name'),
                                  )));
                    } else {}
                  },
                  name: "Continue"),
            ],
          ),
        ),
      ),
    );
  }
}
