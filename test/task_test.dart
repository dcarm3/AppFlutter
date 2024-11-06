import 'package:flutter_test/flutter_test.dart';
import 'package:aplicativo/models/task.dart';

//dois testes unitarios pedidos na atividade :)
void main() {
  test('adicionar uma nova tarefa na lista', () {
    List<Task> tasks = [];
    Task task = Task(title: 'Nova Tarefa', description: 'Descrição legal');
    tasks.add(task);
    expect(tasks.length, 1);
    expect(tasks[0].title, 'Nova Tarefa');
  });

  test('Remover uma tarefa da lista de tarefas', () {
    List<Task> tasks = [
      Task(title: 'Tarefa 1', description: 'Descrição legal 1')
    ];
    tasks.removeAt(0);
    expect(tasks.length, 0);
  });
}
