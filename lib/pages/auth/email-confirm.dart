import 'package:ecapp/constants.dart';
import 'package:flutter/material.dart';

class EmailConfirmPage extends StatefulWidget {
  @override
  _EmailConfirmState createState() => _EmailConfirmState();
}

class _EmailConfirmState extends State<EmailConfirmPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text('Confirm Your Email',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          backgroundColor: Colors.white,
        ),
        body: _buildVerifyFormWidget());
  }

  Widget _buildVerifyFormWidget() {
    return ListView(children: [
      Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Please, enter Verifiction Code that we have sent you in your mail",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                  textAlign: TextAlign.center),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.code),
                        border: OutlineInputBorder(),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Verification Code"),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => (context),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: NPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                    child: Text(
                  "Verify",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("OR"),
            ),
            Align(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "If you haven't received the Verifiction Code yet",
                    style: TextStyle(color: Colors.black87),
                  ),
                )
              ],
            )),
            GestureDetector(
              onTap: () => (context),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: NPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                    child: Text(
                  "Resend Code",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
