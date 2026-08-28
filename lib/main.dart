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
      title: 'GM Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF0B0F0D),
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
  int currentIndex = 0;

  final List<Widget> pages = const [
    DashboardPage(),
    ContentPage(),
    PlannerPage(),
    ApprovalPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
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
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'Approval',
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

/* ============================================================
   DASHBOARD
   ============================================================ */

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('GM Manager'),
            subtitle: Text('Your personal social media manager'),
            floating: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const _WelcomeCard(),
                  const SizedBox(height: 16),
                  _SectionTitle(
                    title: 'Today',
                    action: 'View all',
                    onTap: () {
                      _showMessage(context, 'Today\'s plan opened.');
                    },
                  ),
                  const SizedBox(height: 10),
                  _InfoCard(
                    icon: Icons.auto_awesome,
                    title: 'Today\'s recommendation',
                    text:
                        'Choose your strongest photo, keep the edit natural, and post when your audience is most active.',
                  ),
                  const SizedBox(height: 16),
                  _SectionTitle(
                    title: 'Quick actions',
                    action: 'All',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ContentPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.45,
                    children: [
                      _ActionCard(
                        icon: Icons.add_a_photo_outlined,
                        title: 'Create Post',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PostWorkspacePage(),
                            ),
                          );
                        },
                      ),
                      _ActionCard(
                        icon: Icons.auto_awesome,
                        title: 'AI Suggestions',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AISuggestionsPage(),
                            ),
                          );
                        },
                      ),
                      _ActionCard(
                        icon: Icons.camera_alt_outlined,
                        title: 'Stories',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StoriesPage(),
                            ),
                          );
                        },
                      ),
                      _ActionCard(
                        icon: Icons.collections_outlined,
                        title: 'Collage',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CollagePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _SectionTitle(
                    title: 'GM can help with',
                    action: '',
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  _FeatureList(
                    items: const [
                      (
                        Icons.photo_outlined,
                        'Best photo',
                        'Choose the strongest image for your post.'
                      ),
                      (
                        Icons.accessibility_new,
                        'Natural pose',
                        'Suggest a natural pose without changing your identity.'
                      ),
                      (
                        Icons.palette_outlined,
                        'Aesthetic',
                        'Recommend a clean and premium visual direction.'
                      ),
                      (
                        Icons.music_note_outlined,
                        'Music',
                        'Suggest music that matches the content mood.'
                      ),
                      (
                        Icons.edit_outlined,
                        'Caption',
                        'Create captions matching your personal style.'
                      ),
                      (
                        Icons.schedule,
                        'Best posting time',
                        'Plan when your content should go live.'
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const _SafetyCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   CONTENT
   ============================================================ */

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      (
        'Posts',
        Icons.photo_library_outlined,
        const PostWorkspacePage(),
      ),
      (
        'Instagram Stories',
        Icons.auto_stories_outlined,
        const StoriesPage(),
      ),
      (
        'Reels',
        Icons.video_library_outlined,
        const ReelsPage(),
      ),
      (
        'Collage Creator',
        Icons.collections_outlined,
        const CollagePage(),
      ),
      (
        'Highlights Manager',
        Icons.star_outline,
        const HighlightsPage(),
      ),
      (
        'Content Calendar',
        Icons.calendar_month_outlined,
        const PlannerPage(),
      ),
      (
        'Drafts',
        Icons.drafts_outlined,
        const DraftsPage(),
      ),
      (
        'Saved Ideas',
        Icons.lightbulb_outline,
        const IdeasPage(),
      ),
    ];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Content Manager'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = features[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      child: ListTile(
                        minVerticalPadding: 14,
                        leading: CircleAvatar(
                          child: Icon(item.$2),
                        ),
                        title: Text(
                          item.$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text(
                          'Open workspace',
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => item.$3,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                childCount: features.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   POST WORKSPACE
   ============================================================ */

class PostWorkspacePage extends StatefulWidget {
  const PostWorkspacePage({super.key});

  @override
  State<PostWorkspacePage> createState() => _PostWorkspacePageState();
}

class _PostWorkspacePageState extends State<PostWorkspacePage> {
  final ImagePicker picker = ImagePicker();

  List<XFile> photos = [];

  Future<void> pickPhotos() async {
    try {
      final result = await picker.pickMultiImage(
        imageQuality: 95,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        photos = result;
      });

      if (result.isNotEmpty) {
        _showMessage(
          context,
          '${result.length} photo${result.length == 1 ? '' : 's'} added.',
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      _showMessage(
        context,
        'Could not open your photo gallery.',
      );
    }
  }

  Future<void> takePhoto() async {
    try {
      final photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 95,
      );

      if (!mounted || photo == null) {
        return;
      }

      setState(() {
        photos = [...photos, photo];
      });

      _showMessage(context, 'Photo added.');
    } catch (e) {
      if (!mounted) {
        return;
      }

      _showMessage(
        context,
        'Could not open the camera.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Workspace'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _WorkspaceHeader(
            icon: Icons.photo_library_outlined,
            title: 'Create a Post',
            subtitle:
                'Add 2–3 photos and GM will help you decide what works best.',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: pickPhotos,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Add Photos'),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filledTonal(
                onPressed: takePhoto,
                icon: const Icon(Icons.camera_alt),
                tooltip: 'Camera',
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (photos.isEmpty)
            const _EmptyWorkspace(
              icon: Icons.add_photo_alternate_outlined,
              title: 'No photos yet',
              text: 'Tap Add Photos to choose photos from your phone.',
            )
          else ...[
            Text(
              '${photos.length} selected',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: photos.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.file(
                    File(photos[index].path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AISuggestionsPage(
                      photoCount: photos.length,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Ask GM for Suggestions'),
            ),
          ],
        ],
      ),
    );
  }
}

/* ============================================================
   AI SUGGESTIONS
   ============================================================ */

class AISuggestionsPage extends StatelessWidget {
  final int photoCount;

  const AISuggestionsPage({
    super.key,
    this.photoCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Post Suggestions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _WorkspaceHeader(
            icon: Icons.auto_awesome,
            title: 'GM Recommendation',
            subtitle: photoCount > 0
                ? '$photoCount photo${photoCount == 1 ? '' : 's'} available for review.'
                : 'Add photos in the Post Workspace to get a photo-specific recommendation.',
          ),
          const SizedBox(height: 18),
          _SuggestionCard(
            number: '01',
            title: 'Best photo',
            result: photoCount > 0
                ? 'Start with the clearest, most natural-looking photo.'
                : 'Choose a photo with clear expression, good lighting and natural composition.',
          ),
          _SuggestionCard(
            number: '02',
            title: 'Natural pose',
            result:
                'Keep your shoulders relaxed, use a slight body angle and avoid an overly forced pose.',
          ),
          _SuggestionCard(
            number: '03',
            title: 'Aesthetic',
            result:
                'Natural + premium + clean. Keep skin, face, body proportions and identity unchanged.',
          ),
          _SuggestionCard(
            number: '04',
            title: 'Caption',
            result:
                'Keep it short, confident and natural rather than sounding like an advertisement.',
          ),
          _SuggestionCard(
            number: '05',
            title: 'Music direction',
            result:
                'Choose a currently relevant track that matches the mood of the final photo.',
          ),
          _SuggestionCard(
            number: '06',
            title: 'Posting time',
            result:
                'Use your Instagram audience insights later to choose the strongest time for your followers.',
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              _showMessage(
                context,
                'Suggestion saved to Drafts.',
              );
            },
            icon: const Icon(Icons.bookmark_outline),
            label: const Text('Save Recommendation'),
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   STORIES
   ============================================================ */

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Stories'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _WorkspaceHeader(
            icon: Icons.auto_stories_outlined,
            title: 'Stories',
            subtitle: 'Plan natural, clean and consistent stories.',
          ),
          const SizedBox(height: 18),
          _FeatureTile(
            icon: Icons.add_a_photo_outlined,
            title: 'Create Story',
            subtitle: 'Add photos for a story sequence.',
            onTap: () {
              _showMessage(
                context,
                'Story workspace opened.',
              );
            },
          ),
          _FeatureTile(
            icon: Icons.text_fields,
            title: 'Story Text',
            subtitle: 'Create short text that matches your style.',
            onTap: () {
              _showMessage(
                context,
                'Story text workspace opened.',
              );
            },
          ),
          _FeatureTile(
            icon: Icons.music_note,
            title: 'Story Music',
            subtitle: 'Choose music that fits the mood.',
            onTap: () {
              _showMessage(
                context,
                'Music suggestions opened.',
              );
            },
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   REELS
   ============================================================ */

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _WorkspaceHeader(
            icon: Icons.video_library_outlined,
            title: 'Reels Manager',
            subtitle:
                'Plan ideas, hooks, captions and music directions.',
          ),
          const SizedBox(height: 18),
          _FeatureTile(
            icon: Icons.lightbulb_outline,
            title: 'Reel Idea',
            subtitle: 'Generate a content concept.',
            onTap: () {
              _showMessage(
                context,
                'Reel idea created.',
              );
            },
          ),
          _FeatureTile(
            icon: Icons.play_circle_outline,
            title: 'Reel Structure',
            subtitle: 'Hook → content → ending.',
            onTap: () {
              _showMessage(
                context,
                'Reel structure opened.',
              );
            },
          ),
          _FeatureTile(
            icon: Icons.music_note,
            title: 'Trending Music Direction',
            subtitle: 'Use current Instagram music later.',
            onTap: () {
              _showMessage(
                context,
                'Music direction opened.',
              );
            },
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   COLLAGE
   ============================================================ */

class CollagePage extends StatefulWidget {
  const CollagePage({super.key});

  @override
  State<CollagePage> createState() => _CollagePageState();
}

class _CollagePageState extends State<CollagePage> {
  final ImagePicker picker = ImagePicker();
  List<XFile> images = [];

  Future<void> selectImages() async {
    try {
      final result = await picker.pickMultiImage(
        imageQuality: 95,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        images = result;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      _showMessage(
        context,
        'Could not select images.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collage Creator'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _WorkspaceHeader(
            icon: Icons.collections_outlined,
            title: 'Create a Collage',
            subtitle:
                'Select photos and preview a clean collage layout.',
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: selectImages,
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('Select Photos'),
          ),
          const SizedBox(height: 20),
          if (images.isEmpty)
            const _EmptyWorkspace(
              icon: Icons.collections_outlined,
              title: 'No photos selected',
              text: 'Choose photos to preview your collage.',
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: images.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(images[index].path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

/* ============================================================
   HIGHLIGHTS
   ============================================================ */

class HighlightsPage extends StatelessWidget {
  const HighlightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Life', Icons.favorite_outline),
      ('Travel', Icons.flight_takeoff),
      ('Style', Icons.checkroom_outlined),
      ('Work', Icons.work_outline),
      ('Memories', Icons.photo_album_outlined),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Highlights Manager'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _WorkspaceHeader(
            icon: Icons.star_outline,
            title: 'Highlights',
            subtitle:
                'Organize your profile highlights with a clean structure.',
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(item.$2),
                ),
                title: Text(item.$1),
                subtitle: const Text('Highlight category'),
                trailing: const Icon(Icons.edit_outlined),
                onTap: () {
                  _showMessage(
                    context,
                    '${item.$1} highlight selected.',
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

/* ============================================================
   PLANNER
   ============================================================ */

class PlannerPage extends StatelessWidget {
  const PlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Planner'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _WorkspaceHeader(
            icon: Icons.calendar_month_outlined,
            title: 'Planner',
            subtitle:
                'Plan posts, stories and reels before publishing.',
          ),
          const SizedBox(height: 18),
          _CalendarDay(
            day: 'Today',
            title: 'Review photos',
            subtitle: 'Choose the strongest content.',
          ),
          _CalendarDay(
            day: 'Tomorrow',
            title: 'Post',
            subtitle: 'Prepare caption, music and final approval.',
          ),
          _CalendarDay(
            day: 'This week',
            title: 'Story sequence',
            subtitle: 'Create a consistent story plan.',
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: () {
              _showMessage(
                context,
                'New content plan created.',
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Plan'),
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   APPROVAL
   ============================================================ */

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approval'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _WorkspaceHeader(
            icon: Icons.check_circle_outline,
            title: 'Final Approval',
            subtitle:
                'GM prepares recommendations, but you always make the final decision.',
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nothing will be posted automatically.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Review your photo, caption, music and schedule before publishing.',
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            _showMessage(
                              context,
                              'Approved for posting.',
                            );
                          },
                          child: const Text('Approve'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _showMessage(
                              context,
                              'Sent back for changes.',
                            );
                          },
                          child: const Text('Edit'),
                        ),
                      ),
                    ],
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

/* ============================================================
   PROFILE
   ============================================================ */

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _ProfileHeader(),
          const SizedBox(height: 18),
          _ProfileItem(
            icon: Icons.face_outlined,
            title: 'Identity Reference',
            subtitle: 'Preserve your natural identity.',
          ),
          _ProfileItem(
            icon: Icons.accessibility_new,
            title: 'Body Proportions',
            subtitle: 'Never change body structure.',
          ),
          _ProfileItem(
            icon: Icons.checkroom_outlined,
            title: 'Clothing Preferences',
            subtitle: 'Remember your preferred style.',
          ),
          _ProfileItem(
            icon: Icons.palette_outlined,
            title: 'Aesthetic',
            subtitle: 'Natural, premium, clean and professional.',
          ),
          _ProfileItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'App preferences and controls.',
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   DRAFTS
   ============================================================ */

class DraftsPage extends StatelessWidget {
  const DraftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _SimplePage(
      title: 'Drafts',
      icon: Icons.drafts_outlined,
      text:
          'Your unfinished posts, stories and reels will appear here.',
    );
  }
}

/* ============================================================
   IDEAS
   ============================================================ */

class IdeasPage extends StatelessWidget {
  const IdeasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Ideas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _IdeaCard(
            title: 'Natural portrait',
            text:
                'Simple outdoor portrait with natural light and minimal editing.',
          ),
          _IdeaCard(
            title: 'Lifestyle post',
            text:
                'A candid lifestyle photo with a short confident caption.',
          ),
          _IdeaCard(
            title: 'Story sequence',
            text:
                'Three-frame story: photo → detail → short message.',
          ),
        ],
      ),
    );
  }
}

/* ============================================================
   REUSABLE WIDGETS
   ============================================================ */

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 34,
            ),
            const SizedBox(height: 12),
            Text(
              'Good to see you.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'GM helps you plan, create and manage your social content while keeping your appearance natural.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  const _SafetyCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.verified_user_outlined),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'GM keeps your look natural. No face-identity or body-structure changes.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String action;
  final VoidCallback onTap;

  const _SectionTitle({
    required this.title,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        if (action.isNotEmpty)
          TextButton(
            onPressed: onTap,
            child: Text(action),
          ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(text),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: 8),
              Text(
                title,
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
  }
}

class _FeatureList extends StatelessWidget {
  final List<
      (IconData, String, String)> items;

  const _FeatureList({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Card(
              child: ListTile(
                leading: Icon(item.$1),
                title: Text(item.$2),
                subtitle: Text(item.$3),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _WorkspaceHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _WorkspaceHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              child: Icon(icon),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyWorkspace extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _EmptyWorkspace({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(
              icon,
              size: 54,
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final String number;
  final String title;
  final String result;

  const _SuggestionCard({
    required this.number,
    required this.title,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text(number),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(result),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  final String day;
  final String title;
  final String subtitle;

  const _CalendarDay({
    required this.day,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            day.substring(0, 1),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$day • $subtitle'),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 42,
              child: Icon(
                Icons.person,
                size: 42,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Personal Style Profile',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Natural • Premium • Simple • Clean • Professional',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _IdeaCard extends StatelessWidget {
  final String title;
  final String text;

  const _IdeaCard({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class _SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;

  const _SimplePage({
    required this.title,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ============================================================
   HELPERS
   ============================================================ */

void _showMessage(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
