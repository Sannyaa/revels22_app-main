import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:mitrevels22/logic/blocs/user/bloc/user_bloc.dart';
import 'package:mitrevels22/logic/cubits/token/cubit/token_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mitrevels22/ui/screens/FaqPage/faq_page.dart';
import 'package:mitrevels22/ui/screens/EventsPage/event_deep.dart';
import 'package:mitrevels22/ui/screens/EventsPage/events_screen.dart';
import 'package:mitrevels22/ui/screens/Home/HomePage.dart';
import 'package:mitrevels22/ui/screens/Home/HomeView.dart';
import 'package:mitrevels22/ui/screens/auth/auth_page.dart';
import 'package:mitrevels22/ui/screens/auth/auth_view.dart';
import 'package:mitrevels22/ui/screens/auth/email_verify.dart';
import 'package:mitrevels22/ui/screens/auth/login_page.dart';
//import 'package:mitrevels22/ui/screens/auth/registered_events.dart';
import 'package:mitrevels22/ui/screens/auth/signup_page.dart';
import 'package:mitrevels22/ui/screens/categories_page.dart';
import 'package:mitrevels22/ui/screens/delegate_card_page/delegate_card_page.dart';
import 'package:mitrevels22/ui/screens/developers_page/DevelopersPage.dart';
import 'package:mitrevels22/ui/screens/featured_events/featured_events.dart';
import 'package:mitrevels22/ui/screens/my_delegate_cards/MyDelegateCards.dart';
import 'package:mitrevels22/ui/screens/pro_show.dart';
import 'package:mitrevels22/ui/screens/schedule_page/SchedulePage.dart';
import 'package:mitrevels22/ui/screens/teams_page/teams_page.dart';
import 'package:mitrevels22/ui/screens/unknown_page.dart';
import 'package:mitrevels22/ui/screens/user_page.dart';

/// Base class for all pagePaths
abstract class RevelsRoutePath {}

class HomePagePath extends RevelsRoutePath {}

class CategoriesPagePath extends RevelsRoutePath {}

class FaqPagePath extends RevelsRoutePath {}

class DevelopersPagePath extends RevelsRoutePath {}

class DelegateCardPagePath extends RevelsRoutePath {}

class ProshowPagePath extends RevelsRoutePath {}

class EventsPagePath extends RevelsRoutePath {}

class FeaturedEventsPagePath extends RevelsRoutePath {}

class EventPagePath extends RevelsRoutePath {
  final String eventId;

  EventPagePath({required this.eventId});
}

class AuthPagePath extends RevelsRoutePath {}

class UserPagePath extends RevelsRoutePath {
  final String token;

  UserPagePath({required this.token});
}

class LoginPagePath extends RevelsRoutePath {}

class SignupPagePath extends RevelsRoutePath {}

class VerifyEmailPagePath extends RevelsRoutePath {
  final String token;

  VerifyEmailPagePath({required this.token});
}

class ResetPasswordPagePath extends RevelsRoutePath {
  final String token;

  ResetPasswordPagePath({required this.token});
}

class SchedulePagePath extends RevelsRoutePath {}

class TeamsPagePath extends RevelsRoutePath {}

class UnknownPagePath extends RevelsRoutePath {}

enum HomePages {
  categories,
  delegateCards,
  proshow,
  events,
  featuredEvents,
  faq,
  developers
}

enum AuthPages {
  login,
  signup,
  teams,
  delegateCards,
}

class RevelsAppState extends ChangeNotifier {
  int _currentIndex = 0;
  String? _token;
  String? _emailVerifyToken;
  String? _resetPasswordToken;
  bool _unknownPage = false;
  HomePages? _homePage;
  AuthPages? _authPage;
  String? _eventId;
  Event? _event;

  HomePages? get homePage => _homePage;

  set homePage(HomePages? homePage) {
    _homePage = homePage;
    notifyListeners();
  }

  AuthPages? get authPage => _authPage;

  set authPage(AuthPages? authPage) {
    _authPage = authPage;
    notifyListeners();
  }

  bool get unknownPage => _unknownPage;

  set unknownPage(bool value) {
    _unknownPage = value;
    notifyListeners();
  }

