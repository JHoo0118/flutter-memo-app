import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/models/note.dart';
import 'package:memo/pages/home_page.dart';
import 'package:memo/storage/shared_preferences.dart';
import 'package:memo/theme/theme_provider.dart';
import 'package:memo/utils/my_custom_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // sharedPreferences
  final sharedPrefs = await SharedPreferences.getInstance();
  sharedPrefs.setString('theme', 'dark');

  // timeago
  timeago.setLocaleMessages('ko', MyCustomMessages());

  // initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  // open a hive box
  await Hive.openBox<Note>('note_database');
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeStateNotifierProvider);
    return MaterialApp(
      title: 'Memo App',
      debugShowCheckedModeBanner: false,
      theme: theme.value,
      home: const HomePage(),
    );
  }
}
