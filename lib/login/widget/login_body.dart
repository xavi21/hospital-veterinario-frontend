import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/input/custom_input.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/common/validation/validate_email.dart';
import 'package:paraiso_canino/common/validation/validate_password.dart';
import 'package:paraiso_canino/home/home_page.dart';
import 'package:paraiso_canino/login/bloc/login_bloc.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  bool _rememberEmail = false;
  late LoginBloc _loginBloc;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, BaseState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case const (LoginReminderMailSuccess):
            final loadedState = state as LoginReminderMailSuccess;
            setState(() {
              _usernameController.text = loadedState.reminderMail;
              _rememberEmail = true;
            });
            break;
          case const (LoginSuccess):
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          case const (LoginError):
            final stateError = state as LoginError;
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Autenticación incorecta',
              description: stateError.error,
              isError: true,
            );
            break;
          case const (ServerClientError):
            CustomStateDialog.showAlertDialog(
              context,
              title: 'Error',
              description: 'En este momento no podemos atender tu solicitud.',
              isError: true,
            );
            break;
        }
      },
      child: Stack(
        children: [
          Row(
            children: [
              _letSide(),
              _rightSide(),
            ],
          ),
          BlocBuilder<LoginBloc, BaseState>(
            builder: (context, state) {
              if (state is LoginInProgress) {
                return const Loader();
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget _letSide() => Expanded(
        flex: 2,
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                lightBlue,
                blue,
                darkBlue,
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Image.asset(
            '${imagePath}login.png',
          ),
        ),
      );

  Widget _rightSide() => Expanded(
        flex: 3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: 677.0,
                maxWidth: 468.0,
              ),
              child: Card(
                color: white,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    22.0,
                  ),
                  child: _loginForm(),
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              child: _logo(),
            ),
          ],
        ),
      );

  Widget _loginForm() => Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Iniciar Sesión',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                'Correo electrónico',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: blue,
                    ),
              ),
            ),
            CustomInput(
              controller: _usernameController,
              isRequired: true,
              validator: (String? text) => validateEmail(text),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 15.0,
              ),
              child: Text(
                'Contraseña',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: blue,
                    ),
              ),
            ),
            CustomInput(
              controller: _passwordController,
              isRequired: true,
              isPassword: true,
              validator: (String? value) => validatePassword(value),
              onFieldSubmitted: (value) => _handleLogin(),
            ),
            const SizedBox(
              height: 20.0,
            ),
            CheckboxListTile(
              title: const Text(
                'Recordar usuario',
                style: TextStyle(color: black),
              ),
              value: _rememberEmail,
              onChanged: (bool? value) => setState(
                () => _rememberEmail = value ?? false,
              ),
              checkColor: white,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Center(
              child: CustomButton(
                onPressed: () => _handleLogin(),
                text: 'Ingresar',
              ),
            )
          ],
        ),
      );

  Widget _logo() => ClipRRect(
        borderRadius: BorderRadius.circular(
          50.0,
        ),
        child: Image.asset(
          '${imagePath}logo.jpg',
        ),
      );

  void _handleLogin() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      _loginBloc.add(
        LoginWithEmailPassword(
          codeEmail: _usernameController.text.trim(),
          password: _passwordController.text,
          rememberEmail: _rememberEmail,
        ),
      );
    }
  }
}
