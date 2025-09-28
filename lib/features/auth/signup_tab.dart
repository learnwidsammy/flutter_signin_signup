import 'package:flutter/material.dart';
import '../../widgets/social_button.dart';
import '../../widgets/or_divider.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';

class SignupTab extends StatefulWidget {
  const SignupTab({super.key});

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _updatesChecked = false;

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final success = await AuthService.signup(email, password);
      if (success) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Signup failed')));
        }
      }
    }
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
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
              validator: Validators.password,
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

            ElevatedButton(
              onPressed: _signup,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Create an account'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _updatesChecked,
                  onChanged: (v) {
                    setState(() {
                      _updatesChecked = v ?? false;
                    });
                  },
                ),

                const Expanded(
                  child: Text(
                    'Please keep me updated by email with the latest news, research findings, reward programs, event updates.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () {
                    DefaultTabController.of(context).animateTo(0);
                  },
                  child: const Text(
                    'Login',
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
