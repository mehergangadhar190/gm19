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
        scaffoldBackgroundColor: const Color(0xFF0D1117),
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
  int selectedIndex = 0;

  final List<Widget> pages = const [
    DashboardPage(),
    ContentPage(),
    PlannerPage(),
    ProfilePage(),
  ];

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: selectPage,
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

/* -------------------------------------------------------------------------- */
/* DASHBOARD                                                                  */
/* -------------------------------------------------------------------------- */

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('GM Manager'),
            actions: [
              IconButton(
                tooltip: 'Notifications',
                onPressed: () {
                  showInfo(context, 'Notifications',
                      'No new GM notifications right now.');
                },
                icon: const Icon(Icons.notifications_none),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _WelcomeCard(),
                const SizedBox(height: 16),
                const SectionTitle(
                  title: 'Today',
                  subtitle: 'Your personal social-media manager',
                ),
                const SizedBox(height: 10),
                const RecommendationCard(),
                const SizedBox(height: 20),
                const SectionTitle(
                  title: 'GM Features',
                  subtitle: 'Everything in one place',
                ),
                const SizedBox(height: 10),
                FeatureGrid(),
                const SizedBox(height: 20),
                const SectionTitle(
                  title: 'What GM can decide for you',
                  subtitle: 'Based on your personal style',
                ),
                const SizedBox(height: 10),
                const DecisionList(),
                const SizedBox(height: 20),
                const NaturalLookCard(),
              ]),
            ),
          ),
        ],
      ),
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
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 30,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Your personal Instagram & content manager.',
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

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Today\'s recommendation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Create a clean, natural post with a premium look. '
              'Keep the background authentic and avoid heavy editing.',
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                TagChip(label: 'Natural'),
                TagChip(label: 'Premium'),
                TagChip(label: 'Clean'),
                TagChip(label: 'Professional'),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: null,
              icon: Icon(Icons.auto_awesome),
              label: Text('AI recommendation'),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureGrid extends StatelessWidget {
  FeatureGrid({super.key});

  final List<_Feature> features = const [
    _Feature('Photo Studio', Icons.photo_camera_outlined),
    _Feature('AI Post Suggestions', Icons.auto_awesome),
    _Feature('Instagram Stories', Icons.auto_stories_outlined),
    _Feature('Reels', Icons.video_library_outlined),
    _Feature('Collage Creator', Icons.collections_outlined),
    _Feature('Highlights Manager', Icons.star_border),
    _Feature('Content Calendar', Icons.calendar_month_outlined),
    _Feature('Drafts', Icons.drafts_outlined),
    _Feature('Saved Ideas', Icons.lightbulb_outline),
    _Feature('Approval', Icons.check_circle_outline),
    _Feature('Analytics', Icons.analytics_outlined),
    _Feature('Personal Style', Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final feature = features[index];

        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FeaturePage(title: feature.title),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    feature.icon,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 9),
                  Text(
                    feature.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
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
}

class _Feature {
  final String title;
  final IconData icon;

  const _Feature(this.title, this.icon);
}

class DecisionList extends StatelessWidget {
  const DecisionList({super.key});

  final List<String> decisions = const [
    'Best photo',
    'Natural pose suggestion',
    'Aesthetic recommendation',
    'Music suggestion',
    'Caption writing',
    'Best posting time',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          for (int i = 0; i < decisions.length; i++)
            ListTile(
              leading: CircleAvatar(
                radius: 18,
                child: Text('${i + 1}'),
              ),
              title: Text(decisions[i]),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showInfo(
                  context,
                  decisions[i],
                  'GM will prepare this recommendation for your content.',
                );
              },
            ),
        ],
      ),
    );
  }
}

