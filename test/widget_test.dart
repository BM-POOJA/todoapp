import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/task_provider.dart';
import 'package:todoapp/screens/homescreen.dart';

void main() {
  testWidgets('Add and display a task', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.text("No tasks yet."), findsOneWidget);

    // Open dialog
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter task
    await tester.enterText(find.byType(TextField).at(0), "Test Task");
    await tester.enterText(find.byType(TextField).at(1), "Task Description");
    await tester.tap(find.text("Add"));
    await tester.pumpAndSettle();

    expect(find.text("Test Task"), findsOneWidget);
    expect(find.text("Task Description"), findsOneWidget);
  });
}
