import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rempah_apps/Auth/login.dart';

void main() {
  testWidgets('Harus ada tulisan Username', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));
    expect(find.text('Username'), findsOneWidget);
  });
  testWidgets('Harus Ada tulisan Password', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));
    expect(find.text('Password'), findsOneWidget);
  });
  testWidgets('Harus ada tombol login', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));
    expect(find.text('LOGIN'), findsOneWidget);
  });
  testWidgets('Apabila belum punya akun ..', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));
    expect(find.text("Don't have an account?"), findsOneWidget);
  });
  testWidgets('Harus Ada fitur Signup', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));
    expect(find.text("SIGN UP"), findsOneWidget);
  });
}
