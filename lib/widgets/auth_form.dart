import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  var isLoading;

  AuthForm(this.submitFn, this.isLoading);
  final void Function(
      String email, String password, String username, bool isLogin) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String username = "";
  String password = "";
  var isLogin = true;

  void ifSubmit() {
    //final isValid ;
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.submitFn(email, password, username, isLogin);
      print(email);
      print(username);
      print(password);
    }
    print("could not pass");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
              key: formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return ("Please enter a Valid Email");
                    }
                    return (null);
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "EmailAddress",
                  ),
                  onSaved: (value) {
                    email = value!;
                  },
                ),
                if (!isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ("username must be more than 5 characters");
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    onSaved: (value) {
                      username = value!;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return ("password must be more than 5 characters");
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    child: Text(isLogin ? 'Login' : 'Sign Up'),
                    onPressed: ifSubmit,
                  ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin
                      ? "Create new Account"
                      : "I already have an account"),
                  textColor: Theme.of(context).accentColor,
                )
              ])),
        ),
      ),
    );
  }
}
