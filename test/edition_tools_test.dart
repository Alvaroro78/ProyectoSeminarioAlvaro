import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_seminario_alvaro/data/mock_data.dart';
import 'package:proyecto_seminario_alvaro/logic/messages.dart';
import 'package:proyecto_seminario_alvaro/logic/registrations.dart';
import 'package:proyecto_seminario_alvaro/logic/tasks.dart';

void main() {
  final today = DateTime(2026, 11, 8);
  final seriesA = buildMockSeries(today).firstWhere((s) => s.id == 'seriesA');
  final ed4 = seriesA.editions.firstWhere((e) => e.number == 4);

  test('Resumen de tareas de la edición 4: 2 de 7 hechas · 1 atrasada', () {
    expect(tasksSummary(ed4, today), '2 de 7 hechas · 1 atrasada');
  });

  test('Publicar la invitación: D-10 · 5 nov y Atrasada 3 días', () {
    final task =
        ed4.tasks.firstWhere((t) => t.title == 'Publicar la invitación');
    expect(taskDueText(task, ed4.dateTime), 'D-10 · 5 nov');
    expect(taskStatusText(task, ed4.dateTime, today), 'Atrasada 3 días');
  });

  test('Invitación de la edición 4: D-12 · 3 nov y enviada', () {
    final invitation = ed4.messages.firstWhere((m) => m.type == 'invitation');
    expect(messageSendText(invitation, ed4.dateTime), 'D-12 · 3 nov');
    expect(messageStatusText(invitation, ed4.dateTime, today), 'Enviado');
    expect(sentCount(ed4), 1);
  });

  test('Buscar inscritos de la edición 4 por código y por apellido', () {
    final byCode = searchRegistrations(ed4.registrations, 'R4-003');
    expect(byCode.map((r) => r.userName).toList(), ['Mariana Ospina']);
    final byName = searchRegistrations(ed4.registrations, 'ospina');
    expect(byName.map((r) => r.userName).toList(), ['Mariana Ospina']);
  });

  test('Cargo tiene 1 respuesta en la edición 4', () {
    final cargo = ed4.fields.firstWhere((f) => f.label == 'Cargo');
    expect(answersCount(ed4, cargo.id), 1);
  });
}
