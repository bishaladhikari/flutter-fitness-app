import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  FocusNode _focusNode;
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
    _focusNode = new FocusNode();
    _focusNode.addListener(requestFocus);
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
                  focusNode: _focusNode,
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
                            _focusNode.hasFocus ? NPrimaryColor : Colors.grey),
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: validatepass,
                ),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: "Mobile",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Contact*"),
                    validator: MultiValidator([
                      PatternValidator(
                          r'(^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
                          errorText: 'Not A Valid  Mobile Number')
                    ])),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Email"),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required*"),
                    EmailValidator(errorText: "Not A Valid Email"),
                  ]),
                ),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: "Zip-Code",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: "Zipcode"),
                    validator: MultiValidator([
                      PatternValidator(
                          r'(^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$)',
                          errorText: 'Not A Valid Code Number')
                    ])),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: " House",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "House"),
                  validator: validatepass,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "City",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "city"),
                  validator: validatepass,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Address",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Address"),
                  validator: validatepass,
                ),
                PrefectureDropdown(),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 120, 20),
                  child: Text(
                    "Select a label for effective delivery",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                Row(children: <Widget>[
                  Container(
                      margin: new EdgeInsets.symmetric(horizontal: 50.0),
                      height: 50,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                          child: Row(children: <Widget>[
                        Container(
                          height: 30.0,
                          child: SvgPicture.asset("assets/icons/home.svg"),
                          // width: MediaQuery.of(context).size.width*0.15
                          width: 15.0,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                        ),
                        Text(
                          'Home',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      ]))),
                  Expanded(
                    child: Container(
                        margin: new EdgeInsets.symmetric(horizontal: 50.0),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                            child: Row(children: <Widget>[
                          Container(
                            height: 30.0,
                            child: SvgPicture.asset("assets/icons/menu.svg"),
                            // width: MediaQuery.of(context).size.width*0.15
                            width: 15.0,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                          ),
                          Text(
                            'Office',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ]))),
                  ),
                ]),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 133, 0),
                  child: Text(
                    "Make a default shipping address",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 157, 20),
                  child: Text(
                    "Make a default biling address",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
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
