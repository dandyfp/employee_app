import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:employe_app/src/data/auth_datasource.dart';
import 'package:employe_app/src/presentation/helper/methods.dart';
import 'package:employe_app/src/presentation/helper/navigator_helper.dart';
import 'package:employe_app/src/presentation/helper/validator.dart';
import 'package:employe_app/src/presentation/pages/auth/register_page.dart';
import 'package:employe_app/src/presentation/pages/home/home_page.dart';
import 'package:employe_app/src/presentation/widgets/button.dart';
import 'package:employe_app/src/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

AuthDataSource authDataSource = AuthDataSource();

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  bool isLogin = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      checkUser();
      setState(() {});
    });
    super.initState();
  }

  void checkUser() {
    String? id = AuthDataSource().getInLoggedUser();
    if (id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(300),
                KTextField(
                  label: 'Email',
                  maxLines: 1,
                  minLines: 1,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  borderColor: Colors.grey,
                  validator: Validator.emailValidator.call,
                ),
                verticalSpace(10),
                KTextField(
                  label: 'Password',
                  maxLines: 1,
                  minLines: 1,
                  obscure: isObscure,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  borderColor: Colors.grey,
                  validator: Validator.passwordValidator.call,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                verticalSpace(30),
                Button(
                  isLoading: isLogin,
                  isDisabled: isLogin,
                  onPressed: () async {
                    setState(() {
                      isLogin = true;
                    });
                    var result = await authDataSource.login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    result.fold(
                      (l) {
                        setState(() {
                          isLogin = false;
                        });
                      },
                      (r) {
                        setState(
                          () {
                            isLogin = false;
                            AnimatedSnackBar.material('Success login',
                                    type: AnimatedSnackBarType.success)
                                .show(context);
                            NavigatorHelper.pushAndRemoveUntil(
                              context,
                              const HomePage(),
                              (route) => false,
                            );
                          },
                        );
                      },
                    );
                  },
                  child: const Center(
                    child: Text('Login'),
                  ),
                ),
                verticalSpace(20),
                TextButton(
                  onPressed: () {
                    NavigatorHelper.push(context, const RegisterPage());
                  },
                  child: const Text(
                    'Register',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
