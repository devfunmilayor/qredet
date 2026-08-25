import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'core/di/injection.dart';
import 'core/l10n/generated/app_localizations.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/language/presentation/bloc/language_bloc.dart';
import 'features/language/presentation/bloc/language_event.dart';
import 'features/language/presentation/bloc/language_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await configureDependencies();
  getIt<AuthBloc>().add(const AuthEvent.checkRequested());
  runApp(const QredetApp());
}

class QredetApp extends StatelessWidget {
  const QredetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LanguageBloc>()..add(const LanguageEvent.started())),
        BlocProvider.value(value: getIt<AuthBloc>()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          final locale = state is LanguageLoaded ? Locale(state.selected.code) : null;
          return MaterialApp.router(
            onGenerateTitle: (context) => AppLocalizations.of(context).appName,
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: ThemeMode.system,
            locale: locale,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: getIt<GoRouter>(),
          );
        },
      ),
    );
  }
}
