import 'package:async_loader/async_loader.dart';
import 'package:ecapp/bloc/address_bloc.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/models/response/address_response.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:ecapp/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rxdart/rxdart.dart';
import '../../constants.dart';
import 'package:flutter/services.dart';
// import 'pattern_validation_container.dart';

class AddressFormPage extends StatefulWidget {
  final Address address;

  AddressFormPage({this.address = null});

  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  bool state = true;
  FocusNode _nameFocus = FocusNode();
  FocusNode _mobileFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _zipFocus = FocusNode();
  FocusNode _houseFocus = FocusNode();
  FocusNode _cityFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController = TextEditingController();
  TextEditingController houseController;
  TextEditingController cityController;
  TextEditingController zipController = TextEditingController();
  TextEditingController prefectureController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  BehaviorSubject _loadingController;

  validate() {
    _loadingController.sink.add(true);
    if (widget.address == null) {
      if (formkey.currentState.validate()) {
        Repository()
            .addAddress(
                name: nameController.text,
                email: emailController.text,
                house: houseController.text,
                city: cityController.text,
                address: addressController.text,
                zipCode: zipController.text,
                prefecture: prefectureController.text,
                phone: phoneController.text)
            .then((value) {
          _loadingController.sink.add(false);
          addressBloc.getAddress();
          Navigator.of(context).pop();
        }).catchError((value) {
          _loadingController.sink.add(false);
        });
      } else {
        print("Not Validated");
        _loadingController.sink.add(false);
        setState(() {
          _autoValidate = true;
        });
      }
    } else {
      Repository()
          .updateAddress(
              id: widget.address.id,
              name: nameController.text,
              email: emailController.text,
              house: houseController.text,
              city: cityController.text,
              address: addressController.text,
              zipCode: zipController.text,
              prefecture: prefectureController.text,
              phone: phoneController.text)
          .then((value) {
        _loadingController.sink.add(false);
        addressBloc.getAddress();
        Navigator.of(context).pop();
      }).catchError((value) {
        _loadingController.sink.add(false);
      });
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
    print(widget.address?.name);
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

    nameController = TextEditingController(
        text: widget.address == null ? "" : widget.address.name);
    phoneController = TextEditingController(
        text: widget.address == null ? "" : widget.address.phone);
    houseController = TextEditingController(
        text: widget.address == null ? "" : widget.address.house);
    cityController = TextEditingController(
        text: widget.address == null ? "" : widget.address.city);
    _loadingController = BehaviorSubject<bool>();
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
    _loadingController.close();
    super.dispose();
  }

  void requestFocus() {
    setState(() {});
  }

  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            'Add New Address',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: StreamBuilder(
          stream: _loadingController.stream,
          initialData: false,
          builder: (_, snap) => LoadingIndicator(
            isAsyncCall: snap.data,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: SingleChildScrollView(
                    child: Form(
                  autovalidate: _autoValidate,
                  key: formkey,
                  child: Column(children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      focusNode: _nameFocus,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        fillColor: NPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: NPrimaryColor),
                        ),
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: _nameFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: validatepass,
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    TextFormField(
                        focusNode: _mobileFocus,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        // inputFormatters: [
                        //   WhitelistingTextInputFormatter.digitsOnly
                        // ],
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
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
                      height: 14.0,
                    ),
                    TextFormField(
                      focusNode: _emailFocus,
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        fillColor: NPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: NPrimaryColor),
                        ),
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: _emailFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required*"),
                        EmailValidator(errorText: "Not A Valid Email"),
                      ]),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    TextFormField(
                        focusNode: _zipFocus,
                        controller: zipController,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          fillColor: NPrimaryColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: NPrimaryColor),
                          ),
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.grey),
                          ),
                          labelText: "Zipcode",
                          labelStyle: TextStyle(
                              color: _zipFocus.hasFocus
                                  ? NPrimaryColor
                                  : Colors.grey),
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
                      controller: houseController,
                      focusNode: _houseFocus,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        fillColor: NPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: NPrimaryColor),
                        ),
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        labelText: "House",
                        labelStyle: TextStyle(
                            color: _houseFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
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
                      controller: cityController,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        fillColor: NPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: NPrimaryColor),
                        ),
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        labelText: "City",
                        labelStyle: TextStyle(
                            color: _cityFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
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
                      controller: addressController,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
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
                                'Make a Default Address',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              Spacer(),
                              Switch(
                                  value: true,
                                  onChanged: (bool s) {
                                    setState(() {
                                      state = s;
                                      print(state);
                                    });
                                  }),
                            ])),
                    // Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    //     child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisSize: MainAxisSize.max,
                    //         children: <Widget>[
                    //           Text(
                    //             'Make a Default Billing Address',
                    //             style: TextStyle(
                    //                 color: Colors.black, fontSize: 17),
                    //           ),
                    //           Switch(
                    //               value: true,
                    //               onChanged: (bool s) {
                    //                 setState(() {
                    //                   state = s;
                    //                   print(state);
                    //                 });
                    //               }),
                    //         ])),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        color: NPrimaryColor,
                        onPressed: validate,
                        child:
                            Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ]),
                ))),
          ),
        ));
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
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
