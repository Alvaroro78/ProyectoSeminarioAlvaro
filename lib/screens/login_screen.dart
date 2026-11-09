import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/data/mock_data.dart';
import 'package:proyecto_seminario_alvaro/models/app_user.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.event_repeat,
                  size: 40,
                  color: AppColors.surface,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'ProyectoSeminarioAlvaro',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'La siguiente edición de tu evento, a partir de la anterior.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.mutedText,
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16,
                  children: [
                    Text('Iniciar sesión', style: textTheme.titleLarge),
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
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    if (_error != null)
                      Text(
                        _error!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    FilledButton(
                      onPressed: _isLoading ? null : _login,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(_isLoading ? 'Entrando…' : 'Entrar'),
                    ),
                    TextButton(
                      onPressed: _isLoading ? null : _goToRegister,
                      child: const Text('Crear cuenta'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Cuentas de prueba (contraseña 123456)',
              textAlign: TextAlign.center,
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.mutedText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Organizadora: laura@eventos.co\nInvitada: valentina.rios@correo.co',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
