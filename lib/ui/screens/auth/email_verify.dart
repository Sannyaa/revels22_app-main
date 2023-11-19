import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:mitrevels22/logic/blocs/auth/bloc/auth_bloc.dart';

class EmailVerificationPage extends StatefulWidget {
  final String token;
  const EmailVerificationPage({Key? key, required this.token})
      : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(VerifyEmailEvent(token: widget.token));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: NeumorphicAppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is AuthLoading) const CircularProgressIndicator(),
                  if (state is VerifyEmailSuccess) ...[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Lottie.asset(
                        'assets/email_verify_success.json',
                        repeat: false,
                      ),
                    ),
                    Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (state is VerifyEmailError) ...[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Lottie.asset(
                        'assets/email_verify_fail.json',
                        repeat: false,
                      ),
                    ),
                    Text(
                      state.error,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
