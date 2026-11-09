import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_seminario_alvaro/data/mock_data.dart';
import 'package:proyecto_seminario_alvaro/logic/cloning.dart';
import 'package:proyecto_seminario_alvaro/logic/dates.dart';
import 'package:proyecto_seminario_alvaro/logic/recommendations.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/logic/savings.dart';
import 'package:proyecto_seminario_alvaro/logic/templates.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';
import 'package:proyecto_seminario_alvaro/models/registration.dart';

void main() {
  final today = DateTime(2026, 11, 8);
  late List<EventSeries> allSeries;
  late EventSeries seriesA;
  late EventSeries seriesB;

  setUp(() {
    allSeries = buildMockSeries(today);
    seriesA = allSeries.firstWhere((s) => s.id == 'seriesA');
    seriesB = allSeries.firstWhere((s) => s.id == 'seriesB');
  });

  test('Historial de la edición 4 son las ediciones 1, 2 y 3', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final history = historyFor(seriesA, ed4);
    expect(history.map((e) => e.number).toList(), [1, 2, 3]);
  });

  test('Tasa de asistencia del historial (eds 1-3): 41/58 ≈ 0.7069', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final history = historyFor(seriesA, ed4);
    final rate = attendanceRate(history);
    expect(history.fold(0, (s, e) => s + e.registrations.where((r) => r.attended).length), 41);
    expect(history.fold(0, (s, e) => s + e.registrations.length), 58);
    expect((rate * 10000).round() / 10000, closeTo(41 / 58, 0.0001));
  });

  test('R1 en edición 4: cupo sugerido 28 (cupo actual 20)', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final recs = buildRecommendations(seriesA, ed4);
    final r1 = recs.where((r) => r.rule == 'R1').toList();
    expect(r1.length, 1);
    expect(r1.first.value, 28);
  });

  test('R2 en edición 4: Publicar la invitación D-10 → D-13 y Enviar el agradecimiento D+2 → D+1', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final recs = buildRecommendations(seriesA, ed4);
    final r2 = recs.where((r) => r.rule == 'R2').toList();

    final pubInv = r2.where((r) => r.reference == 'Publicar la invitación').toList();
    expect(pubInv.length, 1);
    expect(pubInv.first.value, -13);

    final envAgrad = r2.where((r) => r.reference == 'Enviar el agradecimiento').toList();
    expect(envAgrad.length, 1);
    expect(envAgrad.first.value, 1);

    final reservar = r2.where((r) => r.reference == 'Reservar el auditorio').toList();
    expect(reservar.isEmpty, true);
  });

  test('R2 en edición 5: añade Reservar el auditorio D-21 → D-25', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final dateEd5 = DateTime(2026, 12, 20, 18, 0);
    final ed5 = cloneEdition(ed4, 'edA5', dateEd5, ed4.place, ed4.capacity, ed4.quota);
    final seriesWithEd5 = seriesA.copyWith(
      editions: [...seriesA.editions, ed5],
    );
    final recs = buildRecommendations(seriesWithEd5, ed5);
    final r2 = recs.where((r) => r.rule == 'R2').toList();

    final reservar = r2.where((r) => r.reference == 'Reservar el auditorio').toList();
    expect(reservar.length, 1);
    expect(reservar.first.value, -25);
  });

  test('R3 en edición 4: ninguna (Cargo y ¿Cómo te enteraste? tienen respuestas en la 4)', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final recs = buildRecommendations(seriesA, ed4);
    final r3 = recs.where((r) => r.rule == 'R3').toList();
    expect(r3.isEmpty, true);
  });

  test('R3 en edición 5: Cargo 8/58 (14%) y ¿Cómo te enteraste? 9/58 (16%)', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final dateEd5 = DateTime(2026, 12, 20, 18, 0);
    final ed5 = cloneEdition(ed4, 'edA5', dateEd5, ed4.place, ed4.capacity, ed4.quota);
    final seriesWithEd5 = seriesA.copyWith(
      editions: [...seriesA.editions, ed5],
    );
    final recs = buildRecommendations(seriesWithEd5, ed5);
    final r3 = recs.where((r) => r.rule == 'R3').toList();

    final cargo = r3.where((r) => r.reference == 'Cargo').toList();
    expect(cargo.length, 1);
    expect(cargo.first.evidence, contains('8 de 58'));

    final comoEntero = r3.where((r) => r.reference == '¿Cómo te enteraste del evento?').toList();
    expect(comoEntero.length, 1);
    expect(comoEntero.first.evidence, contains('9 de 58'));
  });

  test('R4 en edición 4: 6 personas frecuentes en orden', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final recs = buildRecommendations(seriesA, ed4);
    final r4 = recs.where((r) => r.rule == 'R4').toList();
    expect(r4.length, 1);
    final names = r4.first.people.map((p) => p.split(' · ').first).toList();
    expect(names, [
      'Camila Herrera',
      'Isabella Zapata',
      'Julián Arango',
      'Nicolás Restrepo',
      'Santiago Morales',
      'Valentina Ríos',
    ]);
  });

  test('R4 en edición 5: 14 personas frecuentes (p03–p16)', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final dateEd5 = DateTime(2026, 12, 20, 18, 0);
    final ed5 = cloneEdition(ed4, 'edA5', dateEd5, ed4.place, ed4.capacity, ed4.quota);
    final seriesWithEd5 = seriesA.copyWith(
      editions: [...seriesA.editions, ed5],
    );
    final recs = buildRecommendations(seriesWithEd5, ed5);
    final r4 = recs.where((r) => r.rule == 'R4').toList();
    expect(r4.length, 1);
    expect(r4.first.people.length, 14);
  });

  test('R5 en edición 4: espera 6 asistentes (8 × 0.7069 = 5.66 → 6)', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final recs = buildRecommendations(seriesA, ed4);
    final r5 = recs.where((r) => r.rule == 'R5').toList();
    expect(r5.length, 1);
    expect(r5.first.value, 6);
  });

  test('R5 en edición 5: no aplica (0 inscritos)', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final dateEd5 = DateTime(2026, 12, 20, 18, 0);
    final ed5 = cloneEdition(ed4, 'edA5', dateEd5, ed4.place, ed4.capacity, ed4.quota);
    final seriesWithEd5 = seriesA.copyWith(
      editions: [...seriesA.editions, ed5],
    );
    final recs = buildRecommendations(seriesWithEd5, ed5);
    final r5 = recs.where((r) => r.rule == 'R5').toList();
    expect(r5.isEmpty, true);
  });

  test('Reutilizado ed1: 0%', () {
    final ed1 = seriesA.editions.firstWhere((e) => e.number == 1);
    expect(reusedPercent(ed1), 0);
  });

  test('Reutilizado ed2: 100%', () {
    final ed2 = seriesA.editions.firstWhere((e) => e.number == 2);
    expect(reusedPercent(ed2), 100);
  });

  test('Reutilizado ed3: 100%', () {
    final ed3 = seriesA.editions.firstWhere((e) => e.number == 3);
    expect(reusedPercent(ed3), 100);
  });

  test('Reutilizado ed4: 88% (14 de 16: fA1-fA5 y 3 messages y 6 tasks inherited, fA6 and tarea7 not)', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    expect(reusedPercent(ed4), 88);
  });

  test('Reutilizado ed5 (clon de ed4): 100% (16 de 16)', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final dateEd5 = DateTime(2026, 12, 20, 18, 0);
    final ed5 = cloneEdition(ed4, 'edA5', dateEd5, ed4.place, ed4.capacity, ed4.quota);
    expect(reusedPercent(ed5), 100);
  });

  test('R1 en ed5 con ed4 cerrada sin asistentes: historial eds 2,3,4; 27/46; cupo 34', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final ed4Closed = ed4.copyWith(status: 'closed');
    final dateEd5 = DateTime(2026, 12, 20, 18, 0);
    final ed5 = cloneEdition(ed4Closed, 'edA5', dateEd5, ed4.place, ed4.capacity, ed4.quota);
    final seriesWithClosed4 = seriesA.copyWith(
      editions: [
        seriesA.editions.firstWhere((e) => e.number == 1),
        seriesA.editions.firstWhere((e) => e.number == 2),
        seriesA.editions.firstWhere((e) => e.number == 3),
        ed4Closed,
        ed5,
      ],
    );
    final history = historyFor(seriesWithClosed4, ed5);
    expect(history.map((e) => e.number).toList(), [2, 3, 4]);

    final attended = history.fold(0, (s, e) => s + e.registrations.where((r) => r.attended).length);
    final registered = history.fold(0, (s, e) => s + e.registrations.length);
    expect(attended, 27);
    expect(registered, 46);

    final recs = buildRecommendations(seriesWithClosed4, ed5);
    final r1 = recs.where((r) => r.rule == 'R1').toList();
    expect(r1.length, 1);
    expect(r1.first.value, 34);
  });

  test('Fecha propuesta para edición 5: 20 dic 2026 (15 nov + 35 días)', () {
    final proposed = proposeDate(seriesA, today);
    expect(proposed.year, 2026);
    expect(proposed.month, 12);
    expect(proposed.day, 20);
  });

  test('Fecha propuesta edición 2 serie B: hoy + 7 (30 ago + 30 ya pasó)', () {
    final proposed = proposeDate(seriesB, today);
    final expected = DateTime(today.year, today.month, today.day + 7);
    expect(proposed.year, expected.year);
    expect(proposed.month, expected.month);
    expect(proposed.day, expected.day);
  });

  test('Recomendaciones en ed2 de serie B: ninguna (1 edición cerrada)', () {
    final edB1 = seriesB.editions.first;
    final edB2 = Edition(
      id: 'edB2',
      seriesId: 'seriesB',
      sourceEditionId: 'edB1',
      number: 2,
      dateTime: DateTime(2026, 11, 15, 9, 0),
      place: edB1.place,
      capacity: edB1.capacity,
      quota: edB1.quota,
      status: 'draft',
      fields: [],
      messages: [],
      tasks: [],
      registrations: [],
      decisions: [],
    );
    final seriesBWith2 = seriesB.copyWith(editions: [edB1, edB2]);
    final recs = buildRecommendations(seriesBWith2, edB2);
    expect(recs.isEmpty, true);
  });

  test('Fecha límite de Reservar el auditorio en ed5: 29 nov 2026', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final dateEd5 = DateTime(2026, 12, 20, 18, 0);
    final ed5 = cloneEdition(ed4, 'edA5', dateEd5, ed4.place, ed4.capacity, ed4.quota);
    final reservar = ed5.tasks.firstWhere((t) => t.title == 'Reservar el auditorio');
    final due = dueDate(ed5.dateTime, reservar.offsetDays);
    expect(due.year, 2026);
    expect(due.month, 11);
    expect(due.day, 29);
  });

  test('Tarea atrasada en ed4: Publicar la invitación, 3 días', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final pub = ed4.tasks.firstWhere((t) => t.title == 'Publicar la invitación');
    expect(pub.doneAt, isNull);
    final due = dueDate(ed4.dateTime, pub.offsetDays);
    final delay = daysBetween(due, today);
    expect(delay, 3);
  });

  test('Siguiente código en edición 4: R4-009', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    expect(nextRegistrationCode(ed4), 'R4-009');
  });

  test('Vista previa de invitación de ed4', () {
    final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);
    final inv = ed4.messages.firstWhere((m) => m.type == 'invitation');
    final values = messageValues(seriesA, ed4);
    final preview = fillTemplate(inv.body, values);
    expect(
      preview,
      'Hola invitado: el 15 nov 2026 a las 18:00 tendremos '
      'Ciclo de charlas de analítica de datos · Edición 4 en '
      'Auditorio principal · Edificio A. Inscríbete desde la app; los cupos son limitados.',
    );
  });

  test('Eventos que ve Valentina: ed4 de seriesA (12 cupos) y ed1 de seriesC (0 cupos)', () {
    final published = allSeries.expand((s) => s.editions).where((e) {
      if (e.status != 'published') return false;
      final eventDay = DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day);
      final todayDay = DateTime(today.year, today.month, today.day);
      return eventDay.isAfter(todayDay);
    }).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    expect(published.length, 2);

    final ed4 = published.firstWhere((e) => e.seriesId == 'seriesA');
    expect(freeSpots(ed4), 12);

    final edC1 = published.firstWhere((e) => e.seriesId == 'seriesC');
    expect(freeSpots(edC1), 0);
  });

  test('Serie con 2 ediciones cerradas sin asistentes no da R1 ni lanza error', () {
    final edClosed1 = Edition(
      id: 'edZ1',
      seriesId: 'seriesZ',
      sourceEditionId: null,
      number: 1,
      dateTime: DateTime(2026, 9, 1),
      place: 'Lugar',
      capacity: 20,
      quota: 20,
      status: 'closed',
      fields: const [],
      messages: const [],
      tasks: const [],
      registrations: [
        Registration(
          id: 'regZ1',
          userId: 'p01',
          userName: 'Ana',
          userEmail: 'ana@correo.co',
          code: 'R1-001',
          registeredAt: DateTime(2026, 8, 25),
          attended: false,
          answers: const {},
        ),
      ],
      decisions: const [],
    );
    final edClosed2 = Edition(
      id: 'edZ2',
      seriesId: 'seriesZ',
      sourceEditionId: 'edZ1',
      number: 2,
      dateTime: DateTime(2026, 10, 1),
      place: 'Lugar',
      capacity: 20,
      quota: 20,
      status: 'closed',
      fields: const [],
      messages: const [],
      tasks: const [],
      registrations: [
        Registration(
          id: 'regZ2',
          userId: 'p02',
          userName: 'Juan',
          userEmail: 'juan@correo.co',
          code: 'R2-001',
          registeredAt: DateTime(2026, 9, 25),
          attended: false,
          answers: const {},
        ),
      ],
      decisions: const [],
    );
    final edDraft3 = Edition(
      id: 'edZ3',
      seriesId: 'seriesZ',
      sourceEditionId: 'edZ2',
      number: 3,
      dateTime: DateTime(2026, 12, 1),
      place: 'Lugar',
      capacity: 20,
      quota: 20,
      status: 'draft',
      fields: const [],
      messages: const [],
      tasks: const [],
      registrations: const [],
      decisions: const [],
    );
    final seriesZ = EventSeries(
      id: 'seriesZ',
      organizerId: 'u-laura',
      name: 'Serie sin asistentes',
      description: 'Prueba',
      editions: [edClosed1, edClosed2, edDraft3],
    );

    final recs = buildRecommendations(seriesZ, edDraft3);
    final r1 = recs.where((r) => r.rule == 'R1').toList();
    expect(r1.isEmpty, true);
  });

  test('Tarea con retrasos -3, 2 y 2 sugiere adelantar 2 días', () {
    EventTask taskForEd(String id, DateTime eventDate, int offsetDays, int delay) {
      final due = dueDate(eventDate, offsetDays);
      return EventTask(
        id: id,
        title: 'Comprar materiales',
        owner: 'Logística',
        offsetDays: offsetDays,
        doneAt: DateTime(due.year, due.month, due.day + delay),
        inherited: false,
      );
    }

    final d1 = DateTime(2026, 8, 1);
    final d2 = DateTime(2026, 9, 1);
    final d3 = DateTime(2026, 10, 1);
    final d4 = DateTime(2026, 11, 15);

    Edition makeClosed(int num, DateTime dt, int delay) {
      return Edition(
        id: 'edT$num',
        seriesId: 'seriesT',
        number: num,
        dateTime: dt,
        place: 'Lugar',
        capacity: 20,
        quota: 20,
        status: 'closed',
        fields: const [],
        messages: const [],
        tasks: [taskForEd('taskT$num', dt, -10, delay)],
        registrations: [
          Registration(
            id: 'regT$num',
            userId: 'p01',
            userName: 'Ana',
            userEmail: 'ana@correo.co',
            code: 'R$num-001',
            registeredAt: DateTime(2026, 7, 1),
            attended: true,
            answers: const {},
          ),
        ],
        decisions: const [],
      );
    }

    final ed1 = makeClosed(1, d1, -3);
    final ed2 = makeClosed(2, d2, 2);
    final ed3 = makeClosed(3, d3, 2);

    final ed4 = Edition(
      id: 'edT4',
      seriesId: 'seriesT',
      number: 4,
      dateTime: d4,
      place: 'Lugar',
      capacity: 20,
      quota: 20,
      status: 'draft',
      fields: const [],
      messages: const [],
      tasks: const [
        EventTask(
          id: 'taskT4',
          title: 'Comprar materiales',
          owner: 'Logística',
          offsetDays: -10,
          doneAt: null,
          inherited: true,
        ),
      ],
      registrations: const [],
      decisions: const [],
    );

    final seriesT = EventSeries(
      id: 'seriesT',
      organizerId: 'u-laura',
      name: 'Serie Tareas',
      description: 'Prueba',
      editions: [ed1, ed2, ed3, ed4],
    );

    final recs = buildRecommendations(seriesT, ed4);
    final r2 = recs.where((r) => r.rule == 'R2' && r.reference == 'Comprar materiales').toList();
    expect(r2.length, 1);
    expect(r2.first.value, -12);
  });
}
