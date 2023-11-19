import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/data/models/sign_up_request.dart';
import 'package:mitrevels22/logic/blocs/auth/bloc/auth_bloc.dart';
import 'package:mitrevels22/logic/cubits/college_list/cubit/college_list_cubit.dart';
import 'package:mitrevels22/logic/cubits/signup_validation/cubit/signup_validation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitrevels22/logic/router.dart';

import '../../widgets/test_form_field.dart';

class SignUpPage extends StatefulWidget {
  final RevelsAppState appState;
  const SignUpPage({Key? key, required this.appState}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _regnoController = TextEditingController();
  late SignupValidationCubit _signupValidationCubit;
  late CollegeListCubit _collegeListCubit;
  String? _college;

  @override
  void initState() {
    super.initState();
    _signupValidationCubit = SignupValidationCubit();
    _collegeListCubit = CollegeListCubit();
    _collegeListCubit.getColleges();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _courseController.dispose();
    _regnoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text(
          'Create an account',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: AutofillGroup(
        child: BlocConsumer<SignupValidationCubit, SignupValidationState>(
          //TODO: Add listenwhen to both.
          bloc: _signupValidationCubit,
          listener: (context, state) {
            if (state is SignupValidationSuccess) {
              context
                  .read<AuthBloc>()
                  .add(SignupEvent(request: state.signUpRequest));
            }
          },
          builder: (context, state) {
            return BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is SignupSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      backgroundColor: NeumorphicTheme.baseColor(context),
                      content: const Text(
                        'Signup Successful!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                  widget.appState.authPage = AuthPages.login;
                }
                if (state is SignupError) {
                  if (state.error != null) {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        elevation: 4,
                        contentTextStyle:
                            GoogleFonts.cabin(color: Colors.white),
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
                    _signupValidationCubit.addErrors(
                        state.validationErrors as Map<String, dynamic>);
                  }
                }
              },
              builder: (context, stat) {
                return Form(
                  onWillPop: () async {
                    if (stat is AuthLoading) {
                      stat.cancelToken.cancel();
                    }
                    return true;
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    children: [
                      NeumorphicTextFormField(
                        keyboardType: TextInputType.name,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Name',
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        textCapitalization: TextCapitalization.words,
                        autofillHints: const [AutofillHints.name],
                        controller: _nameController,
                        errorText: state is SignupValidationFailure
                            ? state.error['name']
                            : null,
                      ),
                      NeumorphicTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Email',
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        autofillHints: const [AutofillHints.email],
                        controller: _emailController,
                        errorText: state is SignupValidationFailure
                            ? state.error['email']
                            : null,
                      ),
                      NeumorphicTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Password',
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        autofillHints: const [AutofillHints.newPassword],
                        controller: _passwordController,
                        errorText: state is SignupValidationFailure
                            ? state.error['password']
                            : null,
                      ),
                      NeumorphicTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Confirm Password',
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        autofillHints: const [AutofillHints.newPassword],
                        controller: _confirmPasswordController,
                        errorText: state is SignupValidationFailure
                            ? state.error['confirmPassword']
                            : null,
                      ),
                      NeumorphicTextFormField(
                        keyboardType: TextInputType.phone,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Mobile Number',
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        controller: _phoneController,
                        errorText: state is SignupValidationFailure
                            ? state.error['mobileNumber']
                            : null,
                      ),
                      NeumorphicTextFormField(
                        keyboardType: TextInputType.phone,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Registration Number',
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        autofillHints: null,
                        controller: _regnoController,
                        errorText: state is SignupValidationFailure
                            ? state.error['registrationNumber']
                            : null,
                      ),
                      NeumorphicTextFormField(
                        keyboardType: TextInputType.text,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Course',
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        textCapitalization: TextCapitalization.words,
                        autofillHints: null,
                        controller: _courseController,
                        errorText: state is SignupValidationFailure
                            ? state.error['course']
                            : null,
                      ),
                      BlocBuilder<CollegeListCubit, CollegeListState>(
                        bloc: _collegeListCubit,
                        builder: (context, states) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Neumorphic(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              style: NeumorphicStyle(
                                color: const Color(0xFF17181C).withOpacity(0.5),
                                boxShape: const NeumorphicBoxShape.stadium(),
                                depth: _college == null ? 4 : 0,
                              ),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                dropdownColor: const Color(0xFF17181C),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                hint: state is SignupValidationFailure &&
                                        state.error['college'] != null
                                    ? Text(
                                        state.error['college'],
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      )
                                    : Text(
                                        "College",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                disabledHint: states is CollegeListError
                                    ? Text(states.message)
                                    : Text(
                                        "Loading...",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                menuMaxHeight:
                                    MediaQuery.of(context).size.height * 0.3,
                                value: null,
                                enableFeedback: true,
                                items: states is CollegeListLoaded
                                    ? states.colleges
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: e.name,
                                            child: Text(
                                              e.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList()
                                    : [],
                                onChanged: states is CollegeListLoaded
                                    ? (String? val) {
                                        setState(() {
                                          _college = val;
                                        });
                                      }
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: stat is AuthLoading
                            ? const NeumorphicProgressIndeterminate()
                            : NeumorphicButton(
                                onPressed: () {
                                  _formKey.currentState?.save();
                                  _signupValidationCubit.validate(
                                    SignUpRequest(
                                      name: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      confirmPassword:
                                          _confirmPasswordController.text
                                              .trim(),
                                      mobileNumber:
                                          _phoneController.text.trim(),
                                      registrationNumber:
                                          _regnoController.text.trim(),
                                      course: _courseController.text.trim(),
                                      college: _college ?? '',
                                    ),
                                  );
                                },
                                padding: EdgeInsets.zero,
                                style: const NeumorphicStyle(
                                  boxShape: NeumorphicBoxShape.stadium(),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF8C9ED9),
                                  ),
                                  child: Text(
                                    'Create account',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.appState.authPage = AuthPages.login;
                        },
                        child: Text(
                          'Already have an account? Sign In',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
