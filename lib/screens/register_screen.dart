import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/components/centered_body.dart';
import 'package:proyecto_seminario_alvaro/models/app_user.dart';

/// The registration screen for creating a new user account.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = 'attendee';
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex <= 0) return false;
    final dotIndex = email.indexOf('.', atIndex);
    return dotIndex > atIndex + 1 && dotIndex < email.length - 1;
  }

  void _register(List<String> existingEmails) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty) {
      setState(() {
        _error = 'Escribe tu nombre';
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _error = 'El correo debe incluir @ y un punto después de la @';
      });
      return;
    }

    final emailExists =
        existingEmails.any((e) => e.toLowerCase() == email.toLowerCase());
    if (emailExists) {
      setState(() {
        _error = 'Ese correo ya tiene una cuenta';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _error = 'La contraseña debe tener al menos 6 caracteres';
      });
      return;
    }

    final newUser = AppUser(
      id: 'u-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      password: password,
      role: _role,
    );

    Navigator.pop(context, newUser);
  }

  @override
  Widget build(BuildContext context) {
    final existingEmails =
        (ModalRoute.of(context)?.settings.arguments as List<String>?) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),
      body: CenteredBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Regístrate',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Completa tus datos para crear una cuenta nueva.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
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
                labelText: 'Contraseña (mínimo 6 caracteres)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '¿Cómo usarás la app?',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'organizer',
                  label: Text('Organizo eventos'),
                  icon: Icon(Icons.event),
                ),
                ButtonSegment(
                  value: 'attendee',
                  label: Text('Asisto a eventos'),
                  icon: Icon(Icons.person),
                ),
              ],
              selected: {_role},
              onSelectionChanged: (selected) {
                setState(() {
                  _role = selected.first;
                });
              },
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
              onPressed: () => _register(existingEmails),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
