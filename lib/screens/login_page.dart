import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/models/database_helper.dart';
import 'package:flutter_plactical_icoderz/screens/register_page.dart';
import 'package:flutter_plactical_icoderz/screens/screen_handler.dart';
import 'package:flutter_plactical_icoderz/widget/custom_button.dart';
import 'package:flutter_plactical_icoderz/widget/input_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          key: _scaffoldKey,
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
                      Text("NewsZ Login",
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
                                hintText: "Email ID",
                                ot: false,
                                controller: EmailController,
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
                        text: "Login",
                        function: () async {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            var result = await dbHelper.getLogin(
                                EmailController.text.trim(),
                                PasswordController.text.trim());
                            if (result == null) {
                              var snackBar = SnackBar(
                                  content:
                                      Text('Please Check ID And Password'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setBool("LoggedIN", true);
                              pref.setInt("id", result);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScreenHandler()));
                            }
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
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          "Not Have an Account? Create Now",
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
