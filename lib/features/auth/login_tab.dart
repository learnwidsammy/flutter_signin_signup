import 'package:flutter/material.dart';
import '../../widgets/social_button.dart';
import '../../widgets/or_divider.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final success = await AuthService.login(email, password);
      if (success) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login failed')));
        }
      }
    }
  }

  void _forgotPassword() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Forgot password tapped')));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email address',
                hintText: 'Enter your email address',
              ),
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                suffix: TextButton(
                  onPressed: _forgotPassword,
                  child: const Text('Forgot password?'),
                ),
              ),
              validator: Validators.password,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Log In'),
            ),
            const SizedBox(height: 16),
            const OrDivider(),
            const SizedBox(height: 16),
            SocialButton(
              icon: Icons.g_mobiledata,
              text: 'Continue with Google',
              onPressed: () => AuthService.loginWithGoogle(),
            ),
            SocialButton(
              icon: Icons.apple,
              text: 'Continue with Apple',
              onPressed: () => AuthService.loginWithApple(),
            ),
            SocialButton(
              icon: Icons.currency_bitcoin,
              text: 'Continue with Binance',
              onPressed: () => AuthService.loginWithBinance(),
            ),
            SocialButton(
              icon: Icons.wallet,
              text: 'Continue with Wallet',
              onPressed: () => AuthService.loginWithWallet(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account yet? "),
                GestureDetector(
                  onTap: () {
                    DefaultTabController.of(context).animateTo(1);
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  child: const Text('Continue as a guest'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
