import 'package:flutter/material.dart';

part 'email_field.dart';
part 'password_field.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({this.onSubmit, this.isLoading = false, super.key});
  final void Function(String email, String password)? onSubmit;
  final bool isLoading;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isValid = false;

  void _onTextFieldsChanged() {
    final newDataIsValid = _formKey.currentState?.validate() ?? false;
    if (newDataIsValid != isValid) {
      setState(() => isValid = newDataIsValid);
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit?.call(_emailController.text, _passwordController.text);
    }
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_onTextFieldsChanged);
    _passwordController.addListener(_onTextFieldsChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          const Text('Log in', style: TextStyle(fontSize: 30)),
          _EmailField(controller: _emailController, enabled: !widget.isLoading),

          _PasswordField(
            controller: _passwordController,
            enabled: !widget.isLoading,
          ),
          widget.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: isValid && !widget.isLoading ? _submit : null,
                  child: const Center(child: Text('Submit')),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
