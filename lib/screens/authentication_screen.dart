import 'package:commitment_tracker/common/components/text_form_field.dart';
import 'package:commitment_tracker/common/tab_item.dart';
import 'package:commitment_tracker/common/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

class AuthenticationScreen extends StatefulWidget {
  final Function onInit;
  final Function selectedTab;
  const AuthenticationScreen({Key key, this.onInit, this.selectedTab}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String error = '';
  bool _isPassword = true;
  bool loading = false;

  void toggleShowPassword() {
    setState(() {
      _isPassword = !_isPassword;
    });
  }

  void onSignIn() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    if (_formKey.currentState != null && _formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _formKey.currentState?.save();
      await UserSecureStorage.setUserCredentials(emailController.text, passwordController.text);
      setState(() {
        loading = false;
      });
      if (widget.onInit != null) widget.onInit();
      if (widget.selectedTab != null)
        widget.selectedTab(TabItem.expansion, isChangeTab: true, hasUser: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 5),
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              'Welcome to Security Demo',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Key in any random email or password for testing',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      MyTextFormField(
                        controller: emailController,
                        info: 'Email',
                        hintText: 'someone@email.com',
                        isEmail: true,
                        isOther: true,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          if (value != null && value.isNotEmpty && !validator.isEmail(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        suffixIcon: emailController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  emailController.clear();
                                },
                                icon: Icon(
                                  Icons.clear,
                                  size: 20,
                                ),
                              )
                            : null,
                      ),
                      MyTextFormField(
                        controller: passwordController,
                        info: 'Password',
                        hintText: 'Your password',
                        isPassword: _isPassword,
                        isOther: true,
                        validator: (value) {
                          if (value != null && value.length < 6) {
                            return "Enter a password with 6+ character long";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () => toggleShowPassword(),
                          icon: Icon(_isPassword ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
                          onPressed: () {
                            onSignIn();
                          },
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      error.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                error,
                                style: TextStyle(color: Colors.red, fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : SizedBox(height: 0.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot your password?',
                            style:
                                TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          "Don't have an account yet? ",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Click here to Register',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