  String? get token => _token;

  set token(String? token) {
    _token = token;
    notifyListeners();
  }

  String? get emailVerifyToken => _emailVerifyToken;

  set emailVerifyToken(String? emailVerifyToken) {
    _emailVerifyToken = emailVerifyToken;
    notifyListeners();
  }

  String? get resetPasswordToken => _resetPasswordToken;

  set resetPasswordToken(String? resetPasswordToken) {
    _resetPasswordToken = resetPasswordToken;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  String? get eventId => _eventId;

  set eventId(String? eventId) {
    _eventId = eventId;
    notifyListeners();
  }

  Event? get event => _event;

  set event(Event? event) {
    _event = event;
    notifyListeners();
  }
}

class RevelsRouteInformationParser
    extends RouteInformationParser<RevelsRoutePath> {
  @override
  Future<RevelsRoutePath> parseRouteInformation(
      RouteInformation routeInformation) {
    if (routeInformation.location != null) {
      final uri = Uri.parse(routeInformation.location!);
      if (uri.pathSegments.isEmpty) {
        return SynchronousFuture(HomePagePath());
      } else if (uri.pathSegments.length == 1) {
        switch (uri.pathSegments[0]) {
          case 'categories':
            return SynchronousFuture(CategoriesPagePath());
          case 'delegateCards':
            return SynchronousFuture(DelegateCardPagePath());
          case 'proshow':
            return SynchronousFuture(ProshowPagePath());
          case 'events':
            return SynchronousFuture(EventsPagePath());
          case 'featuredEvents':
            return SynchronousFuture(FeaturedEventsPagePath());
          case 'auth':
            return SynchronousFuture(AuthPagePath());
          case 'user':
            return SynchronousFuture(
                UserPagePath(token: uri.queryParameters['token']!));
          case 'login':
            return SynchronousFuture(LoginPagePath());
          case 'signup':
            return SynchronousFuture(SignupPagePath());
          case 'schedule':
            return SynchronousFuture(SchedulePagePath());
          case 'teams':
            return SynchronousFuture(TeamsPagePath());
          default:
            return SynchronousFuture(UnknownPagePath());
        }
      }
      if (uri.pathSegments.length == 2) {
        switch (uri.pathSegments[0]) {
          case 'events':
            return SynchronousFuture(
                EventPagePath(eventId: uri.pathSegments[1]));
          case 'verify':
            return SynchronousFuture(
                VerifyEmailPagePath(token: uri.pathSegments[1]));
          case 'forgetpass':
            return SynchronousFuture(
                ResetPasswordPagePath(token: uri.pathSegments[1]));
          default:
            return SynchronousFuture(UnknownPagePath());
        }
      }
    }
    return SynchronousFuture(UnknownPagePath());
  }

  @override
  RouteInformation? restoreRouteInformation(RevelsRoutePath configuration) {
    if (configuration is HomePagePath) {
      return const RouteInformation(location: '/');
    }
    if (configuration is CategoriesPagePath) {
      return const RouteInformation(location: '/categories');
    }
    if (configuration is DelegateCardPagePath) {
      return const RouteInformation(location: '/delegateCards');
    }
    if (configuration is ProshowPagePath) {
      return const RouteInformation(location: '/proshow');
    }
    if (configuration is EventsPagePath) {
      return const RouteInformation(location: '/events');
    }
    if (configuration is FeaturedEventsPagePath) {
      return const RouteInformation(location: '/featuredEvents');
    }
    if (configuration is EventPagePath) {
      return RouteInformation(location: '/events/${configuration.eventId}');
    }
    if (configuration is AuthPagePath) {
      return const RouteInformation(location: '/auth');
    }
    if (configuration is UserPagePath) {
      return RouteInformation(location: '/user?token=${configuration.token}');
    }
    if (configuration is LoginPagePath) {
      return const RouteInformation(location: '/login');
    }
    if (configuration is SignupPagePath) {
      return const RouteInformation(location: '/signup');
    }
    if (configuration is VerifyEmailPagePath) {
      return RouteInformation(
        location: '/verify/${configuration.token}',
      );
    }
    if (configuration is ResetPasswordPagePath) {
      return RouteInformation(
        location: '/forgetpass/${configuration.token}',
      );
    }
    if (configuration is SchedulePagePath) {
      return const RouteInformation(location: '/schedule');
    }
    if (configuration is TeamsPagePath) {
      return const RouteInformation(location: '/teams');
    }
    if (configuration is UnknownPagePath) {
      return const RouteInformation(location: '/404');
    }
    return null;
  }
}

class RevelsRouterDelegate extends RouterDelegate<RevelsRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RevelsRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  RevelsAppState appState;

