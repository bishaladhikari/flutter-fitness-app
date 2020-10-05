import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../constants.dart';
// import 'pattern_validation_container.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddressPage(),
    ));

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  bool state = true;
  FocusNode _nameFocus = FocusNode();
  FocusNode _mobileFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _zipFocus = FocusNode();
  FocusNode _houseFocus = FocusNode();
  FocusNode _cityFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void validate() {
    if (formkey.currentState.validate()) {
      print("Validated");
    } else {
      print("Not Validated");
    }
  }

  String validatepass(value) {
    if (value.isEmpty) {
      return "Required*";
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _nameFocus = new FocusNode();
    _nameFocus.addListener(requestFocus);
    _mobileFocus = new FocusNode();
    _mobileFocus.addListener(requestFocus);
    _emailFocus = new FocusNode();
    _emailFocus.addListener(requestFocus);
    _zipFocus = new FocusNode();
    _zipFocus.addListener(requestFocus);
    _houseFocus = new FocusNode();
    _houseFocus.addListener(requestFocus);
    _cityFocus = new FocusNode();
    _cityFocus.addListener(requestFocus);
    _addressFocus = new FocusNode();
    _addressFocus.addListener(requestFocus);
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _mobileFocus.dispose();
    _emailFocus.dispose();
    _zipFocus.dispose();
    _houseFocus.dispose();
    _cityFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  void requestFocus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          // * leading: new Padding(
          // padding: const EdgeInsets.only(top: 16.0, left: 10.0),
          // child: new Text(
          // 'Cancel',
          // style: TextStyle(color: Colors.black, fontSize: 15),
          // )),*
          title: new Text(
            'Add New Address',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: SingleChildScrollView(
                child: Form(
              autovalidate: true,
              key: formkey,
              child: Column(children: <Widget>[
                TextFormField(
                  focusNode: _nameFocus,
                  decoration: InputDecoration(
                    fillColor: NPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: NPrimaryColor),
                    ),
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey),
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(
                        color:
                            _nameFocus.hasFocus ? NPrimaryColor : Colors.grey),
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: validatepass,
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                    focusNode: _mobileFocus,
                    decoration: InputDecoration(
                      fillColor: NPrimaryColor,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: NPrimaryColor),
                      ),
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey),
                      ),
                      labelText: "Contact",
                      labelStyle: TextStyle(
                          color: _mobileFocus.hasFocus
                              ? NPrimaryColor
                              : Colors.grey),
                      hintText: "Mobile Number",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: MultiValidator([
                      PatternValidator(
                          r'(^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
                          errorText: 'Not A Valid  Mobile Number')
                    ])),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  focusNode: _emailFocus,
                  decoration: InputDecoration(
                    fillColor: NPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: NPrimaryColor),
                    ),
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                        color:
                            _emailFocus.hasFocus ? NPrimaryColor : Colors.grey),
                    hintText: "Email Address",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required*"),
                    EmailValidator(errorText: "Not A Valid Email"),
                  ]),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                    focusNode: _zipFocus,
                    decoration: InputDecoration(
                      fillColor: NPrimaryColor,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: NPrimaryColor),
                      ),
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey),
                      ),
                      labelText: "Zipcode",
                      labelStyle: TextStyle(
                          color:
                              _zipFocus.hasFocus ? NPrimaryColor : Colors.grey),
                      hintText: "Zip-Code",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: MultiValidator([
                      PatternValidator(
                          r'(^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
                          errorText: 'Not A Valid Code Number')
                    ])),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  focusNode: _houseFocus,
                  decoration: InputDecoration(
                    fillColor: NPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: NPrimaryColor),
                    ),
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey),
                    ),
                    labelText: "House",
                    labelStyle: TextStyle(
                        color:
                            _houseFocus.hasFocus ? NPrimaryColor : Colors.grey),
                    hintText: "House",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: validatepass,
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  focusNode: _cityFocus,
                  decoration: InputDecoration(
                    fillColor: NPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: NPrimaryColor),
                    ),
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey),
                    ),
                    labelText: "City",
                    labelStyle: TextStyle(
                        color:
                            _cityFocus.hasFocus ? NPrimaryColor : Colors.grey),
                    hintText: "City",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: validatepass,
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  focusNode: _addressFocus,
                  decoration: InputDecoration(
                    fillColor: NPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: NPrimaryColor),
                    ),
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey),
                    ),
                    labelText: "Address",
                    labelStyle: TextStyle(
                        color: _addressFocus.hasFocus
                            ? NPrimaryColor
                            : Colors.grey),
                    hintText: "Address",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: validatepass,
                ),
                SizedBox(
                  height: 25.0,
                ),
                PrefectureDropdown(),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Make a Default Shipping Address',
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          Switch(
                              value: true,
                              onChanged: (bool s) {
                                setState(() {
                                  state = s;
                                  print(state);
                                });
                              }),
                        ])),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Make a Default Billing Address',
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          Switch(
                              value: true,
                              onChanged: (bool s) {
                                setState(() {
                                  state = s;
                                  print(state);
                                });
                              }),
                        ])),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                GestureDetector(
                  onTap: validate,
                  child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: Center(
                          child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))),
                )
              ]),
            ))));
  }
}

class PrefectureDropdown extends StatefulWidget {
  PrefectureDropdown({Key key}) : super(key: key);

  @override
  _PrefectureDropdownState createState() => _PrefectureDropdownState();
}

class _PrefectureDropdownState extends State<PrefectureDropdown> {
  String dropdownValue = null;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          hintText: "Prefecture",
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          labelText: "Prefecture"),
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black),
      onChanged: (String newValue) {
        setState(
          () {
            dropdownValue = newValue;
          },
        );
      },
      items: <String>[
        '北海道',
        '青森県',
        '岩手県',
        '宮城県',
        '秋田県',
        '山形県',
        '福島県',
        '茨城県',
        '栃木県',
        '群馬県',
        '埼玉県',
        '千葉県',
        '東京都',
        '神奈川県',
        '山梨県',
        '新潟県',
        '長野県',
        '岐阜県',
        '静岡県',
        '愛知県',
        '三重県',
        '富山県',
        '石川県',
        '福井県',
        '滋賀県',
        '京都府',
        '大阪府',
        '兵庫県',
        '奈良県',
        '和歌山県',
        '鳥取県',
        '島根県',
        '岡山県',
        '広島県',
        '山口県',
        '徳島県',
        '香川県',
        '愛媛県',
        '高知県',
        '熊本県',
        '福岡県',
        '佐賀県',
        '長崎県',
        '熊本県',
        '大分県',
        '宮崎県',
        '鹿児島県'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
