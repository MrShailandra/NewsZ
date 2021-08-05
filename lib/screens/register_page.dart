import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/models/database_helper.dart';
import 'package:flutter_plactical_icoderz/models/user.dart';
import 'package:flutter_plactical_icoderz/screens/login_page.dart';
import 'package:flutter_plactical_icoderz/screens/screen_handler.dart';
import 'package:flutter_plactical_icoderz/widget/custom_button.dart';
import 'package:flutter_plactical_icoderz/widget/input_mobile_widget.dart';
import 'package:flutter_plactical_icoderz/widget/input_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;

  //Controllers
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController MobileController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  Map<String, dynamic> _userDataMap = Map<String, dynamic>();
  @override
  void dispose() {
    NameController.dispose();
    EmailController.dispose();
    MobileController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: NameController.text,
      DatabaseHelper.columnMobile: MobileController.text,
      DatabaseHelper.columnEmail: EmailController.text,
      DatabaseHelper.columnPassword: PasswordController.text,
      DatabaseHelper.columnOcc: "Null",
      DatabaseHelper.columnImageOne: _userDataMap['image0'],
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("LoggedIN", true);
    preferences.setInt("id", id);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ScreenHandler()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
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
                      Text("NewsZ Register",
                          style: GoogleFonts.getFont('Teko',
                              fontSize: 45, color: Colors.white)),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
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
                              InputTextWidget(
                                hintText: "Email ID",
                                ot: false,
                                controller: EmailController,
                              ),
                              InputMobileWidget(
                                hintText: "Mobile Number",
                                ot: false,
                                controller: MobileController,
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
                        text: "Register",
                        function: () {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            _insert();
                          } else {
                            print('Form is invalid');
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "already Have an Account? Login Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
