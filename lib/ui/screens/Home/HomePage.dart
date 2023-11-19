import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mitrevels22/logic/cubits/token/cubit/token_cubit.dart';
import 'package:mitrevels22/logic/router.dart';

class HomePage extends StatefulWidget {
  final RevelsAppState appState;
  const HomePage({Key? key, required this.appState}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeRouterDelegate _routerDelegate;
  late ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void initState() {
    super.initState();
    _routerDelegate = HomeRouterDelegate(widget.appState);
    context.read<TokenCubit>().loadToken();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
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
