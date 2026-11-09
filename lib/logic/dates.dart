/// Pure date/time utility functions used throughout the app.
library;

/// Returns the date of a task or message: eventDate + offsetDays (calendar days).
DateTime dueDate(DateTime eventDate, int offsetDays) {
  return DateTime(
    eventDate.year,
    eventDate.month,
    eventDate.day + offsetDays,
  );
}

/// Returns the number of full calendar days between [a] and [b].
/// Positive when [b] is after [a].
int daysBetween(DateTime a, DateTime b) {
  final dateA = DateTime(a.year, a.month, a.day);
  final dateB = DateTime(b.year, b.month, b.day);
  return dateB.difference(dateA).inDays;
}

/// Formats a DateTime as "15 nov 2026".
String formatDate(DateTime d) {
  return '${d.day} ${_monthAbbr(d.month)} ${d.year}';
}

/// Formats a DateTime as "15 nov".
String formatShortDate(DateTime d) {
  return '${d.day} ${_monthAbbr(d.month)}';
}

/// Formats a DateTime as "18:00".
String formatTime(DateTime d) {
  final h = d.hour.toString().padLeft(2, '0');
  final m = d.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

/// Formats an offset as "D-12", "Día del evento" or "D+2".
String formatOffset(int days) {
  if (days == 0) return 'Día del evento';
  if (days < 0) return 'D${days}';
  return 'D+$days';
}

/// Parses "2026-12-20" into a DateTime (date only). Returns null on failure.
DateTime? parseDate(String s) {
  try {
    final parts = s.split('-');
    if (parts.length != 3) return null;
    final y = int.parse(parts[0]);
    final mo = int.parse(parts[1]);
    final d = int.parse(parts[2]);
    return DateTime(y, mo, d);
  } catch (_) {
    return null;
  }
}

/// Parses "18:00" into a DateTime with today's date. Returns null on failure.
DateTime? parseTime(String s) {
  try {
    final parts = s.split(':');
    if (parts.length != 2) return null;
    final h = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, h, m);
  } catch (_) {
    return null;
  }
}

String _monthAbbr(int month) {
  const abbrs = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
  ];
  return abbrs[month - 1];
}
