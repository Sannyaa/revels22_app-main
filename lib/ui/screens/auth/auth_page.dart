import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mitrevels22/logic/router.dart';

class AuthPage extends StatefulWidget {
  final RevelsAppState appState;
  const AuthPage({Key? key, required this.appState}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthRouterDelegate _routerDelegate;
  late ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void initState() {
    super.initState();
    _routerDelegate = AuthRouterDelegate(widget.appState);
  }

  @override
  void didUpdateWidget(covariant AuthPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = oldWidget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        ?.createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher?.takePriority();
    return Router(
      routerDelegate: _routerDelegate,
      backButtonDispatcher: _backButtonDispatcher,
    );
  }
}
