import 'dart:io';
import 'dart:math';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Pinterest App', () {
    FlutterDriver driver;
    final idTextForm = find.byValueKey('id_text_form');
    final emailTextForm = find.byValueKey('email_text_form');
    final passwordTextForm = find.byValueKey('password_text_form');
    final confirmPasswordTextForm =
        find.byValueKey('confirm_password_text_form');
    final signupNavigateButton = find.byValueKey('signup_button');
    final loginNavigateButton = find.byValueKey('login_button');
    final confirmButton = find.byValueKey('confirm_button');
    final createAccountFromMailButton =
        find.byValueKey('create_account_from_mail_button');
    final loginIdTextForm = find.byValueKey('login_id_text_form');
    final loginPasswordTextForm = find.byValueKey('login_password_text_form');
    final loginConfirmButton = find.byValueKey('login_confirm_button');

    String id = '';

    setUp(() async {
      driver = await FlutterDriver.connect();
    });

    tearDown(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('go to signup failed(same id)', () async {
      await driver.tap(signupNavigateButton);
      await driver.tap(createAccountFromMailButton);
      await driver.tap(idTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(emailTextForm);
      await driver.enterText('abetatsu@gmail.com');
      await driver.tap(passwordTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(confirmPasswordTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(confirmButton);
    });

    test('go to signup failed(invalid password)', () async {
      await driver.tap(idTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(emailTextForm);
      await driver.enterText('abetatsu@gmail.com');
      await driver.tap(passwordTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(confirmPasswordTextForm);
      await driver.enterText('abetatsu2');
      await driver.tap(confirmButton);
    });

    test('go to signup failed(invalid email)', () async {
      await driver.tap(idTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(emailTextForm);
      await driver.enterText('abetatsu@gmail.');
      await driver.tap(passwordTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(confirmPasswordTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(confirmButton);
    });

    test('go to signup success', () async {
      await driver.tap(idTextForm);
      id = randomString(10);
      await driver.enterText(id);
      await driver.tap(emailTextForm);
      await driver.enterText('abetatsu@gmail.com');
      await driver.tap(passwordTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(confirmPasswordTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(confirmButton);
    });

    test('go to login form', () async {
      await driver.tap(loginNavigateButton);
      await driver.tap(loginIdTextForm);
      await driver.enterText(id);
      await driver.tap(loginPasswordTextForm);
      await driver.enterText('abetatsu');
      await driver.tap(loginConfirmButton);
    });
  });
}

Future<void> takeScreenshot(FlutterDriver driver, String path) async {
  print('will take screenshot $path');
  await driver.waitUntilNoTransientCallbacks();
  final pixels = await driver.screenshot();
  final file = File(path);
  await file.writeAsBytes(pixels);
  print('wrote $file');
}

String randomString(int length) {
  const _randomChars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  const _charsLength = _randomChars.length;

  final rand = Random();
  final codeUnits = List.generate(
    length,
    (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },
  );
  return String.fromCharCodes(codeUnits);
}
