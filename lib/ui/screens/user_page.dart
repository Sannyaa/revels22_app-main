import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mitrevels22/config/enums/enums.dart';
import 'package:mitrevels22/logic/blocs/user/bloc/user_bloc.dart';
import 'package:mitrevels22/logic/cubits/token/cubit/token_cubit.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:mitrevels22/ui/widgets/personal_info_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:animations/animations.dart';

class UserPage extends StatefulWidget {
  final String token;
  final RevelsAppState appState;
  const UserPage({Key? key, required this.token, required this.appState})
      : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      maxBrightness();
    });
  }

  void maxBrightness() async {
    try {
      await ScreenBrightness().setScreenBrightness(1);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void restoreBrightness() async {
    try {
      await ScreenBrightness().resetScreenBrightness();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void deactivate() {
    restoreBrightness();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOut) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              backgroundColor: NeumorphicTheme.baseColor(context),
              content: const Text(
                'Logged out successfully',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
          context.read<TokenCubit>().deleteToken();
        }
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserError) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else if (state is UserLoaded) {
          print(state.user.isMahe);
          return SafeArea(
            child: Stack(
              children: [
                Positioned(
                  child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: NeumorphicTheme.baseColor(context),
                      actions: [
                        TextButton(
                          onPressed: () => showModal(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor:
                                  NeumorphicTheme.baseColor(context),
                              title: const Text(
                                'Are you sure?',
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: [
                                NeumorphicButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  minDistance: -4,
                                  style: const NeumorphicStyle(depth: 0),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                NeumorphicButton(
                                  onPressed: () {
                                    context.read<UserBloc>().add(
                                        LogoutEvent(token: state.user.token));
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: const Text(
                            "Log Out",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    body: ListView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.08,
                        left: 32,
                        right: 32,
                      ),
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(48.0, 0, 48.0, 32),
                          child: Neumorphic(
                            child: QrImage(
                              padding: const EdgeInsets.all(16),
                              data: state.user.token,
                              backgroundColor: Colors.white,
                              embeddedImage:
                                  const AssetImage("assets/logo.png"),
                              eyeStyle: const QrEyeStyle(
                                eyeShape: QrEyeShape.circle,
                                color: Colors.black,
                              ),
                              dataModuleStyle: const QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.circle,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            state.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFF373C48),
                          ),
                          child: Text(
                            "Delegate ID: ${state.user.userID}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.user.status.name,
                            style: TextStyle(
                              color: state.user.status == Status.VERIFIED
                                  ? Colors.green
                                  : state.user.status == Status.UNVERIFIED
                                      ? Colors.yellow
                                      : Colors.red,
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        NeumorphicButton(
                          margin: const EdgeInsets.only(bottom: 8, top: 24),
                          minDistance: -4,
                          padding: const EdgeInsets.all(16),
                          onPressed: () {
                            widget.appState.authPage = AuthPages.teams;
                          },
                          child: const Text(
                            'Registered Events',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        NeumorphicButton(
                          margin: const EdgeInsets.only(top: 8, bottom: 24),
                          minDistance: -4,
                          onPressed: () {
                            widget.appState.authPage = AuthPages.delegateCards;
                          },
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            'Delegate Cards',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  bottom: 0,
                  child: TextButton.icon(
                    onPressed: () async {
                      await showModalBottomSheet(
                        backgroundColor: const Color(0xFF2C303A),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(48),
                          ),
                        ),
                        context: context,
                        builder: (context) => PersonalInfoSheet(
                          college: state.user.college,
                          course: state.user.course,
                          email: state.user.email,
                          mobileNumber: state.user.mobileNumber,
                          registrationNumber: state.user.registrationNumber,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Personal Information",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.topCenter,
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 16),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF2C303A)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(48),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
