import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/models/database_helper.dart';

import 'package:flutter_plactical_icoderz/widget/custom_button.dart';
import 'package:flutter_plactical_icoderz/widget/input_mobile_widget.dart';
import 'package:flutter_plactical_icoderz/widget/input_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _fetchingData = true;
  File? _image;
//ImagePicker instance.
  final picker = ImagePicker();
  var _imagePath;
  final dbHelper = DatabaseHelper.instance;
  String name = "Hello User";
  String email = "hello@gmail.com";
  String phone = "1234567890";
  String occu = "text";
  String password = "123456789";
  void _query() async {
    setState(() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var id = preferences.getInt("id");
      var result = await dbHelper.getDetails(id!);
      name = result[0]["name"];
      email = result[0]["email"];
      phone = result[0]["mobile"];
      password = result[0]["password"];
      occu = result[0]["occu"];
    });
  }

  _getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(
      () {
        _image = File(image.path);
        _imagePath = image.path;
      },
    );
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
    _query();
    Timer(Duration(seconds: 1), () {
      setState(() {
        _fetchingData = false;
      });
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _userDataMap = Map<String, dynamic>();
  //Controllers
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController MobileController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController occuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setState(() {
      NameController.text = name;
      EmailController.text = email;
      MobileController.text = phone;
      PasswordController.text = password;
      occuController.text = occu;
    });

    void _update() async {
      // row to insert
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: NameController.text,
        DatabaseHelper.columnMobile: MobileController.text,
        DatabaseHelper.columnEmail: EmailController.text,
        DatabaseHelper.columnPassword: PasswordController.text,
        DatabaseHelper.columnOcc: occuController.text,
      };
      final id = await dbHelper.update(row);
      print('Updated row id: $id');
      setState(() {});
      var snackBar =
          SnackBar(content: Text('Profile Updated Please Refresh Page'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return _fetchingData
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color(0xff0052D4),
                        Color(0xff4364F7),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            Text("Edit Profile",
                                style: GoogleFonts.getFont('Teko',
                                    fontSize: 45, color: Colors.white)),
                            GestureDetector(
                              onTap: () {
                                _getImage();
                              },
                              child: Container(
                                child: _image != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Image.file(
                                            _image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.pink,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    InputTextWidget(
                                      hintText: "Name",
                                      ot: false,
                                      controller: NameController,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade100))),
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.grey),
                                        readOnly: true,
                                        validator: (value) => value!.isEmpty
                                            ? 'This filed cannot be blank'
                                            : null,
                                        obscureText: false,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: EmailController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email ID",
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                    ),
                                    InputMobileWidget(
                                      hintText: "Mobile Number",
                                      ot: false,
                                      controller: MobileController,
                                    ),
                                    InputTextWidget(
                                      hintText: "Occupation",
                                      ot: false,
                                      controller: occuController,
                                    ),
                                    InputTextWidget(
                                      hintText: "Password",
                                      ot: true,
                                      controller: PasswordController,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Buttons(
                              text: "Update Profile",
                              function: () {
                                final FormState? form = _formKey.currentState;
                                if (form!.validate()) {
                                  print('Form is valid');
                                  _update();
                                } else {
                                  print('Form is invalid');
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
