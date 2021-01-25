import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GoogleSignInButton extends StatelessWidget {
  final Function handleSignIn;
  const GoogleSignInButton({Key key, this.handleSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 48,
      child: FlatButton.icon(
        color: Colors.black12.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        onPressed: handleSignIn,
        icon: Container(
          margin: EdgeInsets.only(right: 15),
          height: 20,
          width: 20,
          child: Image.asset('assets/icons/google.png'),
        ),
        label: Center(
          child: Text(
            "Sign up with Google".tr(),
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
