import 'package:flutter/material.dart';
import 'dart:core';

class NumberInput extends StatefulWidget {
  final int min;
  final int max;
  final int step;
  final int value;
  final Function(int newer, int old) onChange;

  const NumberInput(
      {Key key,
      this.min = -2 ^ (53),
      this.max = 2 ^ (53) - 1,
      this.step = 1,
      this.value = 0,
      this.onChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumberInputState();
  }
}

class _NumberInputState extends State<NumberInput> {
  TextEditingController controller = TextEditingController();

  stepBy(int step) {
    int value = this.widget.value;
    this.change(value + step);
  }

  change(int newer) {
    int value = newer ?? 0;
    if (value >= this.widget.min &&
        value <= this.widget.max &&
        this.widget.onChange != null) {
      this.widget.onChange(value, this.widget.value);
    }
  }

  get compare {
    return this.widget.value <= this.widget.min
        ? -1
        : this.widget.value >= this.widget.max ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.value.toString();
    return Container(
      height: 30,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(221, 221, 221, 1)),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkResponse(
            onTap: this.compare == -1
                ? null
                : () => this.stepBy(-this.widget.step),
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.remove,
                size: 16,
                color: this.compare == -1 ? Colors.grey : Colors.black,
              ),
            ),
          ),
          VerticalDivider(),
          Container(
            width: 26,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none, contentPadding: EdgeInsets.zero),
            ),
          ),
          VerticalDivider(),
          InkResponse(
            onTap:
                this.compare == 1 ? null : () => this.stepBy(this.widget.step),
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.add,
                size: 16,
                color: this.compare == 1 ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
