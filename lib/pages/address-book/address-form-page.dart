import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/address_bloc.dart';
import 'package:ecapp/models/address.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:ecapp/widgets/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rxdart/rxdart.dart';
import '../../constants.dart';
import 'package:flutter/services.dart';

class AddressFormPage extends StatefulWidget {
  final Address address;

  AddressFormPage({this.address = null});

  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  List<String> prefecture = [
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
    '鹿児島県',
  ];

  bool state = true;
  bool defaultAddress = false;
  String prefectureValue = null;

  FocusNode _nameFocus = FocusNode();
  FocusNode _mobileFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _zipFocus = FocusNode();
  FocusNode _houseFocus = FocusNode();
  FocusNode _cityFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  BehaviorSubject _loadingController;

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

    nameController = TextEditingController(
        text: widget.address == null ? "" : widget.address.name);
    phoneController = TextEditingController(
        text: widget.address == null ? "" : widget.address.phone);
    emailController = TextEditingController(
        text: widget.address == null ? "" : widget.address.email);
    zipController = TextEditingController(
        text: widget.address == null ? "" : widget.address.zipCode);
    houseController = TextEditingController(
        text: widget.address == null ? "" : widget.address.house);
    cityController = TextEditingController(
        text: widget.address == null ? "" : widget.address.city);
    addressController = TextEditingController(
        text: widget.address == null ? "" : widget.address.address);
    prefectureValue = widget.address == null
        ? null
        : (prefecture.contains(widget.address.prefecture)
            ? widget.address.prefecture
            : null);
    defaultAddress = widget.address == null ? false : widget.address.isDefault;
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
          title: Text(
            tr(widget.address == null ? 'Add New Address' : ' Edit Address'),
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
                        labelText: tr("Full Name"),
                        labelStyle: TextStyle(
                            color: _nameFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
                        // hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: validatePass,
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    TextFormField(
                        focusNode: _mobileFocus,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                          labelText: tr("Mobile Number"),
                          labelStyle: TextStyle(
                              color: _mobileFocus.hasFocus
                                  ? NPrimaryColor
                                  : Colors.grey),
                          // hintText: tr("Mobile Number"),
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
                        labelText: tr("Email"),
                        labelStyle: TextStyle(
                            color: _emailFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
                        // hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "You cannot leave this empty *"),
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
                          labelText: tr("Zipcode"),
                          labelStyle: TextStyle(
                              color: _zipFocus.hasFocus
                                  ? NPrimaryColor
                                  : Colors.grey),
                          // hintText: "Zip-Code",
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
                        labelText: tr("House"),
                        labelStyle: TextStyle(
                            color: _houseFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
                        // hintText: "House",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: validatePass,
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
                        labelText: tr("City"),
                        labelStyle: TextStyle(
                            color: _cityFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
                        // hintText: "City",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: validatePass,
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
                        labelText: tr("Address"),
                        labelStyle: TextStyle(
                            color: _addressFocus.hasFocus
                                ? NPrimaryColor
                                : Colors.grey),
                        // hintText: "Address",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: validatePass,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: tr("Prefecture"),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            labelText: tr("Prefecture")),
                        value: prefectureValue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        onChanged: (String newValue) {
                          setState(
                            () {
                              prefectureValue = newValue;
                            },
                          );
                        },
                        items: prefecture
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    widget.address != null
                        ? Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    tr('Make a Default Address'),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  Spacer(),
                                  Switch(
                                      value: defaultAddress,
                                      onChanged: (bool state) async {
                                        var response;
                                        print("state" + state.toString());
                                        if (state) {
                                          response = await addressBloc
                                              .setDefaultAddress(
                                                  widget.address);
                                          if (response.error == null)
                                            setState(() {
                                              defaultAddress = true;
                                            });
                                          Fluttertoast.showToast(
                                              msg: tr(response.error),
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.redAccent,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else
                                          Fluttertoast.showToast(
                                              msg: tr(
                                                  "Sorry to turn off default address, please set another address as default"),
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.6),
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        //
                                        // if (response.error == null)
                                        //   state = !state;
                                        // setState(() {
                                        //   defaultAddress = state;
                                        // });
                                      }),
                                ]))
                        : Container(),
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
                prefecture: prefectureValue,
                phone: phoneController.text)
            .then((value) {
          _loadingController.sink.add(false);
          addressBloc.getAddresses();
          Navigator.of(context).pop();
        }).catchError((value) {
          _loadingController.sink.add(false);
        });
      } else {
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
              prefecture: prefectureValue,
              phone: phoneController.text)
          .then((value) {
        _loadingController.sink.add(false);
        addressBloc.getAddresses();
        Navigator.of(context).pop();
      }).catchError((value) {
        _loadingController.sink.add(false);
      });
    }
  }

  String validatePass(value) {
    if (value.isEmpty) {
      return "You cannot leave this empty *";
    } else {
      return null;
    }
  }
}
