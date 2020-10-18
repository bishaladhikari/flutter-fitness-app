import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Form field to edit a credit card number, with validation.
class CustomCardNumberFormField extends StatefulWidget {
  CustomCardNumberFormField(
      {Key key,
        this.initialValue,
        @required this.onSaved,
        @required this.validator,
        this.onChanged,
        this.decoration = defaultDecoration,
        this.textStyle = defaultTextStyle,
        this.textEditingController})
      : super(key: key);

  final void Function(String) onSaved;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final String initialValue;
  final InputDecoration decoration;
  final TextStyle textStyle;
  final TextEditingController textEditingController;

  static const defaultLabelText = 'Card number';
  static const defaultHintText = 'xxxx xxxx xxxx xxxx';
  static const defaultErrorText = 'Invalid card number';

  static const defaultDecoration = InputDecoration(
    border: OutlineInputBorder(),
    labelText: defaultLabelText,
    hintText: defaultHintText,
  );
  static const defaultTextStyle = TextStyle(color: Colors.black);

  @override
  _CustomCardNumberFormFieldState createState() => _CustomCardNumberFormFieldState();
}

class _CustomCardNumberFormFieldState extends State<CustomCardNumberFormField> {
  final maskFormatter = MaskTextInputFormatter(mask: '#### #### #### ####');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        initialValue: widget.initialValue,
        controller: widget.textEditingController,
        inputFormatters: [maskFormatter],
        autofocus: false,
        autovalidate: false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onChanged: widget.onChanged,
        decoration: widget.decoration,
        style: widget.textStyle,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
      ),
    );
  }
}