  RevelsRouterDelegate({required this.appState})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  @override
  RevelsRoutePath? get currentConfiguration {
    if (appState.eventId != null) {
      return EventPagePath(eventId: appState.eventId!);
    } else if (appState.currentIndex == 0) {
      if (appState.homePage == HomePages.categories) {
        return CategoriesPagePath();
      } else if (appState.homePage == HomePages.delegateCards) {
        return DelegateCardPagePath();
      } else if (appState.homePage == HomePages.proshow) {
        return ProshowPagePath();
      } else if (appState.homePage == HomePages.events) {
        return EventsPagePath();
      } else if (appState.homePage == HomePages.featuredEvents) {
        return FeaturedEventsPagePath();
      } else if (appState.homePage == HomePages.faq) {
        return FaqPagePath();
      } else if (appState.homePage == HomePages.developers) {
        return DevelopersPagePath();
      } else {
        return HomePagePath();
      }
    } else if (appState.currentIndex == 1) {
      return SchedulePagePath();
    } else if (appState.currentIndex == 2) {
      if (appState.emailVerifyToken != null) {
        return VerifyEmailPagePath(token: appState.emailVerifyToken!);
      } else if (appState.resetPasswordToken != null) {
        return ResetPasswordPagePath(token: appState.resetPasswordToken!);
      } else if (appState.authPage == AuthPages.teams) {
        return TeamsPagePath();
      } else if (appState.authPage == AuthPages.delegateCards) {
        return DelegateCardPagePath();
      } else if (appState.token != null && appState.homePage == null) {
        return UserPagePath(token: appState.token!);
      } else if (appState.token == null &&
          appState.authPage == AuthPages.login) {
        return LoginPagePath();
      } else if (appState.token == null &&
          appState.authPage == AuthPages.signup) {
        return SignupPagePath();
      } else {
        return AuthPagePath();
      }
    } else {
      return UnknownPagePath();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: NeumorphicTheme.baseColor(context),
        systemNavigationBarColor: NeumorphicTheme.baseColor(context),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<TokenCubit, TokenState>(
          listener: (context, state) {
            if (state is TokenExists) {
              appState.token = state.token;
              context.read<UserBloc>().add(FetchUser(token: state.token));
            }
            if (state is TokenEmpty) {
              appState.token = null;
            }
            notifyListeners();
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  backgroundColor: NeumorphicTheme.baseColor(context),
                  content: const Text(
                    'Please login again',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
              context.read<TokenCubit>().deleteToken();
            }
          },
        ),
      ],
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          pages: [
            SharedAxisPage(
              transitionType: SharedAxisTransitionType.horizontal,
              key: const ValueKey("HomePage"),
              child: HomePage(appState: appState),
            ),
            if (appState.currentIndex == 1)
              SharedAxisPage(
                transitionType: SharedAxisTransitionType.horizontal,
                key: ValueKey("SchedulePage"),
                child: SchedulePage(
                  appState: appState,
                ),
              ),
            if (appState.currentIndex == 2)
              SharedAxisPage(
                transitionType: SharedAxisTransitionType.horizontal,
                key: const ValueKey("UserPage"),
                child: AuthPage(
                  appState: appState,
                ),
              ),
            if (appState.eventId != null && appState.currentIndex == 1)
              FadeThroughPage(
                child: EventDeep(
                  eventId: appState.eventId!,
                  data: appState.event,
                  appState: appState,
                ),
                key: const ValueKey("EventPage"),
              ),
            if (appState.unknownPage)
              const SharedAxisPage(
                transitionType: SharedAxisTransitionType.horizontal,
                key: ValueKey("UnknownPage"),
                child: UnknownPage(),
              ),
          ],
          onPopPage: (route, result) {
            debugPrint('parent pop');
            if (!route.didPop(result)) {
              return false;
            }
            if (appState.eventId != null && appState.currentIndex == 1) {
              appState.eventId = null;
              appState.event = null;
            } else if (appState.unknownPage) {
              appState.unknownPage = false;
            } else if (appState.currentIndex != 0) {
              appState.currentIndex = 0;
            }
            notifyListeners();
            return true;
          },
        ),
        bottomNavigationBar: appState.homePage == null &&
                !appState.unknownPage &&
                appState.eventId == null
            ? CurvedNavigationBar(
                index: appState.currentIndex,
                color: const Color(0xff373C48),
                backgroundColor: Colors.transparent,
                onTap: (index) => appState.currentIndex = index,
                items: const [
                  Icon(Icons.home, color: Colors.white),
                  Icon(Icons.watch_later, color: Colors.white),
                  Icon(Icons.person, color: Colors.white),
                ],
              )
            : null,
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(RevelsRoutePath configuration) async {
    if (configuration is HomePagePath) {
      appState.currentIndex = 0;
      appState.homePage = null;
    } else if (configuration is CategoriesPagePath) {
      appState.currentIndex = 0;
      appState.homePage = HomePages.categories;
    } else if (configuration is DelegateCardPagePath) {
      appState.currentIndex = 0;
      appState.homePage = HomePages.delegateCards;
    } else if (configuration is ProshowPagePath) {
      appState.currentIndex = 0;
      appState.homePage = HomePages.proshow;
    } else if (configuration is EventsPagePath) {
      appState.currentIndex = 0;
      appState.homePage = HomePages.events;
    } else if (configuration is FeaturedEventsPagePath) {
      appState.currentIndex = 0;
      appState.homePage = HomePages.featuredEvents;
    } else if (configuration is SchedulePagePath) {
      appState.currentIndex = 1;
    } else if (configuration is AuthPage) {
      appState.currentIndex = 2;
    } else if (configuration is LoginPagePath) {
      appState.currentIndex = 2;
      appState.authPage = AuthPages.login;
    } else if (configuration is SignupPagePath) {
      appState.currentIndex = 2;
      appState.authPage = AuthPages.signup;
    } else if (configuration is UserPagePath) {
      appState.currentIndex = 2;
      appState.token = configuration.token;
    } else if (configuration is VerifyEmailPagePath) {
      appState.currentIndex = 2;
      appState.emailVerifyToken = configuration.token;
    } else if (configuration is ResetPasswordPagePath) {
      appState.currentIndex = 2;
      appState.resetPasswordToken = configuration.token;
    } else if (configuration is TeamsPagePath) {
      appState.currentIndex = 2;
      appState.authPage = AuthPages.teams;
    } else if (configuration is DelegateCardPagePath) {
      appState.currentIndex = 2;
      appState.authPage = AuthPages.delegateCards;
    } else if (configuration is EventPagePath) {
      appState.currentIndex = 0;
      appState.eventId = configuration.eventId;
    } else if (configuration is UnknownPagePath) {
      appState.unknownPage = true;
    }
  }
}

