/// Navigation arguments for a screen that works with one edition.
class EditionArgs {
  final dynamic series; // EventSeries — imported lazily to avoid circular deps
  final dynamic edition; // Edition

  const EditionArgs({required this.series, required this.edition});
}

/// Navigation arguments for the event detail screen (attendee side).
class EventArgs {
  final dynamic series; // EventSeries
  final dynamic edition; // Edition
  final dynamic user; // AppUser

  const EventArgs({
    required this.series,
    required this.edition,
    required this.user,
  });
}
