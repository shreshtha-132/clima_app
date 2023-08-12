import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2result =
      await task2(); // wait till task 2 is complete before returning
  task3(task2result);
}

void task1() {
  String task1 = " this is task 1";
  print("task 1 done");
}

Future task2() async {
  Duration threeseconds = Duration(seconds: 3);

  String result = "";

  await Future.delayed(threeseconds, () {
    result = " this is task 2";
    print("task 2 done");
  });

  return result;
}

void task3(String task2data) {
  String task3 = " this is task 3";
  print("task 3 done with $task2data");
}
