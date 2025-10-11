import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'classes_page.dart';
import 'students_page.dart';
import 'resources_page.dart';
import 'schedule_page.dart';
import 'discussions_page.dart';
import 'organizations_page.dart';
import 'auth_service.dart';

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
      home: const AuthWrapper(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await AuthService.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5C6BC0)),
          ),
        ),
      );
    }

    return _isLoggedIn ? const HomeScreen() : const LoginPage();
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
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                await AuthService.clearLoginData();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              },
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




