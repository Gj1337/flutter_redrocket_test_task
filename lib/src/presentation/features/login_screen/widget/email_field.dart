part of 'login_widget.dart';

class _EmailField extends StatelessWidget {
  const _EmailField({this.controller, this.enabled = true});
  final bool enabled;
  final TextEditingController? controller;

  String? _emailValdiation(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    const emailRegex = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
    if (!RegExp(emailRegex).hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: _emailValdiation,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
        helperText: '',
      ),
    );
  }
}
