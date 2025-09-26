import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab06_dart/main.dart';

void main() {
  testWidgets('Calendar UI smoke test', (WidgetTester tester) async {
    // 1. Construimos nuestra nueva app: CalendarApp
    await tester.pumpWidget(CalendarApp());

    // 2. Verificamos que el título de la AppBar sea correcto.
    // Esto comprueba que la app se ha cargado correctamente.
    expect(find.text('Calendario Semanal'), findsOneWidget);

    // 3. Verificamos que uno de los días de la semana está presente.
    expect(find.text('L'), findsOneWidget);
  });
}