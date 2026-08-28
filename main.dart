import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        cardTheme: const CardThemeData(margin: EdgeInsets.zero),
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
  int index = 0;

  final pages = const [
    DashboardPage(),
    ContentPage(),
    PlannerPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Content'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Planner'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('GM Manager')),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const WelcomeCard(),
                const SizedBox(height: 16),
                const SectionTitle('Today\'s recommendation', 'Personal social-media strategy'),
                const SizedBox(height: 10),
                const RecommendationCard(),
                const SizedBox(height: 20),
                const SectionTitle('GM Features', 'Everything in one place'),
                const SizedBox(height: 10),
                const FeatureGrid(),
                const SizedBox(height: 20),
                const SectionTitle('What GM can decide', 'Using your personal style'),
                const SizedBox(height: 10),
                const DecisionCard(),
                const SizedBox(height: 16),
                const NaturalRuleCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(Icons.auto_awesome, color: scheme.onPrimaryContainer, size: 30),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to GM', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('Your personal Instagram & social-media manager'),
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
            const Row(
              children: [
                Icon(Icons.lightbulb_outline),
                SizedBox(width: 8),
                Text('Today\'s plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Use a natural photo, clean composition and subtle professional editing. Keep the real background and your appearance authentic.'),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                Chip(label: Text('Natural')),
                Chip(label: Text('Premium')),
                Chip(label: Text('Simple')),
                Chip(label: Text('Clean')),
                Chip(label: Text('Professional')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionTitle(this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 3),
        Text(subtitle),
      ],
    );
  }
}

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  static const features = <FeatureItem>[
    FeatureItem('Photo Studio', Icons.photo_camera_outlined),
    FeatureItem('AI Post Suggestions', Icons.auto_awesome),
    FeatureItem('Instagram Stories', Icons.auto_stories_outlined),
    FeatureItem('Reels', Icons.video_library_outlined),
    FeatureItem('Collage Creator', Icons.collections_outlined),
    FeatureItem('Highlights Manager', Icons.star_border),
    FeatureItem('Content Calendar', Icons.calendar_month_outlined),
    FeatureItem('Approval', Icons.check_circle_outline),
    FeatureItem('Analytics', Icons.analytics_outlined),
    FeatureItem('Drafts', Icons.drafts_outlined),
    FeatureItem('Saved Ideas', Icons.lightbulb_outline),
    FeatureItem('Personal Style', Icons.person_outline),
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
      itemBuilder: (context, i) {
        final item = features[i];
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => openFeature(context, item.name),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: 29, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 9),
                Text(item.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FeatureItem {
  final String name;
  final IconData icon;
  const FeatureItem(this.name, this.icon);
}

class DecisionCard extends StatelessWidget {
  const DecisionCard({super.key});

  static const decisions = [
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
          for (var i = 0; i < decisions.length; i++)
            ListTile(
              leading: CircleAvatar(child: Text('${i + 1}')),
              title: Text(decisions[i]),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showInfo(context, decisions[i], 'This workspace is ready for the AI/backend connection. Your final approval remains required.'),
            ),
        ],
      ),
    );
  }
}