class NaturalLookCard extends StatelessWidget {
  const NaturalLookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.verified_user_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GM natural-look rule',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your face identity and body proportions stay natural. '
                    'GM does not intentionally change face or body structure.',
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

/* -------------------------------------------------------------------------- */
/* CONTENT                                                                    */
/* -------------------------------------------------------------------------- */

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  final List<_ContentItem> items = const [
    _ContentItem('Posts', Icons.photo_library_outlined),
    _ContentItem('Instagram Stories', Icons.auto_stories_outlined),
    _ContentItem('Reels', Icons.video_library_outlined),
    _ContentItem('Collage Creator', Icons.collections_outlined),
    _ContentItem('Highlights Manager', Icons.star_border),
    _ContentItem('Content Calendar', Icons.calendar_month_outlined),
    _ContentItem('Drafts', Icons.drafts_outlined),
    _ContentItem('Saved Ideas', Icons.lightbulb_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Content Manager'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  'Choose what you want GM to manage.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          item.icon,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: const Text('Open manager'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  FeaturePage(title: item.title),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentItem {
  final String title;
  final IconData icon;

  const _ContentItem(this.title, this.icon);
}

/* -------------------------------------------------------------------------- */
/* PLANNER                                                                    */
/* -------------------------------------------------------------------------- */

class PlannerPage extends StatelessWidget {
  const PlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Planner'),
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
                          'Content calendar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Plan posts, Stories and Reels before publishing.',
                        ),
                        const SizedBox(height: 18),
                        FilledButton.icon(
                          onPressed: () {
                            showInfo(
                              context,
                              'New content',
                              'Content planning is ready. '
                                  'Add your post, Story or Reel here.',
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Plan content'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const _PlanTile(
                  day: 'Today',
                  type: 'Post',
                  title: 'Premium natural portrait',
                ),
                const _PlanTile(
                  day: 'Tomorrow',
                  type: 'Story',
                  title: 'Behind the scenes',
                ),
                const _PlanTile(
                  day: 'Saturday',
                  type: 'Reel',
                  title: 'Lifestyle Reel',
                ),
                const _PlanTile(
                  day: 'Sunday',
                  type: 'Story',
                  title: 'Weekly recap',
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  final String day;
  final String type;
  final String title;

  const _PlanTile({
    required this.day,
    required this.type,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            type == 'Post'
                ? Icons.photo_outlined
                : type == 'Reel'
                    ? Icons.video_library_outlined
                    : Icons.auto_stories_outlined,
          ),
        ),
        title: Text(title),
        subtitle: Text('$day • $type'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          showInfo(context, title, '$type planned for $day.');
        },
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* PROFILE                                                                    */
/* -------------------------------------------------------------------------- */

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool naturalEditing = true;
  bool premiumStyle = true;
  bool approvalRequired = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Personal Profile'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 42,
                          child: Icon(
                            Icons.person,
                            size: 44,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'GM Personal Style',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Natural • Premium • Simple • Clean • Professional',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Natural editing'),
                        subtitle: const Text(
                          'Protect natural face and body appearance',
                        ),
                        value: naturalEditing,
                        onChanged: (value) {
                          setState(() {
                            naturalEditing = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Premium style'),
                        subtitle: const Text(
                          'Keep visuals clean and professional',
                        ),
                        value: premiumStyle,
                        onChanged: (value) {
                          setState(() {
                            premiumStyle = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Approval required'),
                        subtitle: const Text(
                          'GM never publishes without your approval',
                        ),
                        value: approvalRequired,
                        onChanged: (value) {
                          setState(() {
                            approvalRequired = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.face_outlined),
                        title: const Text('Face identity reference'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => showInfo(
                          context,
                          'Face identity',
                          'This area is reserved for your identity reference.',
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.accessibility_new_outlined),
                        title: const Text('Body proportions reference'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => showInfo(
                          context,
                          'Body proportions',
                          'This area is reserved for your natural proportions reference.',
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.checkroom_outlined),
                        title: const Text('Clothing preferences'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => showInfo(
                          context,
                          'Clothing',
                          'Add your preferred clothing and styling direction here.',
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.chat_bubble_outline),
                        title: const Text('Communication style'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => showInfo(
                          context,
                          'Communication style',
                          'GM can use your preferred communication style.',
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* FEATURE PAGE                                                               */
/* -------------------------------------------------------------------------- */

class FeaturePage extends StatelessWidget {
  final String title;

  const FeaturePage({
    super.key,
    required this.title,
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    data.icon,
                    size: 52,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.description,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          for (final action in data.actions)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: ListTile(
                  leading: Icon(action.icon),
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

class _FeatureData {
  final IconData icon;
  final String description;
  final List<_FeatureAction> actions;

  const _FeatureData({
    required this.icon,
    required this.description,
    required this.actions,
  });
}

class _FeatureAction {
  final String title;
  final String subtitle;
  final String message;
  final IconData icon;

  const _FeatureAction({
    required this.title,
    required this.subtitle,
    required this.message,
    required this.icon,
  });
}

_FeatureData featureData(String title) {
  switch (title) {
    case 'Photo Studio':
      return const _FeatureData(
        icon: Icons.photo_camera_outlined,
        description:
            'Prepare photos with a natural, premium and professional direction.',
        actions: [
          _FeatureAction(
            title: 'Choose photos',
            subtitle: 'Prepare 2–3 photos for review',
            message:
                'Select 2–3 candidate photos on your device, then use GM to compare them.',
            icon: Icons.photo_library_outlined,
          ),
          _FeatureAction(
            title: 'Editing direction',
            subtitle: 'Natural correction only',
            message:
                'Recommended direction: exposure, contrast, crop and subtle color correction.',
            icon: Icons.tune,
          ),
          _FeatureAction(
            title: 'Pose direction',
            subtitle: 'Natural pose suggestions',
            message:
                'GM can suggest natural pose changes without changing your face or body structure.',
            icon: Icons.accessibility_new_outlined,
          ),
        ],
      );

    case 'AI Post Suggestions':
      return const _FeatureData(
        icon: Icons.auto_awesome,
        description:
            'Compare your content and prepare a complete posting recommendation.',
        actions: [
          _FeatureAction(
            title: 'Best photo',
            subtitle: 'Choose the strongest candidate',
            message:
                'GM recommendation: select the photo with the strongest composition, natural expression and clean background.',
            icon: Icons.star_outline,
          ),
          _FeatureAction(
            title: 'Caption',
            subtitle: 'Natural personal caption',
            message:
                'Suggested caption style: short, natural and confident. Avoid overused or artificial wording.',
            icon: Icons.edit_outlined,
          ),
          _FeatureAction(
            title: 'Music',
            subtitle: 'Match music to the visual mood',
            message:
                'Choose music that matches the mood of the photo and your audience.',
            icon: Icons.music_note_outlined,
          ),
          _FeatureAction(
            title: 'Posting time',
            subtitle: 'Plan the best time',
            message:
                'Use your audience analytics to determine the strongest posting window.',
            icon: Icons.schedule,
          ),
        ],
      );

    case 'Instagram Stories':
      return const _FeatureData(
        icon: Icons.auto_stories_outlined,
        description:
            'Plan clean and natural Instagram Stories.',
        actions: [
          _FeatureAction(
            title: 'Story sequence',
            subtitle: 'Plan multiple frames',
            message:
                'Example sequence: main photo → short context → music → interaction sticker.',
            icon: Icons.view_carousel_outlined,
          ),
          _FeatureAction(
            title: 'Story idea',
            subtitle: 'Create a natural story concept',
            message:
                'Use behind-the-scenes, daily moments, location details or a simple personal update.',
            icon: Icons.lightbulb_outline,
          ),
          _FeatureAction(
            title: 'Story approval',
            subtitle: 'Review before publishing',
            message:
                'GM keeps publishing under your approval.',
            icon: Icons.check_circle_outline,
          ),
        ],
      );

    case 'Reels':
      return const _FeatureData(
        icon: Icons.video_library_outlined,
        description:
            'Plan short-form video content and Reel concepts.',
        actions: [
          _FeatureAction(
            title: 'Reel concept',
            subtitle: 'Create a content idea',
            message:
                'Start with a strong opening shot, natural movement and a simple ending.',
            icon: Icons.movie_creation_outlined,
          ),
          _FeatureAction(
            title: 'Audio direction',
            subtitle: 'Match audio to mood',
            message:
                'Choose audio that fits the visual style and current audience interest.',
            icon: Icons.music_note_outlined,
          ),
          _FeatureAction(
            title: 'Caption',
            subtitle: 'Write Reel copy',
            message:
                'Keep the caption short and aligned with your personal communication style.',
            icon: Icons.edit_outlined,
          ),
        ],
      );

    case 'Collage Creator':
      return const _FeatureData(
        icon: Icons.collections_outlined,
        description:
            'Plan simple premium collages without making the result look artificial.',
        actions: [
          _FeatureAction(
            title: '2-photo layout',
            subtitle: 'Clean side-by-side concept',
            message:
                'Use two photos with similar lighting and visual balance.',
            icon: Icons.view_column_outlined,
          ),
          _FeatureAction(
            title: '3-photo layout',
            subtitle: 'Main photo + supporting images',
            message:
                'Use one main image and two supporting images for a clean visual hierarchy.',
            icon: Icons.dashboard_outlined,
          ),
          _FeatureAction(
            title: 'Minimal style',
            subtitle: 'Keep the design clean',
            message:
                'Avoid excessive borders, stickers and effects.',
            icon: Icons.crop_square,
          ),
        ],
      );

    case 'Highlights Manager':
      return const _FeatureData(
        icon: Icons.star_border,
        description:
            'Organize your Instagram Highlights into a clean profile structure.',
        actions: [
          _FeatureAction(
            title: 'Suggested categories',
            subtitle: 'Build your Highlight structure',
            message:
                'Possible categories: Life, Travel, Work, Style, Moments and Favorites.',
            icon: Icons.folder_outlined,
          ),
          _FeatureAction(
            title: 'Cover direction',
            subtitle: 'Keep covers consistent',
            message:
                'Use simple, clean covers with a consistent visual language.',
            icon: Icons.image_outlined,
          ),
          _FeatureAction(
            title: 'Review highlights',
            subtitle: 'Keep your profile organized',
            message:
                'Remove outdated Stories and keep the strongest moments visible.',
            icon: Icons.checklist,
          ),
        ],
      );

    case 'Content Calendar':
      return const _FeatureData(
        icon: Icons.calendar_month_outlined,
        description:
            'Organize posts, Stories and Reels before publishing.',
        actions: [
          _FeatureAction(
            title: 'Weekly plan',
            subtitle: 'Build your week',
            message:
                'Plan a balanced mix of Posts, Stories and Reels instead of posting randomly.',
            icon: Icons.date_range_outlined,
          ),
          _FeatureAction(
            title: 'Posting window',
            subtitle: 'Choose a time',
            message:
                'Use audience performance data to refine the posting window.',
            icon: Icons.schedule,
          ),
        ],
      );

    case 'Drafts':
      return const _FeatureData(
        icon: Icons.drafts_outlined,
        description:
            'Keep unfinished content ready for later review.',
        actions: [
          _FeatureAction(
            title: 'New draft',
            subtitle: 'Save an idea',
            message:
                'Draft saved conceptually. Connect persistent storage in a later backend version.',
            icon: Icons.add,
          ),
          _FeatureAction(
            title: 'Approval queue',
            subtitle: 'Review before publishing',
            message:
                'All publishing decisions remain under your control.',
            icon: Icons.check_circle_outline,
          ),
        ],
      );

    case 'Saved Ideas':
      return const _FeatureData(
        icon: Icons.lightbulb_outline,
        description:
            'Keep future content ideas in one place.',
        actions: [
          _FeatureAction(
            title: 'Photo idea',
            subtitle: 'Save a photography concept',
            message:
                'Example: natural outdoor portrait with soft evening light.',
            icon: Icons.camera_alt_outlined,
          ),
          _FeatureAction(
            title: 'Story idea',
            subtitle: 'Save a Story concept',
            message:
                'Example: a simple behind-the-scenes moment with a short caption.',
            icon: Icons.auto_stories_outlined,
          ),
        ],
      );

    case 'Approval':
      return const _FeatureData(
        icon: Icons.check_circle_outline,
        description:
            'GM prepares recommendations, but you remain the final decision-maker.',
        actions: [
          _FeatureAction(
            title: 'Review content',
            subtitle: 'Check before publishing',
            message:
                'Review the selected photo, caption, music, timing and aesthetic before publishing.',
            icon: Icons.rate_review_outlined,
          ),
          _FeatureAction(
            title: 'Approve',
            subtitle: 'Give final permission',
            message:
                'Approval is intentionally kept as a user-controlled action.',
            icon: Icons.check,
          ),
          _FeatureAction(
            title: 'Reject',
            subtitle: 'Send back for changes',
            message:
                'Reject the recommendation and revise it before publishing.',
            icon: Icons.close,
          ),
        ],
      );

    case 'Analytics':
      return const _FeatureData(
        icon: Icons.analytics_outlined,
        description:
            'Track content performance and use the results to improve future recommendations.',
        actions: [
          _FeatureAction(
            title: 'Post performance',
            subtitle: 'Review results',
            message:
                'Track reach, engagement, saves, shares and profile activity once analytics data is connected.',
            icon: Icons.bar_chart_outlined,
          ),
          _FeatureAction(
            title: 'Audience timing',
            subtitle: 'Find stronger posting windows',
            message:
                'Use audience activity data to identify stronger posting times.',
            icon: Icons.schedule,
          ),
          _FeatureAction(
            title: 'Content patterns',
            subtitle: 'Learn what works',
            message:
                'Compare different formats and topics to improve your content strategy.',
            icon: Icons.insights_outlined,
          ),
        ],
      );

    case 'Personal Style':
      return const _FeatureData(
        icon: Icons.person_outline,
        description:
            'Your personal GM style profile.',
        actions: [
          _FeatureAction(
            title: 'Natural',
            subtitle: 'Preserve identity',
            message:
                'GM should keep your appearance natural and recognizable.',
            icon: Icons.face_outlined,
          ),
          _FeatureAction(
            title: 'Premium',
            subtitle: 'Professional visual direction',
            message:
                'Prefer polished but realistic results.',
            icon: Icons.workspace_premium_outlined,
          ),
          _FeatureAction(
            title: 'Simple & clean',
            subtitle: 'Avoid over-editing',
            message:
                'Keep edits subtle and backgrounds authentic.',
            icon: Icons.cleaning_services_outlined,
          ),
        ],
      );

    default:
      return const _FeatureData(
        icon: Icons.auto_awesome,
        description:
            'GM Manager feature.',
        actions: [
          _FeatureAction(
            title: 'Open',
            subtitle: 'Feature ready',
            message:
                'This GM Manager feature is ready for the next integration stage.',
            icon: Icons.arrow_forward,
          ),
        ],
      );
  }
}

/* -------------------------------------------------------------------------- */
/* SHARED WIDGETS                                                             */
/* -------------------------------------------------------------------------- */

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(subtitle),
      ],
    );
  }
}

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(
        Icons.check,
        size: 16,
      ),
      label: Text(label),
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
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
