import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aplicativo/screens/home_screen.dart';

//teste de widget pedido na atividade :)
void main() {
  testWidgets(
      'Deve mostrar mensagem "Nenhuma tarefa ou nota adicionada ainda" se a lista estiver vazia',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(
        find.text('Nenhuma tarefa ou nota adicionada ainda'), findsOneWidget);
  });
}
