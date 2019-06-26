import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../constant.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: 'phone',
                    decoration: InputDecoration(hintText: '请输入手机号码', icon: Icon(Icons.phone)),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    validators: [
                      FormBuilderValidators.required(errorText: '手机号不能为空'),
                      FormBuilderValidators.pattern(phonePattern.pattern, errorText: '请输入正确的手机号码')
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'password',
                    obscureText: true,
                    decoration: InputDecoration(hintText: '请输入登录密码', icon: Icon(Icons.lock)),
                    validators: [
                      FormBuilderValidators.required(errorText: '密码不能为空'),
                      FormBuilderValidators.minLength(6, errorText: '至少为6位数')
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('登 录', style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      _formKey.currentState.save();
                      if (_formKey.currentState.validate()) {
                        print(_formKey.currentState.value);
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
