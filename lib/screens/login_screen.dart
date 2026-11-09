import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/data/mock_data.dart';
import 'package:proyecto_seminario_alvaro/models/app_user.dart';

/// The authentication screen where users log in or navigate to registration.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final List<AppUser> _users;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _users = buildMockUsers();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final user = _users
        .where((u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password)
        .firstOrNull;

    if (user == null) {
      setState(() {
        _error = 'Correo o contraseña incorrectos';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    if (user.role == 'organizer') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/organizer',
        (route) => false,
        arguments: user,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/attendee',
        (route) => false,
        arguments: user,
      );
    }
  }

  Future<void> _goToRegister() async {
    final existingEmails = _users.map((u) => u.email).toList();
    final result = await Navigator.pushNamed(
      context,
      '/register',
      arguments: existingEmails,
    );

    if (result is AppUser && mounted) {
      setState(() {
        _users.add(result);
        _emailController.text = result.email;
        _passwordController.clear();
        _error = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'Bienvenido',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ingresa tu correo y contraseña para continuar.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(
                _error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isLoading ? null : _login,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(_isLoading ? 'Entrando…' : 'Entrar'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _isLoading ? null : _goToRegister,
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
