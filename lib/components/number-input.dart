import 'package:flutter/material.dart';

class NumberInput extends StatefulWidget {
  final int min;
  final int max;
  final int step;
  final int value;
  final VoidCallback onChange;

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
  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.remove, size: 16),
            ),
          ),
          VerticalDivider(),
          Container(
            width: 26,
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, contentPadding: EdgeInsets.zero),
            ),
          ),
          VerticalDivider(),
          InkResponse(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.add, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
