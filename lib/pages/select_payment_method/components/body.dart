import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/cart_bloc.dart';
import 'package:ecapp/bloc/checkout_bloc.dart';
import 'package:ecapp/bloc/loyalty_point_bloc.dart';
import 'package:ecapp/models/response/loyalty_point_response.dart';
import 'package:ecapp/models/response/email_confirm_response.dart';
import 'package:ecapp/models/response/redeem_point_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../constants.dart';

class SelectPaymentBody extends StatefulWidget {
  @override
  _SelectPaymentBodyState createState() => _SelectPaymentBodyState();
}

class _SelectPaymentBodyState extends State<SelectPaymentBody> {
  int rewardPoints = 10;
  bool triggerCheckbox = false;
  bool _validate = false;
  bool showPaymentMethods = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController redeemPointController = TextEditingController();
  String redeem_amount = "0";
  bool showRedeemAmount = false;

  @override
  void initState() {
    loyaltyPointBloc
      ..getLoyaltyPoint(
          cartBloc.subject.value.cartSummary.totalAmount.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    loyaltyPointBloc.drainStream();
    redeemPointController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black.withOpacity(.01),
        child: Column(
          children: [
//           rewardPoints > 0
//               ? Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   color: Colors.white,
//                   child: StreamBuilder<LoyaltyPointResponse>(
//                       stream: loyaltyPointBloc.subject.stream,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           return Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     tr('You currently have ' +
//                                         snapshot.data.points.toString() +
//                                         ' Reward Points to spend.'),
//                                     style: TextStyle(
//                                         color: Colors.black45,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 'You can use your reward points and card payment/ cash on delivery options simultaneously.',
//                                 style: TextStyle(
//                                     color: Colors.black45,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 height: 2,
//                               ),
//                               Row(
//                                 children: [
//                                   triggerCheckbox
//                                       ? IconButton(
//                                           color: NPrimaryColor,
//                                           onPressed: () {
//                                             print('clicked');
//
//                                             setState(() {
//                                               triggerCheckbox = false;
//                                             });
//                                           },
//                                           icon: Icon(Icons.check_box),
//                                         )
//                                       : IconButton(
//                                           color: NPrimaryColor,
//                                           onPressed: () {
//                                             setState(() {
//                                               triggerCheckbox = true;
//                                             });
//                                           },
//                                           icon: Icon(
//                                               Icons.check_box_outline_blank),
//                                         ),
//                                 ],
//                               ),
//                               triggerCheckbox
//                                   ? Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Container(
// //                                width: double.infinity/2,
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 8),
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.black54)),
//                                           child: TextField(
//                                             decoration: InputDecoration(
//                                                 border: InputBorder.none,
//                                                 hintText: 'Amount'),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 3,
//                                         ),
//                                         RaisedButton(
//                                           color: NPrimaryColor,
//                                           textColor: Colors.white,
//                                           elevation: .2,
//
// //                                  ,
//                                           onPressed: () {
//                                             Fluttertoast.showToast(
// //                                        i,
//                                                 msg: "Redeem Successful",
//                                                 toastLength: Toast.LENGTH_SHORT,
//                                                 gravity: ToastGravity.BOTTOM,
//                                                 timeInSecForIosWeb: 1,
//                                                 backgroundColor: NPrimaryColor,
//                                                 textColor: Colors.white,
//                                                 fontSize: 14.0);
//                                           },
//                                           child: Text('Redeem'),
//                                         ),
//                                         Container(
//                                           width: double.infinity,
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 10, vertical: 10),
//                                           color: NPrimaryColor.withOpacity(.2),
//                                           child: Text(
//                                             'Note: 1 reward point is equal to ¥1',
//                                             style: TextStyle(
//                                                 color: Colors.black45,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   : SizedBox(),
//                             ],
//                           );
//                         } else {
//                           return Container();
//                         }
//                       }),
//                 )
//               : Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   color: Colors.white,
//                   child: Text(
//                     'Sorry! You have no reward points',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.black.withOpacity(.01),
              child: Column(
                children: [
                  StreamBuilder<LoyaltyPointResponse>(
                      stream: loyaltyPointBloc.subject.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data.points != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          tr('Reward Points Available:'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " " + snapshot.data.points.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          triggerCheckbox
                                              ? IconButton(
                                                  color: NPrimaryColor,
                                                  onPressed: () {
                                                    setState(() {
                                                      triggerCheckbox = false;
                                                    });
                                                  },
                                                  icon: Icon(Icons.check_box),
                                            alignment: Alignment.centerLeft,
                                                )
                                              : IconButton(
                                                  color: Colors.grey,
                                                  onPressed: () {
                                                    setState(() {
                                                      triggerCheckbox = true;
                                                    });
                                                  },
                                                  icon: Icon(Icons
                                                      .check_box_outline_blank),
                                            alignment: Alignment.centerLeft,
                                          ),
                                          Expanded(
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    triggerCheckbox =
                                                        !triggerCheckbox;
                                                  });
                                                },
                                                child: Text(
                                                  tr("Use my Reward Points to pay for this order"),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 5,
                                              child: Form(
                                                key: formKey,
                                                autovalidate: _validate,
                                                child: TextFormField(
                                                  autofocus: false,
                                                  onChanged: (text) {
                                                    setState(() {
                                                      showRedeemAmount =
                                                          redeemPointController
                                                              .text.isNotEmpty;
                                                      redeem_amount = text
                                                              .isNotEmpty
                                                          ? (double.parse(
                                                                      text) *
                                                                  snapshot.data
                                                                      .rate)
                                                              .toString()
                                                          : "0";
                                                    });
                                                  },
                                                  controller:
                                                      redeemPointController,
                                                  style: TextStyle(
                                                      color: Color(0xFF000000)),
                                                  cursorColor:
                                                      Color(0xFF9b9b9b),
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          signed: false,
                                                          decimal: false),
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        6),
                                                  ],
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      border:
                                                          OutlineInputBorder(),
                                                      contentPadding:
                                                          new EdgeInsets
                                                                  .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10.0),
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      hintText: tr(
                                                          "Redeem Points (Amount)")),
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            "Please enter the amount."),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            showRedeemAmount
                                                ? Text("= ¥ " + redeem_amount,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold))
                                                : Container(),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: RaisedButton(
                                                  color: NPrimaryColor,
                                                  textColor: Colors.white,
                                                  elevation: .2,
                                                  onPressed: () {
                                                    validateRedeemPoint(
                                                        context);
                                                  },
                                                  child: Text('Redeem'),
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      color: NPrimaryColor.withOpacity(.2),
                                      child: Text(
                                        tr('Note: 1 reward point is equal to ¥1'),
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                  ],
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    tr("Currently you don't have any reward points to redeem. Refer your friends or family to get reward points."),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
            showPaymentMethods
                ? _buildPaymentMethodsWidget()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      tr('You have redeemed reward points with amount value equal to ¥{rewardPoints}. Now you can place order.',
                          namedArgs: {
                            "rewardPoints": redeem_amount.toString()
                          }),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsWidget() {
    return Column(children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.black.withOpacity(.01),
        child: Text(
          'Recommended method(s)',
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "cardPaymentPage");
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(
                  "assets/icons/creditdebit.png",
                  scale: 2,
                ),
              ),
              Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Credit/Debit Card",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.asset(
                            "assets/icons/card_type_logo.png",
                            scale: 6,
                          ),
//                            Icon(Icons.home),
                        ],
                      ),
                      Text('Credit/Debit Card'),
                    ],
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  iconSize: 18,
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ))
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.black.withOpacity(.01),
        child: Text(
          'Payment methods',
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "cashOnDeliveryPage");
        },
        child: Container(
          color: Colors.white,
          height: 50,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset("assets/icons/cash_on_delivery.png",
                      scale: 2),
                ),
                Wrap(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("Cash On Delivery"),
                          style: TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    iconSize: 18,
                    onPressed: () {},
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  // void _showRedeemPointWidget(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SingleChildScrollView(
  //           child: Container(
  //             height: MediaQuery.of(context).size.height * .100,
  //             child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Column(
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.all(10.0),
  //                     child: Column(
  //                       children: <Widget>[
  //                         Text(tr("Redeem Point"),
  //                             style:
  //                                 TextStyle(fontSize: 18, color: Colors.black)),
  //                         StreamBuilder<LoyaltyPointResponse>(
  //                             stream: loyaltyPointBloc.subject.stream,
  //                             builder: (context, snapshot) {
  //                               if (snapshot.hasData) {
  //                                 return Container(
  //                                   child: Column(
  //                                     children: [
  //                                       Text(
  //                                         tr(snapshot.data.points.toString() +
  //                                             ' Reward Points to spend.'),
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: 20),
  //                                       ),
  //                                       SizedBox(height: 20.0),
  //                                       Text(
  //                                         'You can use your reward points and card payment/ cash on delivery options simultaneously.',
  //                                         style: TextStyle(
  //                                             color: Colors.black45,
  //                                             fontWeight: FontWeight.bold),
  //                                       ),
  //                                       SizedBox(height: 20.0),
  //                                       Container(
  //                                         width: double.infinity,
  //                                         padding: EdgeInsets.symmetric(
  //                                             horizontal: 10, vertical: 10),
  //                                         color: NPrimaryColor.withOpacity(.2),
  //                                         child: Text(
  //                                           'Note: 1 reward point is equal to ¥1',
  //                                           style: TextStyle(
  //                                               color: Colors.black45,
  //                                               fontWeight: FontWeight.bold),
  //                                         ),
  //                                       ),
  //                                       SizedBox(height: 10.0),
  //                                       Form(
  //                                         key: formKey,
  //                                         autovalidate: _validate,
  //                                         child: TextFormField(
  //                                           controller: redeemPointController,
  //                                           style: TextStyle(
  //                                               color: Color(0xFF000000)),
  //                                           cursorColor: Color(0xFF9b9b9b),
  //                                           keyboardType: TextInputType.text,
  //                                           decoration: InputDecoration(
  //                                               border: OutlineInputBorder(),
  //                                               contentPadding:
  //                                                   new EdgeInsets.symmetric(
  //                                                       vertical: 10.0,
  //                                                       horizontal: 10.0),
  //                                               hintStyle: TextStyle(
  //                                                   color: Colors.grey),
  //                                               hintText:
  //                                                   "Redeem Points (Amount)"),
  //                                           validator: MultiValidator([
  //                                             RequiredValidator(
  //                                                 errorText:
  //                                                     "Please enter the amount."),
  //                                           ]),
  //                                         ),
  //                                       ),
  //                                       SizedBox(
  //                                         width: double.infinity,
  //                                         child: RaisedButton(
  //                                           color: NPrimaryColor,
  //                                           textColor: Colors.white,
  //                                           elevation: .2,
  //                                           onPressed: () {
  //                                             validateRedeemPoint(context);
  //                                           },
  //                                           child: Text('Redeem'),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 );
  //                               } else {
  //                                 return Container();
  //                               }
  //                             }),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //       enableDrag: false);
  // }

  validateRedeemPoint(BuildContext context) async {
    if (formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
//      redeemPointController.
      showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.white70,
          builder: (context) => Center(child: CircularProgressIndicator()));
      RedeemPointResponse response = await loyaltyPointBloc.redeemPoints({
        "redeem_value": "${redeemPointController.text}",
        "final_total": checkoutBloc.finalTotalAmount,
        "total": checkoutBloc.totalAmount
      });
      if (response.error == null)
        setState(() {
          showPaymentMethods =
              response.amountValue < checkoutBloc.finalTotalAmount;
        });
      else
        setState(() {
          showPaymentMethods = true;
        });
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: response.error == null
              ? tr("Redeem Successful")
              : tr(response.error),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: response.error == null ? Colors.green : Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

//      if (response.error == null) {
//        redeemPointController.clear();
//      }
    } else {
      setState(() => _validate = true);
    }
  }
}
