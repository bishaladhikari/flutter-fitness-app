import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController referCodeController = TextEditingController();

  bool _obscureText = true;
  bool _validate = false;

  AnimationController _controller;

  validate() async {
    {
      print("email" + emailController.text.toString());
      if (_formKey.currentState.validate()) {
        try {
          final response = await Repository().registerCustomer(
              fname: fnameController.text,
              lname: lnameController.text,
              email: emailController.text,
              mobile: mobileController.text,
              password: passwordController.text,
              cpassword: cpasswordController.text,
              referCode: referCodeController.text
          );
          print("RegisterRes:" + response.toString());
          _registerSuccess();
        } catch (error) {
          print("ErrorResponse:" + error.errorValue.toString());
          _showErrorMessage(context, error.errorValue);
        }
      } else {
        print("Not Validated");
        setState(() {
          _validate = true;
        });
      }
    }
  }

  void _registerSuccess() {
    Navigator.pushReplacementNamed(context, 'emailConfirmPage',
        arguments: emailController.text);
  }

  void _showErrorMessage(context, String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ));
    authBloc..drainStream();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    authBloc..drainStream();
    _controller.dispose();
    fnameController.dispose();
    lnameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    cpasswordController.dispose();
    passwordController.dispose();
    referCodeController.dispose();
  }

  String validatepass(value) {
    if (value.isEmpty) {
      return "Required*";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.close),
          ),
          title: Text('Create new Account',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body: _buildLoginFormWidget());
  }

  Widget _buildLoginFormWidget() {
    return ListView(children: [
      Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidate: _validate,
              child: Column(
                children: [
                  TextFormField(
                    controller: fnameController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.contact_mail),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "First Name"),
                    validator: validatepass,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: lnameController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.contact_mail),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Last Name"),
                    validator: validatepass,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: mobileController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Mobile Number"),
                    validator: MultiValidator([
                      PatternValidator(
                          r'(^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
                          errorText: 'Not A Valid  Mobile Number')
                    ]),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail_outline),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Email"),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required*"),
                      EmailValidator(errorText: "Not A Valid Email"),
                    ]),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _toggle,
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Password"),
                    obscureText: _obscureText,
                    validator: MultiValidator([
                      PatternValidator(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          errorText:
                          'The Password must include a Lower case, a Upper Case, a digit, a symbol and more than 8 character')
                    ]),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: cpasswordController,
                      style: TextStyle(color: Color(0xFF000000)),
                      cursorColor: Color(0xFF9b9b9b),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: _toggle,
                          ),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Confirm Password"),
                      obscureText: _obscureText,
                      validator: (val) {
                        if (val.isEmpty) return 'Empty';
                        if (val != passwordController.text) return 'Not Match';
                        return null;
                      }),
                ],
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: referCodeController,
              style: TextStyle(color: Color(0xFF000000)),
              cursorColor: Color(0xFF9b9b9b),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  // prefixIcon: const Icon(Icons.mail_outline),
                  border: OutlineInputBorder(),
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Referral Code (Optional)"),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => validate(),
              child: Container(
                height: 50.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    color: NPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Divider(
                          color: Colors.grey,
                          height: 1.0,
                        )),
                    Flexible(
                      flex: 1,
                      child: Text("or"),
                    ),
                    Expanded(
                        flex: 2,
                        child: Divider(
                          color: Colors.grey,
                          height: 1.0,
                        ))
                  ],
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.all(4.0),
                  height: 50.0,
                  width: (MediaQuery
                      .of(context)
                      .size
                      .width) / 2.4,
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: NPrimaryColor, width: 1.0),
                        top: BorderSide(color: NPrimaryColor, width: 1.0),
                        right: BorderSide(color: NPrimaryColor, width: 1.0),
                        left: BorderSide(color: NPrimaryColor, width: 1.0),
                      ),
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/fb.png",
                        height: 25.0,
                      ),
                      Expanded(
                          child: Text("Facebook",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.all(4.0),
                  height: 50.0,
                  width: (MediaQuery
                      .of(context)
                      .size
                      .width) / 2.4,
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: NPrimaryColor, width: 1.0),
                        top: BorderSide(color: NPrimaryColor, width: 1.0),
                        right: BorderSide(color: NPrimaryColor, width: 1.0),
                        left: BorderSide(color: NPrimaryColor, width: 1.0),
                      ),
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/google.png",
                        height: 25.0,
                      ),
                      Expanded(
                          child: Text("Google",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0))),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed('loginPage');
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(10.0),
                height: 50.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1.0),
                      top: BorderSide(color: Colors.grey, width: 1.0),
                      right: BorderSide(color: Colors.grey, width: 1.0),
                      left: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(child: Text("Have an Account? Sign In")),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
