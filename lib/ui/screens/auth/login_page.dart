import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/logic/blocs/auth/bloc/auth_bloc.dart';
import 'package:mitrevels22/logic/blocs/user/bloc/user_bloc.dart';
import 'package:mitrevels22/logic/cubits/token/cubit/token_cubit.dart';
import 'package:mitrevels22/logic/router.dart';

import '../../widgets/test_form_field.dart';

class LoginPage extends StatefulWidget {
  final RevelsAppState appState;
  const LoginPage({Key? key, required this.appState}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Map<String, dynamic> _errors = {};

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        await Future.delayed(const Duration(milliseconds: 200));
        return true;
      },
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: const Text(
            "Log In",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: AutofillGroup(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                context.read<TokenCubit>().updateToken(state.user.token);
                context.read<UserBloc>().add(LoadUser(user: state.user));
                widget.appState.authPage = null;
              }
              if (state is LoginError) {
                if (state.error != null) {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      elevation: 4,
                      contentTextStyle: GoogleFonts.cabin(color: Colors.white),
                      content: Text(state.error!),
                      backgroundColor: NeumorphicTheme.baseColor(context),
                      actions: [
                        TextButton(
                          onPressed: () => ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner(),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
                if (state.validationErrors != null) {
                  setState(() {
                    _errors = state.validationErrors as Map<String, dynamic>;
                  });
                }
              }
              if (state is ForgotPasswordError) {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    elevation: 4,
                    contentTextStyle: GoogleFonts.cabin(color: Colors.white),
                    content: Text(state.error!),
                    backgroundColor: NeumorphicTheme.baseColor(context),
                    actions: [
                      TextButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner(),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              }
              if (state is ForgotPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    backgroundColor: NeumorphicTheme.baseColor(context),
                    content: Text(
                      state.message ?? "Link sent. Please check your email.",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              if (state is ResendVerificationError) {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    elevation: 4,
                    contentTextStyle: GoogleFonts.cabin(color: Colors.white),
                    content: Text(state.error),
                    backgroundColor: NeumorphicTheme.baseColor(context),
                    actions: [
                      TextButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner(),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              }
              if (state is ResendVerificationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    backgroundColor: NeumorphicTheme.baseColor(context),
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Form(
                onWillPop: () async {
                  if (state is AuthLoading) {
                    state.cancelToken.cancel();
                  }
                  return true;
                },
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  children: [
                    NeumorphicTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textStyle: const TextStyle(color: Colors.white),
                      hintText: "Email",
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      controller: _emailController,
                      errorText: _errors['email'],
                    ),
                    NeumorphicTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textStyle: const TextStyle(color: Colors.white),
                      hintText: "Password",
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      controller: _passwordController,
                      errorText: _errors['password'],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _errors = {};
                          });
                          if (_emailController.text.isNotEmpty) {
                            context.read<AuthBloc>().add(
                                  ForgotPasswordEvent(
                                    email: _emailController.text.trim(),
                                  ),
                                );
                          } else {
                            setState(() {
                              _errors['email'] = "Email cannot be empty";
                            });
                          }
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: state is AuthLoading
                            ? const NeumorphicProgressIndeterminate()
                            : NeumorphicButton(
                                onPressed: () {
                                  setState(() {
                                    _errors = {};
                                  });
                                  if (_emailController.text.isEmpty) {
                                    setState(() {
                                      _errors['email'] = 'Email is required';
                                    });
                                  } else if (_passwordController.text.isEmpty ||
                                      _passwordController.text.length < 8) {
                                    setState(() {
                                      _errors['password'] =
                                          'Password must be at least 8 characters';
                                    });
                                  } else {
                                    context.read<AuthBloc>().add(
                                          LoginEvent(
                                            email: _emailController.text.trim(),
                                            password:
                                                _passwordController.text.trim(),
                                          ),
                                        );
                                  }
                                },
                                padding: EdgeInsets.zero,
                                style: const NeumorphicStyle(
                                  boxShape: NeumorphicBoxShape.circle(),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF70C2BC),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.appState.authPage = AuthPages.signup;
                      },
                      child: Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _errors = {};
                        });
                        if (_emailController.text.isNotEmpty) {
                          context.read<AuthBloc>().add(
                                ResendVerificationEvent(
                                  email: _emailController.text.trim(),
                                ),
                              );
                        } else {
                          setState(() {
                            _errors['email'] = "Email cannot be empty";
                          });
                        }
                      },
                      child: Text(
                        "Resend Verification Email",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
