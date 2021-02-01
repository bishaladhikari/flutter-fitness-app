import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppleSignInButton extends StatelessWidget {
  final Function handleSignIn;
  const AppleSignInButton({Key key, this.handleSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
      child: FlatButton.icon(
        color: Colors.black12.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        onPressed: handleSignIn,
        icon: Container(
          margin: EdgeInsets.only(right: 15, bottom: 5),
          child: Icon(
            FontAwesomeIcons.apple,
          ),
        ),
        label: Center(
          child: Text(
            tr("Sign up with Apple"),
            style: TextStyle(
              fontFamily: 'OpenSans',
              color: Color(0xFF2B2B2B),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