class HomeRouterDelegate extends RouterDelegate<RevelsRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RevelsRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  RevelsAppState _appState;

  RevelsAppState get appState => _appState;

  set appState(RevelsAppState value) {
    _appState = value;
    notifyListeners();
  }

  HomeRouterDelegate(this._appState)
      : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        FadeThroughPage(
          key: const ValueKey("home"),
          child: HomeView(appState: appState),
        ),
        if (appState.homePage == HomePages.categories)
          FadeThroughPage(
            key: const ValueKey("categories"),
            child: CategoriesPage(
              appState: appState,
            ),
          ),
        if (appState.homePage == HomePages.delegateCards)
          const FadeThroughPage(
            key: ValueKey("delegateCards"),
            child: DelegateCardPage(),
          ),
        if (appState.homePage == HomePages.proshow)
          FadeThroughPage(
            key: ValueKey("proshow"),
            child: ProShowScreen(
              appState: appState,
            ),
          ),
        if (appState.homePage == HomePages.events)
          FadeThroughPage(
            key: const ValueKey("events"),
            child: EventsScreen(
              appState: appState,
            ),
          ),
        if (appState.homePage == HomePages.featuredEvents)
          FadeThroughPage(
            key: ValueKey("featuredEvents"),
            child: FeaturedEvents(
              appState: appState,
            ),
          ),
        if (appState.homePage == HomePages.faq)
          SharedAxisPage(
            key: ValueKey("faq"),
            child: FaqPage(
              appState: appState,
            ),
            transitionType: SharedAxisTransitionType.vertical,
          ),
        if (appState.homePage == HomePages.developers)
          SharedAxisPage(
            key: ValueKey("developers"),
            child: DevelopersPage(
              appState: appState,
            ),
            transitionType: SharedAxisTransitionType.vertical,
          ),
        if (appState.eventId != null)
          FadeThroughPage(
            child: EventDeep(
              eventId: appState.eventId!,
              data: appState.event,
              appState: appState,
            ),
            key: const ValueKey("EventPage"),
          ),
      ],
      onPopPage: (route, result) {
        if (appState.eventId != null) {
          appState.eventId = null;
          appState.event = null;
        } else if (appState.homePage != null) {
          appState.homePage = null;
        }
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RevelsRoutePath configuration) async {}
}

