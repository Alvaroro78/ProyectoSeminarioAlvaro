import 'package:flutter/material.dart';
import 'package:proyecto_seminario_alvaro/models/app_user.dart';
import 'package:proyecto_seminario_alvaro/theme/app_theme.dart';

/// Side menu with the user's data, the sections and the logout action.
class AppDrawer extends StatelessWidget {
  final AppUser user;
  final List<String> sections;
  final List<IconData> icons;
  final int selected;
  final Function(int) onSelect;
  final Function() onLogout;

  const AppDrawer({
    super.key,
    required this.user,
    required this.sections,
    required this.icons,
    required this.selected,
    required this.onSelect,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final roleLabel = user.role == 'organizer' ? 'Organizador' : 'Invitado';
    final initial = user.name.isNotEmpty ? user.name[0].toUpperCase() : '?';

    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.surface,
                  child: Text(
                    initial,
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.name,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.surface,
                  ),
                ),
                Text(
                  user.email,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.surface.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  roleLabel,
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.surface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < sections.length; i++)
            ListTile(
              leading: Icon(
                icons[i],
                color: i == selected ? AppColors.primary : AppColors.mutedText,
              ),
              title: Text(
                sections[i],
                style: textTheme.titleSmall?.copyWith(
                  color: i == selected ? AppColors.primary : AppColors.text,
                ),
              ),
              selected: i == selected,
              onTap: () => onSelect(i),
            ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.late),
            title: Text(
              'Cerrar sesión',
              style: textTheme.titleSmall?.copyWith(color: AppColors.late),
            ),
            onTap: () => onLogout(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
