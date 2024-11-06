import 'package:flutter_test/flutter_test.dart';
import 'package:aplicativo/models/task.dart';

//dois testes unitarios pedidos na atividade :)
void main() {
  test('Deve adicionar uma nova tarefa na lista de tarefas', () {
    List<Task> tasks = [];
    Task task = Task(title: 'Nova Tarefa', description: 'Descrição da tarefa');

    tasks.add(task);

    expect(tasks.length, 1);
    expect(tasks[0].title, 'Nova Tarefa');
  });

  test('Deve remover uma tarefa da lista de tarefas', () {
    List<Task> tasks = [
      Task(title: 'Tarefa 1', description: 'Descrição da tarefa 1')
    ];

    tasks.removeAt(0);

    expect(tasks.length, 0);
  });
}