class NaturalRuleCard extends StatelessWidget {
  const NaturalRuleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.verified_user_outlined),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('GM natural-look rule', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('Preserve facial identity and natural body proportions. No intentional face or body-structure changes.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  static const items = <FeatureItem>[
    FeatureItem('Photo Studio', Icons.photo_camera_outlined),
    FeatureItem('AI Post Suggestions', Icons.auto_awesome),
    FeatureItem('Instagram Stories', Icons.auto_stories_outlined),
    FeatureItem('Reels', Icons.video_library_outlined),
    FeatureItem('Collage Creator', Icons.collections_outlined),
    FeatureItem('Highlights Manager', Icons.star_border),
    FeatureItem('Drafts', Icons.drafts_outlined),
    FeatureItem('Saved Ideas', Icons.lightbulb_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('Content Manager')),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('Choose a GM workspace.'),
                const SizedBox(height: 14),
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        leading: Icon(item.icon),
                        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => openFeature(context, item.name),
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

class PlannerPage extends StatelessWidget {
  const PlannerPage({super.key});

  static const plan = [
    ('Today', 'Post', 'Natural portrait'),
    ('Tomorrow', 'Story', 'Behind the scenes'),
    ('Saturday', 'Reel', 'Lifestyle Reel'),
    ('Sunday', 'Story', 'Weekly recap'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('Planner')),
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
                        const Text('Content calendar', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text('Plan Posts, Stories and Reels before publishing.'),
                        const SizedBox(height: 14),
                        FilledButton.icon(
                          onPressed: () => showInfo(context, 'New content', 'Planner workspace is ready.'),
                          icon: const Icon(Icons.add),
                          label: const Text('Plan content'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                for (final item in plan)
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.event_outlined)),
                      title: Text(item.$3),
                      subtitle: Text('${item.$1} • ${item.$2}'),
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool natural = true;
  bool approval = true;
  bool premium = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('Personal Profile')),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 42, child: Icon(Icons.person, size: 44)),
                        SizedBox(height: 12),
                        Text('GM Personal Style', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('Natural • Premium • Simple • Clean • Professional', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(title: const Text('Natural editing'), subtitle: const Text('Protect natural appearance'), value: natural, onChanged: (v) => setState(() => natural = v)),
                      SwitchListTile(title: const Text('Approval required'), subtitle: const Text('Never publish without approval'), value: approval, onChanged: (v) => setState(() => approval = v)),
                      SwitchListTile(title: const Text('Premium style'), subtitle: const Text('Clean and professional direction'), value: premium, onChanged: (v) => setState(() => premium = v)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Card(
                  child: Column(
                    children: [
                      ListTile(leading: Icon(Icons.face_outlined), title: Text('Face identity reference')),
                      ListTile(leading: Icon(Icons.accessibility_new_outlined), title: Text('Body proportions reference')),
                      ListTile(leading: Icon(Icons.checkroom_outlined), title: Text('Clothing preferences')),
                      ListTile(leading: Icon(Icons.chat_bubble_outline), title: Text('Communication style')),
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

class FeaturePage extends StatefulWidget {
  final String title;
  const FeaturePage({super.key, required this.title});

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  final picker = ImagePicker();
  final photos = <XFile>[];

  Future<void> addPhoto() async {
    final file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 95);
    if (file != null) {
      setState(() => photos.add(file));
    }
  }

  Future<void> addMultiplePhotos() async {
    final files = await picker.pickMultiImage(imageQuality: 95);
    if (files.isNotEmpty) {
      setState(() => photos.addAll(files.take(6)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = featureData(widget.title);
    final photoWorkspace = <String>{'Photo Studio', 'AI Post Suggestions', 'Collage Creator'}.contains(widget.title);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(data.icon, size: 54, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 12),
                  Text(widget.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(data.description, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          if (photoWorkspace) ...[
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Photo workspace', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text('${photos.length} photo${photos.length == 1 ? '' : 's'} selected'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(onPressed: addPhoto, icon: const Icon(Icons.add_photo_alternate_outlined), label: const Text('Add photo')),
                        OutlinedButton.icon(onPressed: addMultiplePhotos, icon: const Icon(Icons.collections_outlined), label: const Text('Add multiple')),
                      ],
                    ),
                    if (photos.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 170,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: photos.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 10),
                          itemBuilder: (context, i) => Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(File(photos[i].path), width: 150, height: 170, fit: BoxFit.cover),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: IconButton.filledTonal(
                                  onPressed: () => setState(() => photos.removeAt(i)),
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 10),
          for (final action in data.actions)
            Card(
              child: ListTile(
                leading: Icon(action.icon),
                title: Text(action.title),
                subtitle: Text(action.subtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => showInfo(context, action.title, action.message),
              ),
            ),
        ],
      ),
    );
  }
}

class FeatureData {
  final IconData icon;
  final String description;
  final List<FeatureAction> actions;
  const FeatureData(this.icon, this.description, this.actions);
}

class FeatureAction {
  final String title;
  final String subtitle;
  final String message;
  final IconData icon;
  const FeatureAction(this.title, this.subtitle, this.message, this.icon);
}

FeatureData featureData(String title) {
  switch (title) {
    case 'Photo Studio':
      return const FeatureData(Icons.photo_camera_outlined, 'Choose photos and prepare a natural professional direction.', [
        FeatureAction('Best photo', 'Select the strongest candidate', 'Compare composition, expression, lighting and authenticity.', Icons.star_outline),
        FeatureAction('Natural pose', 'Keep the person authentic', 'Suggest pose adjustments without changing identity or body structure.', Icons.accessibility_new_outlined),
        FeatureAction('Editing direction', 'Subtle professional correction', 'Use exposure, crop, contrast and color correction without over-editing.', Icons.tune),
      ]);
    case 'AI Post Suggestions':
      return const FeatureData(Icons.auto_awesome, 'Build a complete post recommendation from selected photos.', [
        FeatureAction('Best photo', 'Choose strongest image', 'Use composition, expression, lighting and authenticity.', Icons.star_outline),
        FeatureAction('Caption', 'Personal writing direction', 'Short, natural and confident caption.', Icons.edit_outlined),
        FeatureAction('Music', 'Match visual mood', 'Choose music that fits the intended mood.', Icons.music_note_outlined),
        FeatureAction('Best posting time', 'Use audience data', 'Connected analytics can identify stronger windows.', Icons.schedule),
      ]);
    case 'Instagram Stories':
      return const FeatureData(Icons.auto_stories_outlined, 'Plan clean and natural Instagram Stories.', [
        FeatureAction('Story sequence', 'Plan multiple frames', 'Main photo → context → music → optional interaction.', Icons.view_carousel_outlined),
        FeatureAction('Story idea', 'Create a natural concept', 'Behind-the-scenes, daily moment or personal update.', Icons.lightbulb_outline),
        FeatureAction('Approval', 'Review before publishing', 'Final publishing decision stays with you.', Icons.check_circle_outline),
      ]);
    case 'Reels':
      return const FeatureData(Icons.video_library_outlined, 'Plan short-form video content.', [
        FeatureAction('Reel concept', 'Build the idea', 'Strong opening → natural movement → simple ending.', Icons.movie_creation_outlined),
        FeatureAction('Audio', 'Match audio to mood', 'Select appropriate audio.', Icons.music_note_outlined),
        FeatureAction('Caption', 'Write Reel copy', 'Keep it concise and personal.', Icons.edit_outlined),
      ]);
    case 'Collage Creator':
      return const FeatureData(Icons.collections_outlined, 'Create simple premium layouts from selected photos.', [
        FeatureAction('2-photo layout', 'Clean side-by-side', 'Use balanced compatible photos.', Icons.view_column_outlined),
        FeatureAction('3-photo layout', 'Main + supporting images', 'Create clear hierarchy.', Icons.dashboard_outlined),
        FeatureAction('Minimal style', 'Avoid excessive effects', 'Keep decoration restrained.', Icons.crop_square),
      ]);
    case 'Highlights Manager':
      return const FeatureData(Icons.star_border, 'Organize Instagram Highlights.', [
        FeatureAction('Categories', 'Suggested structure', 'Life, Travel, Work, Style, Moments and Favorites.', Icons.folder_outlined),
        FeatureAction('Covers', 'Keep consistent', 'Use simple consistent covers.', Icons.image_outlined),
      ]);
    case 'Content Calendar':
      return const FeatureData(Icons.calendar_month_outlined, 'Organize Posts, Stories and Reels.', [
        FeatureAction('Weekly plan', 'Balance formats', 'Plan a balanced mix.', Icons.date_range_outlined),
        FeatureAction('Posting window', 'Use performance data', 'Connected analytics can identify stronger windows.', Icons.schedule),
      ]);
    case 'Approval':
      return const FeatureData(Icons.check_circle_outline, 'GM prepares recommendations; you decide.', [
        FeatureAction('Review', 'Check everything', 'Review photo, caption, music, timing and aesthetic.', Icons.rate_review_outlined),
        FeatureAction('Approve', 'Give final permission', 'Publishing stays user-controlled.', Icons.check),
        FeatureAction('Reject', 'Send back', 'Revise before publishing.', Icons.close),
      ]);
    case 'Analytics':
      return const FeatureData(Icons.analytics_outlined, 'Track performance after analytics integration.', [
        FeatureAction('Post performance', 'Review results', 'Reach, engagement, saves and shares.', Icons.bar_chart_outlined),
        FeatureAction('Audience timing', 'Find stronger windows', 'Use audience activity.', Icons.schedule),
        FeatureAction('Content patterns', 'Learn what works', 'Compare formats and topics.', Icons.insights_outlined),
      ]);
    case 'Drafts':
      return const FeatureData(Icons.drafts_outlined, 'Keep unfinished content ready.', [
        FeatureAction('New draft', 'Save a concept', 'Prepare content for later approval.', Icons.add),
        FeatureAction('Approval queue', 'Review before publishing', 'Keep final control with you.', Icons.check_circle_outline),
      ]);
    case 'Saved Ideas':
      return const FeatureData(Icons.lightbulb_outline, 'Keep future content concepts.', [
        FeatureAction('Photo idea', 'Save photography concept', 'Example: natural outdoor portrait.', Icons.camera_alt_outlined),
        FeatureAction('Story idea', 'Save Story concept', 'Example: simple behind-the-scenes moment.', Icons.auto_stories_outlined),
      ]);
    default:
      return const FeatureData(Icons.person_outline, 'Your personal GM style profile.', [
        FeatureAction('Natural', 'Preserve identity', 'Keep appearance natural and recognizable.', Icons.face_outlined),
        FeatureAction('Premium', 'Professional direction', 'Prefer polished but realistic results.', Icons.workspace_premium_outlined),
        FeatureAction('Simple & clean', 'Avoid over-editing', 'Keep edits subtle.', Icons.cleaning_services_outlined),
      ]);
  }
}

void openFeature(BuildContext context, String title) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => FeaturePage(title: title)));
}

void showInfo(BuildContext context, String title, String message) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('OK')),
      ],
    ),
  );
}
