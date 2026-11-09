import 'package:proyecto_seminario_alvaro/models/app_user.dart';
import 'package:proyecto_seminario_alvaro/models/edition.dart';
import 'package:proyecto_seminario_alvaro/models/event_message.dart';
import 'package:proyecto_seminario_alvaro/models/event_series.dart';
import 'package:proyecto_seminario_alvaro/models/event_task.dart';
import 'package:proyecto_seminario_alvaro/models/registration.dart';
import 'package:proyecto_seminario_alvaro/models/registration_field.dart';

/// Builds the list of all mock users.
List<AppUser> buildMockUsers() {
  return [
    // Organizers
    const AppUser(
      id: 'u-laura',
      name: 'Laura Gómez',
      email: 'laura@eventos.co',
      password: '123456',
      role: 'organizer',
    ),
    const AppUser(
      id: 'u-jorge',
      name: 'Jorge Ramírez',
      email: 'jorge@eventos.co',
      password: '123456',
      role: 'organizer',
    ),
    // Attendees p01–p25
    const AppUser(
      id: 'p01',
      name: 'Ana María Torres',
      email: 'ana.torres@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p02',
      name: 'Juan David Rojas',
      email: 'juan.rojas@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p03',
      name: 'Camila Herrera',
      email: 'camila.herrera@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p04',
      name: 'Santiago Morales',
      email: 'santiago.morales@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p05',
      name: 'Daniela Castillo',
      email: 'daniela.castillo@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p06',
      name: 'Felipe Cardona',
      email: 'felipe.cardona@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p07',
      name: 'Mariana Ospina',
      email: 'mariana.ospina@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p08',
      name: 'Andrés Quintero',
      email: 'andres.quintero@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p09',
      name: 'Paula Andrea Vélez',
      email: 'paula.velez@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p10',
      name: 'Sebastián Muñoz',
      email: 'sebastian.munoz@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p11',
      name: 'Natalia Guzmán',
      email: 'natalia.guzman@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p12',
      name: 'Mateo Salazar',
      email: 'mateo.salazar@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p13',
      name: 'Valentina Ríos',
      email: 'valentina.rios@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p14',
      name: 'Julián Arango',
      email: 'julian.arango@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p15',
      name: 'Isabella Zapata',
      email: 'isabella.zapata@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p16',
      name: 'Nicolás Restrepo',
      email: 'nicolas.restrepo@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p17',
      name: 'Sara Londoño',
      email: 'sara.londono@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p18',
      name: 'Tomás Giraldo',
      email: 'tomas.giraldo@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p19',
      name: 'Manuela Duque',
      email: 'manuela.duque@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p20',
      name: 'Alejandro Pineda',
      email: 'alejandro.pineda@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p21',
      name: 'Gabriela Montoya',
      email: 'gabriela.montoya@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p22',
      name: 'Esteban Correa',
      email: 'esteban.correa@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p23',
      name: 'Luisa Fernanda Ruiz',
      email: 'luisa.ruiz@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p24',
      name: 'David Escobar',
      email: 'david.escobar@correo.co',
      password: '123456',
      role: 'attendee',
    ),
    const AppUser(
      id: 'p25',
      name: 'Carolina Mesa',
      email: 'carolina.mesa@correo.co',
      password: '123456',
      role: 'attendee',
    ),
  ];
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

DateTime _date(DateTime today, int offsetDays) {
  return DateTime(today.year, today.month, today.day + offsetDays, 18, 0);
}

/// Registration date rule: event date − (2 + i % 10) days.
/// i is the person index (1-based: p01 → 1).
DateTime _regDate(DateTime eventDate, int i) {
  return DateTime(
    eventDate.year,
    eventDate.month,
    eventDate.day - (2 + i % 10),
  );
}

// ─── Serie A fields (shared across editions 1–4) ─────────────────────────────

List<RegistrationField> _seriesAFields({required bool inherited}) {
  return [
    RegistrationField(
        id: 'fA1', label: 'Celular', type: 'text', isRequired: true,  order: 1, inherited: inherited),
    RegistrationField(
        id: 'fA2', label: 'Empresa u organización', type: 'text', isRequired: false, order: 2, inherited: inherited),
    RegistrationField(
        id: 'fA3', label: 'Cargo', type: 'text', isRequired: false, order: 3, inherited: inherited),
    RegistrationField(
        id: 'fA4', label: '¿Cómo te enteraste del evento?', type: 'text', isRequired: false, order: 4, inherited: inherited),
    RegistrationField(
        id: 'fA5', label: '¿Necesitas certificado?', type: 'yesNo', isRequired: false, order: 5, inherited: inherited),
    RegistrationField(
        id: 'fA6', label: '¿Tienes alguna restricción alimentaria?', type: 'text', isRequired: false, order: 6, inherited: inherited),
  ];
}

// Field fA6 only exists in edition 4, non-inherited.

// ─── Serie A messages ────────────────────────────────────────────────────────

EventMessage _invMsg({required bool sent, required bool inherited, required String edId}) =>
    EventMessage(
      id: 'mInv-$edId',
      type: 'invitation',
      subject: 'Te esperamos en {evento}',
      body:
          'Hola {nombre}: el {fecha} a las {hora} tendremos {evento} en {lugar}. Inscríbete desde la app; los cupos son limitados.',
      offsetDays: -12,
      sent: sent,
      inherited: inherited,
    );

EventMessage _remMsg({required bool sent, required bool inherited, required String edId}) =>
    EventMessage(
      id: 'mRem-$edId',
      type: 'reminder',
      subject: 'Mañana es {evento}',
      body:
          'Hola {nombre}: te esperamos mañana a las {hora} en {lugar}. Ten a mano tu código de inscripción.',
      offsetDays: -1,
      sent: sent,
      inherited: inherited,
    );

EventMessage _thanksMsg({required bool sent, required bool inherited, required String edId}) =>
    EventMessage(
      id: 'mThanks-$edId',
      type: 'thanks',
      subject: 'Gracias por venir a {evento}',
      body:
          'Hola {nombre}: gracias por acompañarnos. Pronto te contamos la fecha de la próxima edición.',
      offsetDays: 1,
      sent: sent,
      inherited: inherited,
    );

// ─── Answer builder ───────────────────────────────────────────────────────────
// Person index i (1-based). Fields fA1–fA5 for eds 1-3; fA1–fA6 for ed4.

Map<String, String> _answers(int i, {bool hasF6 = false}) {
  final m = <String, String>{};
  // fA1: all respond
  m['fA1'] = '300 555 01${i.toString().padLeft(2, '0')}';
  // fA2: i % 4 != 0
  if (i % 4 != 0) m['fA2'] = 'Organización $i';
  // fA3: i % 7 == 0
  if (i % 7 == 0) m['fA3'] = 'Analista de datos';
  // fA4: i % 6 == 0
  if (i % 6 == 0) m['fA4'] = 'Por un colega';
  // fA5: i odd
  if (i % 2 != 0) m['fA5'] = (i % 4 == 1) ? 'Sí' : 'No';
  // fA6: only ed4, i % 5 == 0
  if (hasF6 && i % 5 == 0) m['fA6'] = 'Vegetariano';
  return m;
}

// ─── Registration builder ─────────────────────────────────────────────────────

Registration _reg(
  int personIndex, // 1-based (p01 → 1)
  String userId,
  String userName,
  String userEmail,
  String editionNumber, // '1', '2', etc.
  int consecutiveInEdition, // 1-based within edition
  DateTime eventDate,
  bool attended, {
  bool hasF6 = false,
}) {
  final code = 'R$editionNumber-${consecutiveInEdition.toString().padLeft(3, '0')}';
  return Registration(
    id: 'reg-${userId}-ed$editionNumber',
    userId: userId,
    userName: userName,
    userEmail: userEmail,
    code: code,
    registeredAt: _regDate(eventDate, personIndex),
    attended: attended,
    answers: _answers(personIndex, hasF6: hasF6),
  );
}

// ─── Task builder ─────────────────────────────────────────────────────────────

/// Builds an edition-specific task with its doneAt date.
/// [delay] is the signed offset in days beyond the due date (negative = early).
/// If delay is provided but the task is considered not done, pass doneAt = null.
EventTask _task({
  required String id,
  required String title,
  required String owner,
  required int offsetDays,
  required bool inherited,
  DateTime? eventDate,
  int? delay, // null = not done
}) {
  DateTime? doneAt;
  if (delay != null && eventDate != null) {
    final due = DateTime(
      eventDate.year,
      eventDate.month,
      eventDate.day + offsetDays,
    );
    doneAt = DateTime(due.year, due.month, due.day + delay);
  }
  return EventTask(
    id: id,
    title: title,
    owner: owner,
    offsetDays: offsetDays,
    doneAt: doneAt,
    inherited: inherited,
  );
}

// ─── User info lookup ─────────────────────────────────────────────────────────

const _users = {
  'p01': ('Ana María Torres', 'ana.torres@correo.co'),
  'p02': ('Juan David Rojas', 'juan.rojas@correo.co'),
  'p03': ('Camila Herrera', 'camila.herrera@correo.co'),
  'p04': ('Santiago Morales', 'santiago.morales@correo.co'),
  'p05': ('Daniela Castillo', 'daniela.castillo@correo.co'),
  'p06': ('Felipe Cardona', 'felipe.cardona@correo.co'),
  'p07': ('Mariana Ospina', 'mariana.ospina@correo.co'),
  'p08': ('Andrés Quintero', 'andres.quintero@correo.co'),
  'p09': ('Paula Andrea Vélez', 'paula.velez@correo.co'),
  'p10': ('Sebastián Muñoz', 'sebastian.munoz@correo.co'),
  'p11': ('Natalia Guzmán', 'natalia.guzman@correo.co'),
  'p12': ('Mateo Salazar', 'mateo.salazar@correo.co'),
  'p13': ('Valentina Ríos', 'valentina.rios@correo.co'),
  'p14': ('Julián Arango', 'julian.arango@correo.co'),
  'p15': ('Isabella Zapata', 'isabella.zapata@correo.co'),
  'p16': ('Nicolás Restrepo', 'nicolas.restrepo@correo.co'),
  'p17': ('Sara Londoño', 'sara.londono@correo.co'),
  'p18': ('Tomás Giraldo', 'tomas.giraldo@correo.co'),
  'p19': ('Manuela Duque', 'manuela.duque@correo.co'),
  'p20': ('Alejandro Pineda', 'alejandro.pineda@correo.co'),
  'p21': ('Gabriela Montoya', 'gabriela.montoya@correo.co'),
  'p22': ('Esteban Correa', 'esteban.correa@correo.co'),
  'p23': ('Luisa Fernanda Ruiz', 'luisa.ruiz@correo.co'),
  'p24': ('David Escobar', 'david.escobar@correo.co'),
  'p25': ('Carolina Mesa', 'carolina.mesa@correo.co'),
};

String _uName(String id) => _users[id]!.$1;
String _uEmail(String id) => _users[id]!.$2;
int _uIndex(String id) => int.parse(id.substring(1)); // 'p07' → 7

// ─── Main builder ─────────────────────────────────────────────────────────────

/// Builds all mock series with dates relative to [today].
List<EventSeries> buildMockSeries(DateTime today) {
  // ── SERIE A: Ciclo de charlas de analítica de datos ────────────────────────
  final dateA1 = _date(today, -84); // hoy − 84 = 16 ago
  final dateA2 = _date(today, -56); // hoy − 56 = 13 sep
  final dateA3 = _date(today, -28); // hoy − 28 = 11 oct
  final dateA4 = _date(today, 7);   // hoy + 7  = 15 nov

  // Edition 1: p01–p20 inscribed (20), p01–p14 attended (14). All inherited=false.
  final ed1Ids = ['p01','p02','p03','p04','p05','p06','p07','p08',
                   'p09','p10','p11','p12','p13','p14','p15','p16',
                   'p17','p18','p19','p20'];
  final ed1Attended = {'p01','p02','p03','p04','p05','p06','p07',
                        'p08','p09','p10','p11','p12','p13','p14'};

  final regs1 = [
    for (var i = 0; i < ed1Ids.length; i++)
      _reg(
        _uIndex(ed1Ids[i]),
        ed1Ids[i], _uName(ed1Ids[i]), _uEmail(ed1Ids[i]),
        '1', i + 1, dateA1,
        ed1Attended.contains(ed1Ids[i]),
      ),
  ];

  final edition1 = Edition(
    id: 'edA1',
    seriesId: 'seriesA',
    sourceEditionId: null,
    number: 1,
    dateTime: dateA1,
    place: 'Auditorio principal · Edificio A',
    capacity: 20,
    quota: 20,
    status: 'closed',
    fields: _seriesAFields(inherited: false).where((f) => f.id != 'fA6').toList(),
    messages: [
      _invMsg(sent: true, inherited: false, edId: 'edA1'),
      _remMsg(sent: true, inherited: false, edId: 'edA1'),
      _thanksMsg(sent: true, inherited: false, edId: 'edA1'),
    ],
    tasks: [
      _task(id: 'tA1-1', title: 'Reservar el auditorio',    owner: 'Laura', offsetDays: -21, inherited: false, eventDate: dateA1, delay: 4),
      _task(id: 'tA1-2', title: 'Confirmar al conferencista', owner: 'Laura', offsetDays: -14, inherited: false, eventDate: dateA1, delay: -1),
      _task(id: 'tA1-3', title: 'Publicar la invitación',   owner: 'Comunicaciones', offsetDays: -10, inherited: false, eventDate: dateA1, delay: 3),
      _task(id: 'tA1-4', title: 'Pedir los refrigerios',    owner: 'Logística', offsetDays: -3, inherited: false, eventDate: dateA1, delay: 0),
      _task(id: 'tA1-5', title: 'Imprimir la lista de asistencia', owner: 'Logística', offsetDays: -1, inherited: false, eventDate: dateA1, delay: 0),
      _task(id: 'tA1-6', title: 'Enviar el agradecimiento', owner: 'Comunicaciones', offsetDays: 2, inherited: false, eventDate: dateA1, delay: 0),
    ],
    registrations: regs1,
    decisions: [],
  );

  // Edition 2: p03–p22 inscribed (20), p03–p16 attended (14). All inherited=true.
  final ed2Ids = ['p03','p04','p05','p06','p07','p08','p09','p10',
                   'p11','p12','p13','p14','p15','p16','p17','p18',
                   'p19','p20','p21','p22'];
  final ed2Attended = {'p03','p04','p05','p06','p07','p08','p09',
                        'p10','p11','p12','p13','p14','p15','p16'};

  final regs2 = [
    for (var i = 0; i < ed2Ids.length; i++)
      _reg(
        _uIndex(ed2Ids[i]),
        ed2Ids[i], _uName(ed2Ids[i]), _uEmail(ed2Ids[i]),
        '2', i + 1, dateA2,
        ed2Attended.contains(ed2Ids[i]),
      ),
  ];

  final edition2 = Edition(
    id: 'edA2',
    seriesId: 'seriesA',
    sourceEditionId: 'edA1',
    number: 2,
    dateTime: dateA2,
    place: 'Auditorio principal · Edificio A',
    capacity: 20,
    quota: 20,
    status: 'closed',
    fields: _seriesAFields(inherited: true).where((f) => f.id != 'fA6').toList(),
    messages: [
      _invMsg(sent: true, inherited: true, edId: 'edA2'),
      _remMsg(sent: true, inherited: true, edId: 'edA2'),
      _thanksMsg(sent: true, inherited: true, edId: 'edA2'),
    ],
    tasks: [
      _task(id: 'tA2-1', title: 'Reservar el auditorio',    owner: 'Laura', offsetDays: -21, inherited: true, eventDate: dateA2, delay: 3),
      _task(id: 'tA2-2', title: 'Confirmar al conferencista', owner: 'Laura', offsetDays: -14, inherited: true, eventDate: dateA2, delay: 0),
      _task(id: 'tA2-3', title: 'Publicar la invitación',   owner: 'Comunicaciones', offsetDays: -10, inherited: true, eventDate: dateA2, delay: 2),
      _task(id: 'tA2-4', title: 'Pedir los refrigerios',    owner: 'Logística', offsetDays: -3, inherited: true, eventDate: dateA2, delay: 1),
      _task(id: 'tA2-5', title: 'Imprimir la lista de asistencia', owner: 'Logística', offsetDays: -1, inherited: true, eventDate: dateA2, delay: 0),
      _task(id: 'tA2-6', title: 'Enviar el agradecimiento', owner: 'Comunicaciones', offsetDays: 2, inherited: true, eventDate: dateA2, delay: 2),
    ],
    registrations: regs2,
    decisions: [],
  );

  // Edition 3: p05–p22 inscribed (18), p05–p17 attended (13). All inherited=true.
  final ed3Ids = ['p05','p06','p07','p08','p09','p10','p11','p12',
                   'p13','p14','p15','p16','p17','p18','p19','p20',
                   'p21','p22'];
  final ed3Attended = {'p05','p06','p07','p08','p09','p10','p11',
                        'p12','p13','p14','p15','p16','p17'};

  final regs3 = [
    for (var i = 0; i < ed3Ids.length; i++)
      _reg(
        _uIndex(ed3Ids[i]),
        ed3Ids[i], _uName(ed3Ids[i]), _uEmail(ed3Ids[i]),
        '3', i + 1, dateA3,
        ed3Attended.contains(ed3Ids[i]),
      ),
  ];

  final edition3 = Edition(
    id: 'edA3',
    seriesId: 'seriesA',
    sourceEditionId: 'edA2',
    number: 3,
    dateTime: dateA3,
    place: 'Auditorio principal · Edificio A',
    capacity: 20,
    quota: 20,
    status: 'closed',
    fields: _seriesAFields(inherited: true).where((f) => f.id != 'fA6').toList(),
    messages: [
      _invMsg(sent: true, inherited: true, edId: 'edA3'),
      _remMsg(sent: true, inherited: true, edId: 'edA3'),
      _thanksMsg(sent: true, inherited: true, edId: 'edA3'),
    ],
    tasks: [
      _task(id: 'tA3-1', title: 'Reservar el auditorio',    owner: 'Laura', offsetDays: -21, inherited: true, eventDate: dateA3, delay: 5),
      _task(id: 'tA3-2', title: 'Confirmar al conferencista', owner: 'Laura', offsetDays: -14, inherited: true, eventDate: dateA3, delay: -2),
      _task(id: 'tA3-3', title: 'Publicar la invitación',   owner: 'Comunicaciones', offsetDays: -10, inherited: true, eventDate: dateA3, delay: 4),
      _task(id: 'tA3-4', title: 'Pedir los refrigerios',    owner: 'Logística', offsetDays: -3, inherited: true, eventDate: dateA3, delay: 0),
      _task(id: 'tA3-5', title: 'Imprimir la lista de asistencia', owner: 'Logística', offsetDays: -1, inherited: true, eventDate: dateA3, delay: -1),
      _task(id: 'tA3-6', title: 'Enviar el agradecimiento', owner: 'Comunicaciones', offsetDays: 2, inherited: true, eventDate: dateA3, delay: 1),
    ],
    registrations: regs3,
    decisions: [],
  );

  // Edition 4: p05–p12 inscribed (8), nobody attended yet. Fields 1-5 inherited, fA6 not inherited.
  // Task "Reservar el auditorio" done with delay +3 (D-18).
  // Task "Confirmar al conferencista" done with delay 0 (D-14).
  // Others pending.
  final ed4Ids = ['p05','p06','p07','p08','p09','p10','p11','p12'];

  final regs4 = [
    for (var i = 0; i < ed4Ids.length; i++)
      _reg(
        _uIndex(ed4Ids[i]),
        ed4Ids[i], _uName(ed4Ids[i]), _uEmail(ed4Ids[i]),
        '4', i + 1, dateA4,
        false, // nobody attended yet
        hasF6: true,
      ),
  ];

  final edition4 = Edition(
    id: 'edA4',
    seriesId: 'seriesA',
    sourceEditionId: 'edA3',
    number: 4,
    dateTime: dateA4,
    place: 'Auditorio principal · Edificio A',
    capacity: 20,
    quota: 20,
    status: 'published',
    fields: [
      ..._seriesAFields(inherited: true).where((f) => f.id != 'fA6'),
      RegistrationField(
        id: 'fA6', label: '¿Tienes alguna restricción alimentaria?',
        type: 'text', isRequired: false, order: 6, inherited: false,
      ),
    ],
    messages: [
      _invMsg(sent: true,  inherited: true, edId: 'edA4'),
      _remMsg(sent: false, inherited: true, edId: 'edA4'),
      _thanksMsg(sent: false, inherited: true, edId: 'edA4'),
    ],
    tasks: [
      _task(id: 'tA4-1', title: 'Reservar el auditorio',    owner: 'Laura', offsetDays: -21, inherited: true, eventDate: dateA4, delay: 3),
      _task(id: 'tA4-2', title: 'Confirmar al conferencista', owner: 'Laura', offsetDays: -14, inherited: true, eventDate: dateA4, delay: 0),
      _task(id: 'tA4-3', title: 'Publicar la invitación',   owner: 'Comunicaciones', offsetDays: -10, inherited: true), // pending
      _task(id: 'tA4-4', title: 'Pedir los refrigerios',    owner: 'Logística', offsetDays: -3, inherited: true), // pending
      _task(id: 'tA4-5', title: 'Imprimir la lista de asistencia', owner: 'Logística', offsetDays: -1, inherited: true), // pending
      _task(id: 'tA4-6', title: 'Enviar el agradecimiento', owner: 'Comunicaciones', offsetDays: 2, inherited: true), // pending
      _task(id: 'tA4-7', title: 'Probar el video beam',     owner: 'Logística', offsetDays: -1, inherited: false), // pending, not inherited
    ],
    registrations: regs4,
    decisions: [],
  );

  final seriesA = EventSeries(
    id: 'seriesA',
    organizerId: 'u-laura',
    name: 'Ciclo de charlas de analítica de datos',
    description:
        'Charla mensual de una hora sobre analítica de datos aplicada, con un invitado de la industria.',
    editions: [edition1, edition2, edition3, edition4],
  );

  // ── SERIE B: Taller trimestral de primeros auxilios ────────────────────────
  final dateB1 = _date(today, -70); // hoy − 70 = 30 ago; keep time 09:00
  final dateB1At9 = DateTime(dateB1.year, dateB1.month, dateB1.day, 9, 0);

  final ed1BIds = ['p01','p02','p03','p04','p05','p06','p07','p08','p09','p10'];
  final ed1BAttended = {'p01','p02','p03','p04','p05','p06','p07','p08'};

  final regsB1 = [
    for (var i = 0; i < ed1BIds.length; i++)
      Registration(
        id: 'reg-${ed1BIds[i]}-edB1',
        userId: ed1BIds[i],
        userName: _uName(ed1BIds[i]),
        userEmail: _uEmail(ed1BIds[i]),
        code: 'R1-${(i + 1).toString().padLeft(3, '0')}',
        registeredAt: _regDate(dateB1At9, _uIndex(ed1BIds[i])),
        attended: ed1BAttended.contains(ed1BIds[i]),
        answers: {
          'fB1': '300 555 01${_uIndex(ed1BIds[i]).toString().padLeft(2, '0')}',
          if (_uIndex(ed1BIds[i]) % 3 == 0) 'fB2': 'Sí',
        },
      ),
  ];

  final editionB1 = Edition(
    id: 'edB1',
    seriesId: 'seriesB',
    sourceEditionId: null,
    number: 1,
    dateTime: dateB1At9,
    place: 'Salón 204 · Edificio B',
    capacity: 15,
    quota: 15,
    status: 'closed',
    fields: [
      const RegistrationField(id: 'fB1', label: 'Celular', type: 'text', isRequired: true,  order: 1, inherited: false),
      const RegistrationField(id: 'fB2', label: '¿Tienes formación previa en primeros auxilios?', type: 'yesNo', isRequired: false, order: 2, inherited: false),
    ],
    messages: [
      EventMessage(
        id: 'mBInv-edB1',
        type: 'invitation',
        subject: 'Te esperamos en {evento}',
        body: 'Hola {nombre}: el {fecha} a las {hora} tendremos {evento} en {lugar}. Inscríbete desde la app; los cupos son limitados.',
        offsetDays: -10,
        sent: true,
        inherited: false,
      ),
      EventMessage(
        id: 'mBRem-edB1',
        type: 'reminder',
        subject: 'Mañana es {evento}',
        body: 'Hola {nombre}: te esperamos mañana a las {hora} en {lugar}. Ten a mano tu código de inscripción.',
        offsetDays: -1,
        sent: true,
        inherited: false,
      ),
    ],
    tasks: [
      // "Reservar el salón": D-10, hecha en D-11 → delay = -1
      _task(id: 'tB1-1', title: 'Reservar el salón', owner: 'Laura', offsetDays: -10, inherited: false, eventDate: dateB1At9, delay: -1),
      // "Conseguir los maniquíes": D-5, hecha en D-3 → delay = +2
      _task(id: 'tB1-2', title: 'Conseguir los maniquíes', owner: 'Logística', offsetDays: -5, inherited: false, eventDate: dateB1At9, delay: 2),
    ],
    registrations: regsB1,
    decisions: [],
  );

  final seriesB = EventSeries(
    id: 'seriesB',
    organizerId: 'u-laura',
    name: 'Taller trimestral de primeros auxilios',
    description:
        'Taller práctico de primeros auxilios básicos para personal administrativo.',
    editions: [editionB1],
  );

  // ── SERIE C: Club de lectura de ingeniería ─────────────────────────────────
  final dateC1 = _date(today, 14); // hoy + 14 = 22 nov; keep time 19:00
  final dateC1At19 = DateTime(dateC1.year, dateC1.month, dateC1.day, 19, 0);

  final ed1CIds = ['p14','p15','p16','p17','p18','p19','p20','p21','p22','p23','p24','p25'];

  final regsC1 = [
    for (var i = 0; i < ed1CIds.length; i++)
      Registration(
        id: 'reg-${ed1CIds[i]}-edC1',
        userId: ed1CIds[i],
        userName: _uName(ed1CIds[i]),
        userEmail: _uEmail(ed1CIds[i]),
        code: 'R1-${(i + 1).toString().padLeft(3, '0')}',
        registeredAt: _regDate(dateC1At19, _uIndex(ed1CIds[i])),
        attended: false,
        answers: {
          'fC1': '300 555 01${_uIndex(ed1CIds[i]).toString().padLeft(2, '0')}',
        },
      ),
  ];

  // "Elegir el libro": D-21, hecha en D-25 → delay = -4 (early by 4)
  // "Reservar la sala": D-7, pending
  final editionC1 = Edition(
    id: 'edC1',
    seriesId: 'seriesC',
    sourceEditionId: null,
    number: 1,
    dateTime: dateC1At19,
    place: 'Biblioteca · Sala 3',
    capacity: 12,
    quota: 12,
    status: 'published',
    fields: [
      const RegistrationField(id: 'fC1', label: 'Celular', type: 'text', isRequired: true, order: 1, inherited: false),
    ],
    messages: [
      EventMessage(
        id: 'mCInv-edC1',
        type: 'invitation',
        subject: 'Te esperamos en {evento}',
        body: 'Hola {nombre}: el {fecha} a las {hora} tendremos {evento} en {lugar}. Inscríbete desde la app; los cupos son limitados.',
        offsetDays: -14,
        sent: true,
        inherited: false,
      ),
    ],
    tasks: [
      _task(id: 'tC1-1', title: 'Elegir el libro', owner: 'Jorge', offsetDays: -21, inherited: false, eventDate: dateC1At19, delay: -4),
      _task(id: 'tC1-2', title: 'Reservar la sala', owner: 'Jorge', offsetDays: -7, inherited: false),
    ],
    registrations: regsC1,
    decisions: [],
  );

  final seriesC = EventSeries(
    id: 'seriesC',
    organizerId: 'u-jorge',
    name: 'Club de lectura de ingeniería',
    description: 'Encuentro para comentar un libro técnico en cada edición.',
    editions: [editionC1],
  );

  return [seriesA, seriesB, seriesC];
}
