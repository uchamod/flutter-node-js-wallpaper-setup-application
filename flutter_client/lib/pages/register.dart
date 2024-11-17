import 'package:flutter/material.dart';
import 'package:flutter_client/router/router_names.dart';
import 'package:flutter_client/services/auth_services.dart';
import 'package:flutter_client/util/constants.dart';
import 'package:flutter_client/widget/reusable_button.dart';
import 'package:flutter_client/widget/reusable_textfiled.dart';
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  bool isLoading = false;
  //register user
  void registerUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final userData = await _authServices.registerUser(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text);
      GoRouter.of(context).goNamed(RouterNames.login);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Registration successful. Please log in.",
            style: TextStyle(color: secondoryColor)),
        backgroundColor: primaryColor,
      ));
      clearControllers();
      print(userData);
    } catch (err) {
      print("error ${err}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went wrong.",
            style: TextStyle(color: secondoryColor)),
        backgroundColor: primaryColor,
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void clearControllers() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
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
                //register form
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //name
                        ReusableTextfiled(
                          controller: _nameController,
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.next,
                          isShow: false,
                          hint: "Name",
                          validchecker: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your name";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: gap),
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
                        //register button
                        GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                registerUser(context);
                              }
                            },
                            child: ReusableButton(
                                lable: "Register", isLoad: isLoading)),
                        const SizedBox(
                          height: 50,
                        ),
                        //navigate to login page
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: secondoryColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  GoRouter.of(context)
                                      .goNamed(RouterNames.login);
                                },
                                child: const Text(
                                  "Log In",
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
