import 'package:flutter/material.dart';

void main() {
  runApp(const GMManagerApp());
}

class GMManagerApp extends StatelessWidget {
  const GMManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GM Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      ),
      home: const GMHome(),
    );
  }
}

class GMHome extends StatefulWidget {
  const GMHome({super.key});

  @override
  State<GMHome> createState() => _GMHomeState();
}

class _GMHomeState extends State<GMHome> {
  int page = 0;

  final pages = const [
    HomePage(),
    ContentPage(),
    AssistantPage(),
    ToolsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[page]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (i) => setState(() => page = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Content',
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_toy_outlined),
            selectedIcon: Icon(Icons.smart_toy),
            label: 'GM AI',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'Tools',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ───────────────── HOME ─────────────────

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('GM Manager'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _hero(context),
              const SizedBox(height: 24),
              const Text(
                'Your Manager',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _grid(context),
              const SizedBox(height: 24),
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _quick(
                context,
                Icons.add_photo_alternate_outlined,
                'Create Post',
                'Prepare a new Instagram post',
              ),
              _quick(
                context,
                Icons.auto_stories_outlined,
                'Create Story',
                'Build your next Story',
              ),
              _quick(
                context,
                Icons.collections_outlined,
                'Create Collage',
                'Combine photos into a layout',
              ),
              _quick(
                context,
                Icons.star_outline,
                'Highlights',
                'Manage your profile Highlights',
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _hero(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              child: Icon(
                Icons.auto_awesome,
                size: 34,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to GM',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your personal AI assistant and social-media manager.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _grid(BuildContext context) {
    final items = [
      ('Posts', Icons.photo_library_outlined),
      ('Stories', Icons.auto_stories_outlined),
      ('Collage', Icons.collections_outlined),
      ('Highlights', Icons.star_outline),
      ('Planner', Icons.calendar_month_outlined),
      ('Analytics', Icons.analytics_outlined),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, i) {
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _open(context, items[i].$1, items[i].$2),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(items[i].$2, size: 32),
                  const SizedBox(height: 10),
                  Text(
                    items[i].$1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _quick(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _open(context, title, icon),
      ),
    );
  }

  void _open(BuildContext context, String title, IconData icon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeaturePage(title: title, icon: icon),
      ),
    );
  }
}

// ───────────────── CONTENT ─────────────────

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      ('Posts', Icons.photo_library_outlined),
      ('Instagram Stories', Icons.auto_stories_outlined),
      ('Reels', Icons.video_library_outlined),
      ('Collage Creator', Icons.collections_outlined),
      ('Highlights Manager', Icons.star_outline),
      ('Content Calendar', Icons.calendar_month_outlined),
      ('Drafts', Icons.drafts_outlined),
      ('Saved Ideas', Icons.lightbulb_outline),
    ];

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Content Manager'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final f = features[i];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(f.$2)),
                    title: Text(f.$1),
                    subtitle: Text(_description(f.$1)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FeaturePage(
                            title: f.$1,
                            icon: f.$2,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: features.length,
            ),
          ),
        ),
      ],
    );
  }

  String _description(String title) {
    switch (title) {
      case 'Posts':
        return 'Create and manage feed posts';
      case 'Instagram Stories':
        return 'Build and organize Stories';
      case 'Reels':
        return 'Plan short-form video content';
      case 'Collage Creator':
        return 'Create multi-photo layouts';
      case 'Highlights Manager':
        return 'Organize profile Highlights';
      case 'Content Calendar':
        return 'Plan upcoming content';
      case 'Drafts':
        return 'Keep unfinished content';
      default:
        return 'Save and organize ideas';
    }
  }
}

