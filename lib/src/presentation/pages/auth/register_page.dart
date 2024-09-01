import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:employe_app/src/data/auth_datasource.dart';
import 'package:employe_app/src/models/request/auth_request.dart';
import 'package:employe_app/src/presentation/helper/methods.dart';
import 'package:employe_app/src/presentation/helper/navigator_helper.dart';
import 'package:employe_app/src/presentation/helper/validator.dart';
import 'package:employe_app/src/presentation/pages/auth/login_page.dart';
import 'package:employe_app/src/presentation/widgets/button.dart';
import 'package:employe_app/src/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

AuthDataSource authDataSource = AuthDataSource();

class _RegisterPageState extends State<RegisterPage> {
  bool isObscure = true;
  bool isRegis = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              verticalSpace(100),
              KTextField(
                label: 'Name',
                maxLines: 1,
                minLines: 1,
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                borderColor: Colors.grey,
                validator: Validator.requiredValidator.call,
              ),
              verticalSpace(10),
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
              verticalSpace(40),
              Button(
                isLoading: isRegis,
                isDisabled: isRegis,
                onPressed: () async {
                  AuthRequest req = AuthRequest(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (formKey.currentState?.validate() ?? false) {
                    isRegis = true;
                    setState(() {});
                    var result = await authDataSource.register(req: req);
                    return result.fold(
                      (l) {
                        isRegis = false;
                        setState(() {});
                      },
                      (r) {
                        isRegis = false;
                        setState(() {
                          nameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          AnimatedSnackBar.material('Success register',
                                  type: AnimatedSnackBarType.success)
                              .show(context);
                        });
                      },
                    );
                  }
                },
                child: const Center(
                  child: Text('Register'),
                ),
              ),
              verticalSpace(20),
              TextButton(
                onPressed: () {
                  NavigatorHelper.push(context, const LoginPage());
                },
                child: const Text(
                  'Login',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
