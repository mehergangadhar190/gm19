import 'package:flutter/material.dart';

void main() {
  runApp(const GMManagerApp());
}

class GMManagerApp extends StatelessWidget {
  const GMManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GM Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF0B0F0D),
        cardTheme: CardThemeData(
          color: const Color(0xFF151A17),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
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
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    ContentPage(),
    PlannerPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111512),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Content',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Planner',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DASHBOARD
// ============================================================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          backgroundColor: const Color(0xFF0B0F0D),
          title: const Text(
            'GM Manager',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () => showInfo(
                context,
                'GM Assistant',
                'GM is your personal Instagram and social-media manager. '
                    'Use the tools below to plan, prepare and review your content.',
              ),
              icon: const Icon(Icons.auto_awesome),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const _WelcomeCard(),
              const SizedBox(height: 18),
              _SectionTitle(
                title: 'Today',
                action: 'View plan',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              const _TodayCard(),
              const SizedBox(height: 22),
              _SectionTitle(
                title: 'AI Post Suggestions',
                action: 'Open',
                onTap: () => showFeature(context, 'AI Post Suggestions'),
              ),
              const SizedBox(height: 10),
              const _AISuggestionCard(),
              const SizedBox(height: 22),
              const _SectionTitle(title: 'GM Features'),
              const SizedBox(height: 10),
              _FeatureGrid(context),
              const SizedBox(height: 22),
              const _SectionTitle(title: 'What GM can decide for you'),
              const SizedBox(height: 10),
              const _DecisionList(),
              const SizedBox(height: 20),
              const _NaturalLookNotice(),
            ]),
          ),
        ),
      ],
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.greenAccent,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good to see you.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'GM is ready to plan your next post.',
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.today, color: Colors.greenAccent),
                SizedBox(width: 10),
                Text(
                  'Today’s recommendation',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Prepare one clean lifestyle photo for your next Instagram post.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _SmallTag(text: 'Natural'),
                _SmallTag(text: 'Premium'),
                _SmallTag(text: 'Clean'),
              ],
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => showFeature(context, 'Today’s Plan'),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Open plan'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AISuggestionCard extends StatelessWidget {
  const _AISuggestionCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.psychology, color: Colors.greenAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Choose 2–3 photos',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'GM will help compare your photos and prepare a post recommendation.',
              style: TextStyle(color: Colors.white60),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        showFeature(context, 'Photo Selection'),
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                    label: const Text('Choose photos'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _FeatureGrid(BuildContext context) {
  final features = [
    ('Photo Studio', Icons.camera_alt_outlined),
    ('Planner', Icons.calendar_month_outlined),
    ('Analytics', Icons.analytics_outlined),
    ('Approval', Icons.verified_outlined),
    ('Stories & Collage', Icons.auto_stories_outlined),
    ('Highlights Manager', Icons.star_outline),
  ];

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: features.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.45,
    ),
    itemBuilder: (context, index) {
      final item = features[index];

      return Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => showFeature(context, item.$1),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.$2, color: Colors.greenAccent),
                const SizedBox(height: 10),
                Text(
                  item.$1,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _DecisionList extends StatelessWidget {
  const _DecisionList();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Best photo', Icons.photo_outlined),
      ('Natural pose suggestion', Icons.accessibility_new),
      ('Aesthetic recommendation', Icons.palette_outlined),
      ('Music suggestion', Icons.music_note_outlined),
      ('Caption writing', Icons.edit_outlined),
      ('Best posting time', Icons.schedule),
    ];

    return Card(
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            ListTile(
              leading: Icon(items[i].$2, color: Colors.greenAccent),
              title: Text(items[i].$1),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            if (i != items.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

class _NaturalLookNotice extends StatelessWidget {
  const _NaturalLookNotice();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.verified_user_outlined,
              color: Colors.greenAccent,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'GM keeps your look natural. No face or body-structure changes.',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CONTENT
// ============================================================

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
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = features[index];

                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => showFeature(context, item.$1),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.$2,
                            size: 34,
                            color: Colors.greenAccent,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item.$1,
                            textAlign: TextAlign.center,
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
              childCount: features.length,
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

// ============================================================
// PLANNER
// ============================================================

class PlannerPage extends StatelessWidget {
  const PlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final days = [
      ('MON', 'Photo post', '7:30 PM'),
      ('TUE', 'Story', '12:30 PM'),
      ('WED', 'Reel idea', '8:00 PM'),
      ('THU', 'Story', '6:30 PM'),
      ('FRI', 'Main post', '7:00 PM'),
      ('SAT', 'Collage', '5:30 PM'),
      ('SUN', 'Rest / review', '—'),
    ];

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Content Planner'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Weekly strategy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Plan posts, stories and ideas before publishing.',
                        style: TextStyle(color: Colors.white60),
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => showFeature(
                          context,
                          'Create Content Plan',
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Create plan'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              for (final day in days)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Colors.green.withValues(alpha: .15),
                      child: Text(
                        day.$1.substring(0, 1),
                        style: const TextStyle(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                    title: Text(day.$2),
                    subtitle: Text(day.$3),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
            ]),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// PROFILE / PERSONAL AI MEMORY
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      ('Personal Style', 'Natural • Premium • Clean', Icons.style),
      ('Face Identity', 'Reference protected', Icons.face),
      ('Body Proportions', 'Do not alter', Icons.accessibility_new),
      ('Communication', 'Your normal style', Icons.chat_outlined),
      ('Aesthetic', 'Simple • Professional', Icons.palette_outlined),
      ('Approval', 'Manual approval required', Icons.verified_outlined),
    ];

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('GM Profile'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundColor:
                            Colors.green.withValues(alpha: .15),
                        child: const Icon(
                          Icons.person,
                          size: 36,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal AI Memory',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Your preferences for GM',
                              style:
                                  TextStyle(color: Colors.white60),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              for (final setting in settings)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(
                      setting.$3,
                      color: Colors.greenAccent,
                    ),
                    title: Text(setting.$1),
                    subtitle: Text(setting.$2),
                    trailing:
                        const Icon(Icons.chevron_right),
                    onTap: () => showFeature(
                      context,
                      setting.$1,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Card(
                child: SwitchListTile(
                  value: true,
                  onChanged: (value) {},
                  title: const Text('Require approval before posting'),
                  subtitle: const Text(
                    'GM never publishes without your approval.',
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// REUSABLE UI
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;

  const _SectionTitle({
    required this.title,
    this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onTap,
            child: Text(action!),
          ),
      ],
    );
  }
}

class _SmallTag extends StatelessWidget {
  final String text;

  const _SmallTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 12,
        ),
      ),
    );
  }
}

// ============================================================
// FEATURE SCREEN
// ============================================================

void showFeature(BuildContext context, String feature) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => FeaturePage(title: feature),
    ),
  );
}

class FeaturePage extends StatelessWidget {
  final String title;

  const FeaturePage({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final data = featureData(title);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    data.icon,
                    size: 48,
                    color: Colors.greenAccent,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...data.actions.map(
            (action) => Card(
              child: ListTile(
                leading: Icon(
                  action.icon,
                  color: Colors.greenAccent,
                ),
                title: Text(action.title),
                subtitle: Text(action.subtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showInfo(
                    context,
                    action.title,
                    action.message,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureInfo {
  final IconData icon;
  final String description;
  final List<FeatureAction> actions;

  FeatureInfo({
    required this.icon,
    required this.description,
    required this.actions,
  });
}

class FeatureAction {
  final String title;
  final String subtitle;
  final String message;
  final IconData icon;

  FeatureAction({
    required this.title,
    required this.subtitle,
    required this.message,
    required this.icon,
  });
}

FeatureInfo featureData(String title) {
  switch (title) {
    case 'Photo Studio':
      return FeatureInfo(
        icon: Icons.camera_alt_outlined,
        description:
            'Prepare photos with a natural, premium and professional direction.',
        actions: [
          FeatureAction(
            title: 'Choose photos',
            subtitle: 'Select 2–3 candidate photos',
            message:
                'Photo selection interface is ready. '
                'Connect a device photo picker in the next integration stage.',
            icon: Icons.photo_library_outlined,
          ),
          FeatureAction(
            title: 'Natural pose',
            subtitle: 'Pose guidance without changing identity',
            message:
                'GM can provide pose guidance while preserving your face and body structure.',
            icon: Icons.accessibility_new,
          ),
          FeatureAction(
            title: 'Editing direction',
            subtitle: 'Premium but not over-edited',
            message:
                'Recommended direction: natural lighting, clean color, realistic skin and subtle background improvements.',
            icon: Icons.tune,
          ),
        ],
      );

    case 'AI Post Suggestions':
      return FeatureInfo(
        icon: Icons.psychology,
        description:
            'Compare your candidate photos and prepare a complete post recommendation.',
        actions: [
          FeatureAction(
            title: 'Best photo',
            subtitle: 'Select the strongest candidate',
            message:
                'GM will compare composition, expression, lighting and overall fit.',
            icon: Icons.photo,
          ),
          FeatureAction(
            title: 'Caption',
            subtitle: 'Write a matching caption',
            message:
                'Caption style: natural, simple, confident and professional.',
            icon: Icons.edit,
          ),
          FeatureAction(
            title: 'Music',
            subtitle: 'Recommend suitable music',
            message:
                'Music should match the visual mood and content type.',
            icon: Icons.music_note,
          ),
          FeatureAction(
            title: 'Posting time',
            subtitle: 'Choose the best time',
            message:
                'Audience analytics can be connected later to calculate personalized posting times.',
            icon: Icons.schedule,
          ),
        ],
      );

    case 'Stories & Collage':
      return FeatureInfo(
        icon: Icons.auto_stories_outlined,
        description:
            'Plan Instagram Stories and create simple photo layouts.',
        actions: [
          FeatureAction(
            title: 'Story planner',
            subtitle: 'Build a sequence of stories',
            message:
                'Create a sequence such as photo → thought → music → interaction.',
            icon: Icons.auto_stories,
          ),
          FeatureAction(
            title: 'Collage Creator',
            subtitle: 'Combine selected photos',
            message:
                'Choose a clean grid or editorial-style collage layout.',
            icon: Icons.collections,
          ),
          FeatureAction(
            title: 'Story idea',
            subtitle: 'Generate an idea',
            message:
                'GM can suggest story concepts based on your content plan.',
            icon: Icons.lightbulb_outline,
          ),
        ],
      );

    case 'Highlights Manager':
      return FeatureInfo(
        icon: Icons.star_outline,
        description:
            'Organize Instagram Highlight categories and cover ideas.',
        actions: [
          FeatureAction(
            title: 'Highlight categories',
            subtitle: 'Create organized categories',
            message:
                'Possible categories: Life, Travel, Work, Moments and Favorites.',
            icon: Icons.folder_outlined,
          ),
          FeatureAction(
            title: 'Cover style',
            subtitle: 'Keep covers consistent',
            message:
                'Recommended style: simple, clean and premium.',
            icon: Icons.image_outlined,
          ),
        ],
      );

    case 'Analytics':
      return FeatureInfo(
        icon: Icons.analytics_outlined,
        description:
            'Review content performance and learn what works best.',
        actions: [
          FeatureAction(
            title: 'Post performance',
            subtitle: 'Likes, comments and reach',
            message:
                'Connect Instagram insights in a later integration stage.',
            icon: Icons.bar_chart,
          ),
          FeatureAction(
            title: 'Best time',
            subtitle: 'Audience activity',
            message:
                'Personalized timing requires real Instagram audience data.',
            icon: Icons.schedule,
          ),
        ],
      );

    case 'Approval':
      return FeatureInfo(
        icon: Icons.verified_outlined,
        description:
            'Keep final control over every piece of content.',
        actions: [
          FeatureAction(
            title: 'Pending approval',
            subtitle: 'Review before publishing',
            message:
                'GM prepares content but waits for your approval.',
            icon: Icons.pending_actions,
          ),
          FeatureAction(
            title: 'Approve',
            subtitle: 'Give final permission',
            message:
                'Your approval is required before any future publishing integration.',
            icon: Icons.check_circle_outline,
          ),
        ],
      );

    default:
      return FeatureInfo(
        icon: Icons.auto_awesome,
        description:
            'GM Manager feature workspace.',
        actions: [
          FeatureAction(
            title: 'Open workspace',
            subtitle: 'Manage this feature',
            message:
                'This feature is included in the GM Manager interface.',
            icon: Icons.arrow_forward,
          ),
        ],
      );
  }
}

void showInfo(
  BuildContext context,
  String title,
  String message,
) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