// ───────────────── AI ─────────────────

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final input = TextEditingController();

  final messages = <String>[
    'GM: Hello! I am your personal GM Assistant.',
    'GM: I can help plan content, captions, Stories, Reels, Collages and Highlights.',
  ];

  void send() {
    final text = input.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add('You: $text');
      messages.add(_reply(text));
      input.clear();
    });
  }

  String _reply(String text) {
    final lower = text.toLowerCase();

    if (lower.contains('caption')) {
      return 'GM: Tell me the photo or post theme and I can help you create caption ideas.';
    }

    if (lower.contains('story')) {
      return 'GM: I can help you structure a Story sequence with an opening, main content and call-to-action.';
    }

    if (lower.contains('collage')) {
      return 'GM: Choose your photos and I can help you decide the best collage layout.';
    }

    if (lower.contains('highlight')) {
      return 'GM: We can organize Highlights into categories such as Travel, Lifestyle, Work and Memories.';
    }

    return 'GM: I understand. Tell me whether you want to create, plan, improve or manage your content.';
  }

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GM AI Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final mine = messages[i].startsWith('You:');

                return Align(
                  alignment:
                      mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(messages[i]),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: input,
                      onSubmitted: (_) => send(),
                      decoration: const InputDecoration(
                        hintText: 'Ask GM...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: send,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────── TOOLS ─────────────────

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      ('Photo Enhancement', Icons.photo_filter_outlined),
      ('Natural Pose', Icons.accessibility_new_outlined),
      ('Collage Creator', Icons.grid_view_outlined),
      ('Story Builder', Icons.auto_stories_outlined),
      ('Caption Studio', Icons.edit_outlined),
      ('Hashtag Manager', Icons.tag_outlined),
      ('Content Planner', Icons.calendar_month_outlined),
      ('Analytics', Icons.analytics_outlined),
      ('Highlight Manager', Icons.star_outline),
      ('Reel Planner', Icons.video_library_outlined),
    ];

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('GM Tools'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FeaturePage(
                            title: tools[i].$1,
                            icon: tools[i].$2,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(tools[i].$2, size: 34),
                        const SizedBox(height: 12),
                        Text(
                          tools[i].$1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: tools.length,
            ),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),
          ),
        ),
      ],
    );
  }
}

// ───────────────── SETTINGS ─────────────────

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool autoSave = true;
  bool privateMode = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Settings'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const Text(
                'GM Manager',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SwitchListTile(
                title: const Text('Notifications'),
                subtitle: const Text('Content reminders'),
                value: notifications,
                onChanged: (v) {
                  setState(() => notifications = v);
                },
              ),
              SwitchListTile(
                title: const Text('Auto Save'),
                subtitle: const Text('Automatically save projects'),
                value: autoSave,
                onChanged: (v) {
                  setState(() => autoSave = v);
                },
              ),
              SwitchListTile(
                title: const Text('Private Mode'),
                subtitle: const Text('Keep projects private on device'),
                value: privateMode,
                onChanged: (v) {
                  setState(() => privateMode = v);
                },
              ),
              const Divider(height: 30),
              const Text(
                'Instagram',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const ListTile(
                leading: Icon(Icons.link),
                title: Text('Instagram Account'),
                subtitle: Text('Not connected'),
                trailing: Icon(Icons.chevron_right),
              ),
              const ListTile(
                leading: Icon(Icons.security),
                title: Text('Privacy & Security'),
                trailing: Icon(Icons.chevron_right),
              ),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About GM Manager'),
                subtitle: Text('Version 1.0.0'),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

// ───────────────── FEATURE PAGE ─────────────────

class FeaturePage extends StatelessWidget {
  final String title;
  final IconData icon;

  const FeaturePage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 44,
            child: Icon(icon, size: 44),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _info(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          FilledButton.icon(
            onPressed: () => _action(context),
            icon: const Icon(Icons.add),
            label: const Text('Create New'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => _action(context),
            icon: const Icon(Icons.folder_open),
            label: const Text('Open Workspace'),
          ),
          const SizedBox(height: 25),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Icon(Icons.auto_awesome, size: 40),
                  SizedBox(height: 12),
                  Text(
                    'GM Workspace',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Create, organize and manage your social content from GM Manager.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _info() {
    switch (title) {
      case 'Photo Enhancement':
        return 'Improve presentation while preserving natural appearance and identity.';
      case 'Natural Pose':
        return 'Plan natural-looking pose improvements without changing body structure.';
      case 'Collage Creator':
        return 'Build clean multi-photo layouts for social content.';
      case 'Instagram Stories':
        return 'Plan and organize Story sequences.';
      case 'Highlights Manager':
        return 'Organize your profile Highlights into categories.';
      case 'Analytics':
        return 'Track content performance when an analytics connection is available.';
      default:
        return 'GM Manager workspace for creating and organizing your content.';
    }
  }

  void _action(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title workspace opened')),
    );
  }
}
