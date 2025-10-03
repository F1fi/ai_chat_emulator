import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/bloc/auth/auth_cubit.dart';
import 'package:skelar_chat_emulator/presentation/auth/widgets/auth_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  static const _style = TextStyle(fontSize: 14, color: Colors.black);

  bool isSignUpFlow = false;

  AuthCubit get cubit => context.read<AuthCubit>();

  @override
  void initState() {
    super.initState();

    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AuthCubit>();

    if (!cubit.state.isInitialized) {
      return Material(child: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthField(
                controller: loginController,
                label: 'Login',
                validator: _validate,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: AuthField(
                  controller: passwordController,
                  label: 'Password',
                  isTextHideable: true,
                  validator: _validate,
                ),
              ),
              if (isSignUpFlow)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AuthField(
                    controller: confirmPasswordController,
                    label: 'Confirm password',
                    isTextHideable: true,
                    validator: (value) {
                      final baseValidation = _validate(value);

                      if (baseValidation != null) {
                        baseValidation;
                      }

                      final isSame =
                          passwordController.text ==
                          confirmPasswordController.text;

                      if (isSame) return null;

                      return 'Password is wrong';
                    },
                  ),
                ),

              if (cubit.state.isLoading)
                CircularProgressIndicator()
              else ...[
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(
                    isSignUpFlow ? 'Sign up!' : 'Sign in!',
                    style: _style.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            isSignUpFlow
                                ? 'Do you have an account? '
                                : 'Do you not have an account? ',
                        style: _style,
                      ),
                      TextSpan(
                        text: isSignUpFlow ? 'Sign in!' : 'Sign up!',
                        style: _style.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer:
                            TapGestureRecognizer()..onTap = onFooterPressed,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String? _validate(String? value) {
    final trimmed = value?.trim() ?? '';

    if (trimmed.isEmpty) {
      return 'Cannot be empty';
    }

    return null;
  }

  void onPressed() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final login = loginController.text.trim();
    final password = passwordController.text.trim();

    final bool result;

    if (isSignUpFlow) {
      result = await cubit.signUp(login, password);
    } else {
      result = await cubit.signIn(login, password);
    }

    if (result) return;

    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: Text(
          'Ops! '
          'Something went wrong.'
          '\nCheck your data.',
        ),
      ),
    );
  }

  void onFooterPressed() {
    final isAvailable = !cubit.state.isLoading && cubit.state.isInitialized;
    if (!isAvailable) return;

    setState(() => isSignUpFlow = !isSignUpFlow);
  }
}
