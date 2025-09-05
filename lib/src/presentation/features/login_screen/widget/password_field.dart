part of 'login_widget.dart';

const _passwordMinLength = 6;

class _PasswordField extends StatefulWidget {
  const _PasswordField({this.controller, this.enabled = true});

  final TextEditingController? controller;
  final bool enabled;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  String? _passwordValdiation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < _passwordMinLength) {
      return 'Password must be at least $_passwordMinLength characters';
    }

    return null;
  }

  bool _obscurePassword = true;

  void _onShowPasswordClick() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _passwordValdiation,
      controller: widget.controller,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        helperText: '',
        labelText: 'Password',
        suffixIcon: IconButton(
          onPressed: _onShowPasswordClick,
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
      ),
    );
  }
}
