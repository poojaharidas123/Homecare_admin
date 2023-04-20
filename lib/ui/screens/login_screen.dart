import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homecare_admin/ui/screens/home_screen.dart';
import 'package:homecare_admin/ui/widgets/custom_button.dart';
import 'package:homecare_admin/util/value_validators.dart';
import 'package:homecare_admin/values/values.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../blocs/auth/sign_in/sign_in_bloc.dart';
import '../widgets/custom_alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1543333995-a78aea2eee50?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3000&q=80',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: SizedBox(
              width: 300,
              height: 400,
              child: BlocProvider<SignInBloc>(
                create: (context) => SignInBloc(),
                child: BlocConsumer<SignInBloc, SignInState>(
                  listener: (context, state) {
                    if (state is SignInFailureState) {
                      showDialog(
                        context: context,
                        builder: (context) => const CustomAlertDialog(
                          title: 'Failed',
                          message:
                              'Please check your email and password and try again.',
                          primaryButtonLabel: 'Ok',
                          secondaryButtonLabel: 'Cancel',
                        ),
                      );
                    } else if (state is SignInSuccessState) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            "HomeCare",
                            style: GoogleFonts.dynalight(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: primaryColor,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: emailValidator,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: isObscure,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Enter password';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  isObscure = !isObscure;
                                  setState(() {});
                                },
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            label: 'Login',
                            buttonColor: Color(0xFFAAD013),
                            textColor: Colors.white,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<SignInBloc>(context).add(
                                  SignInEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                            isLoading: state is SignInLoadingState,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
