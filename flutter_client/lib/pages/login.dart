import 'package:flutter/material.dart';
import 'package:flutter_client/router/router_names.dart';
import 'package:flutter_client/services/auth_services.dart';
import 'package:flutter_client/util/constants.dart';
import 'package:flutter_client/widget/reusable_button.dart';
import 'package:flutter_client/widget/reusable_textfiled.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  bool isLoading = false;
  //user login
  void loginUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      //logged user
      final userData = await _authServices.loginUser(
          email: _emailController.text, password: _passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login successful",style: TextStyle(color: secondoryColor)),
        backgroundColor: primaryColor,
      ));
      //navigate to home page
      GoRouter.of(context).goNamed(RouterNames.home);
      clearControllers();
      print(userData);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid Credentials.Please try again.",style: TextStyle(color: secondoryColor),),
        backgroundColor: primaryColor,
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void clearControllers() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                //title
                const Text(
                  "360° Wallpaper",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: secondoryColor),
                ),
                //image
                Image.asset(
                  "assets/360 (3).png",
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                //login form
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //email
                        ReusableTextfiled(
                          controller: _emailController,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          isShow: false,
                          hint: "Email",
                          validchecker: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: gap,
                        ),
                        //password
                        ReusableTextfiled(
                          controller: _passwordController,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                          isShow: false,
                          hint: "Password",
                          validchecker: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: gap + 10,
                        ),
                        //login button
                        GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                loginUser(context);
                              }
                            },
                            child: ReusableButton(
                                lable: "Log In", isLoad: isLoading)),
                        const SizedBox(
                          height: 70,
                        ),
                        //navigate to login page
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: secondoryColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  GoRouter.of(context)
                                      .goNamed(RouterNames.register);
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      color: secondoryColor),
                                ))
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
