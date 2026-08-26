import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/error/failure_message.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../home/presentation/widgets/primary_button.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _email.addListener(_onFieldChanged);
    _password.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {});

  @override
  void dispose() {
    _email.removeListener(_onFieldChanged);
    _password.removeListener(_onFieldChanged);
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final canSubmit =
        _email.text.trim().isNotEmpty && _password.text.trim().isNotEmpty;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.userMessage)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthAuthenticating;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xxxl),
                  Text(
                    l10n.signUp,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  AppTextField(
                    label: l10n.email,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    label: l10n.password,
                    controller: _password,
                    obscureText: true,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  PrimaryButton(
                    label: l10n.signUp,
                    isLoading: isLoading,
                    onPressed: canSubmit
                        ? () => context.read<AuthBloc>().add(
                            AuthEvent.signUpSubmitted(
                              email: _email.text,
                              password: _password.text,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.login),
                    child: Text(l10n.haveAccountLogin),
                  ),
                ],
              ).animate().fadeIn(duration: 300.ms),
            );
          },
        ),
      ),
    );
  }
}