class AuthRouterDelegate extends RouterDelegate<RevelsRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RevelsRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  RevelsAppState _appState;

  RevelsAppState get appState => _appState;

  set appState(RevelsAppState value) {
    _appState = value;
    notifyListeners();
  }

  AuthRouterDelegate(this._appState)
      : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        appState.token != null
            ? FadeThroughPage(
                key: const ValueKey("user"),
                child: UserPage(
                  token: appState.token!,
                  appState: appState,
                ),
              )
            : FadeThroughPage(
                key: const ValueKey("auth"),
                child: AuthView(
                  appState: appState,
                ),
              ),
        if (appState.token != null && appState.authPage == AuthPages.teams)
          FadeThroughPage(
            key: const ValueKey('teams'),
            child: TeamsPage(),
          ),
        if (appState.token != null &&
            appState.authPage == AuthPages.delegateCards)
          FadeThroughPage(
            key: const ValueKey('delegateCards'),
            child: MyDelegateCards(
              pending: (context.read<UserBloc>().state as UserLoaded)
                  .user
                  .pendingDelegateCards,
              purchased: (context.read<UserBloc>().state as UserLoaded)
                  .user
                  .delegateCards,
            ),
          ),
        if (appState.token == null && appState.authPage == AuthPages.login)
          FadeThroughPage(
            key: const ValueKey("login"),
            child: LoginPage(
              appState: appState,
            ),
          ),
        if (appState.token == null && appState.authPage == AuthPages.signup)
          FadeThroughPage(
            key: const ValueKey("signup"),
            child: SignUpPage(
              appState: appState,
            ),
          ),
        if (appState.emailVerifyToken != null)
          FadeThroughPage(
            key: const ValueKey("verifyEmail"),
            child: EmailVerificationPage(
              token: appState.emailVerifyToken!,
            ),
          ),
      ],
      onPopPage: (route, result) {
        debugPrint('auth pop');
        if (appState.emailVerifyToken != null) {
          appState.emailVerifyToken = null;
        } else if (appState.resetPasswordToken != null) {
          appState.resetPasswordToken = null;
        } else if (appState.authPage != null) {
          appState.authPage = null;
        }
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RevelsRoutePath configuration) async {}
}

/// Page Route Builder for Shared Axis Page Transition.
class SharedAxisPage extends Page {
  final Widget child;
  final SharedAxisTransitionType transitionType;

  const SharedAxisPage(
      {LocalKey? key, required this.child, required this.transitionType})
      : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: transitionType,
        child: child,
      ),
    );
  }
}

/// Page Route Builder for Fade Through Page Transition.
class FadeThroughPage extends Page {
  final Widget child;

  const FadeThroughPage({LocalKey? key, required this.child}) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
    );
  }
}
