import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/storage/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

class Pallete {
  // Colors
  static const primaryColor = Color(0xff7367f0);
  static const secondaryColor = Color(0xff82868b);
  static const successColor = Color(0xff28c76f);
  static const infoColor = Color(0xff00cfe8);
  static const warningColor = Color(0xffff9f43);
  static const dangerColor = Color(0xffea5455);
  static const lightColor = Color(0xfff6f6f6);
  static const darkColor = Color(0xff252422);
  static const blackColor = Color(0xff000000);
  static const whiteColor = Color(0xffffffff);
  static const borderColor = Color(0xffD8D6DE);
  static const placeholderColor = Color(0xffB9B9C3);
  static const disabledColor = Color(0xffF3F2F7);

  // static var redColor = Colors.red.shade500;
  // static var blueColor = Colors.blue.shade300;

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          background: darkColor,
          brightness: Brightness.dark,
        ),
    // textTheme: const TextTheme().apply(bodyColor: whiteColor),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, // android
        statusBarBrightness: Brightness.dark, // iOS
      ),
    ),
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    colorScheme: ThemeData.light().colorScheme.copyWith(
          background: CupertinoColors.systemGroupedBackground,
          brightness: Brightness.light,
        ),
    // textTheme: const TextTheme().apply(bodyColor: blackColor),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: darkColor,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: blackColor,
        systemNavigationBarColor: darkColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
}

@riverpod
class ThemeStateNotifier extends _$ThemeStateNotifier {
  @override
  FutureOr<ThemeData> build() async {
    return _getTheme();
  }

  void getTheme() async {
    state = await AsyncValue.guard(() => _getTheme());
  }

  Future<ThemeData> _getTheme() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    final theme = prefs.getString('theme');
    if (theme == 'light') {
      return Pallete.lightModeAppTheme;
    } else {
      return Pallete.darkModeAppTheme;
    }
  }

  Future<String> _toggleTheme() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    final theme = prefs.getString('theme') ?? 'dark';
    if (theme == 'dark') {
      prefs.setString('theme', 'light');
    } else {
      prefs.setString('theme', 'dark');
    }
    return theme;
  }

  void toggleTheme() async {
    state = await AsyncValue.guard(() async {
      final theme = await _toggleTheme();
      return theme == "dark"
          ? Pallete.lightModeAppTheme
          : Pallete.darkModeAppTheme;
    });
  }
}
