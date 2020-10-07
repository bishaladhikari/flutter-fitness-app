import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final isAsyncCall;
  final child;

  LoadingIndicator({this.isAsyncCall, this.child});

  @override
  Widget build(BuildContext context) {
    List<Widget> widget = [];
    widget.add(child);
    if (isAsyncCall) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
          Center(child: CircularProgressIndicator())
        ],
      );
      widget.add(modal);
    }
    return Stack(children: widget);
  }
}
