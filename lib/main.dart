import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'classes_page.dart';
import 'students_page.dart';
import 'resources_page.dart';
import 'schedule_page.dart';
import 'discussions_page.dart';
import 'organizations_page.dart';

void main() {
  runApp(const StaffRoomApp());
}

class StaffRoomApp extends StatelessWidget {
  const StaffRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StaffRoom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C6BC0)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StaffRoom')),
      drawer: const _SideMenu(),
      body: const Center(
        child: Text('Welcome! Use the sidebar to navigate.'),
      ),
    );
  }
}

class _SideMenu extends StatelessWidget {
  const _SideMenu();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ListTile(
              leading: Icon(Icons.school),
              title: Text(
                'StaffRoom',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            _navButton(
              context: context,
              icon: Icons.home,
              label: 'Dashboard',
              pageBuilder: (ctx) => const DashboardPage(),
            ),
            _navButton(
              context: context,
              icon: Icons.class_,
              label: 'Classes',
              pageBuilder: (ctx) => const ClassesPage(),
            ),
            _navButton(
              context: context,
              icon: Icons.people,
              label: 'Students',
              pageBuilder: (ctx) => const StudentsPage(),
            ),
            _navButton(
              context: context,
              icon: Icons.folder,
              label: 'Resources',
              pageBuilder: (ctx) => const ResourcesPage(),
            ),
            _navButton(
              context: context,
              icon: Icons.calendar_today,
              label: 'Schedule',
              pageBuilder: (ctx) => const SchedulePage(),
            ),
            _navButton(
              context: context,
              icon: Icons.chat_bubble,
              label: 'Discussions',
              pageBuilder: (ctx) => const DiscussionsPage(),
            ),
            _navButton(
              context: context,
              icon: Icons.apartment,
              label: 'Organizations',
              pageBuilder: (ctx) => const OrganizationsPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required WidgetBuilder pageBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(label),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: pageBuilder),
          );
        },
      ),
    );
  }
}


