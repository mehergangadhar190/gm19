
import 'dart:math';
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
        scaffoldBackgroundColor: const Color(0xFF0B0F15),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8FD69A),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
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
  int _tab = 0;
  final List<XFile> _selectedPhotos = [];

  void _openSuggestions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AISuggestionsPage(
          initialPhotos: List<XFile>.from(_selectedPhotos),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(),
      _content(),
      _planner(),
      _profile(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        backgroundColor: const Color(0xFF171D18),
        indicatorColor: const Color(0xFF3A513D),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Content'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Planner'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _home() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: const Color(0xFF0B0F15),
          floating: true,
          title: const Text(
            'GM Manager',
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, size: 28),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(17, 8, 17, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _welcomeCard(),
              const SizedBox(height: 22),
              const Text('Today', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('Your personal social-media manager',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 15)),
              const SizedBox(height: 15),
              _recommendationCard(),
              const SizedBox(height: 28),
              const Text('GM Features', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('Everything in one place',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 15)),
              const SizedBox(height: 15),
              _featureGrid(),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF171D18),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 63,
            height: 63,
            decoration: BoxDecoration(
              color: const Color(0xFF145C2B),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(Icons.auto_awesome, color: Color(0xFFB7F0BE), size: 32),
          ),
          const SizedBox(width: 17),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to GM', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('Your personal Instagram & content manager.',
                    style: TextStyle(color: Colors.white70, fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendationCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(19, 19, 19, 20),
      decoration: BoxDecoration(
        color: const Color(0xFF171D18),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb_outline, color: Color(0xFF9CE7A5)),
              SizedBox(width: 12),
              Text("Today's recommendation",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Create a clean, natural post with a premium look. Keep the background authentic and avoid heavy editing.',
            style: TextStyle(color: Colors.grey.shade300, fontSize: 15.5, height: 1.45),
          ),
          const SizedBox(height: 17),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: ['Natural', 'Premium', 'Clean', 'Professional']
                .map((e) => _tag(e))
                .toList(),
          ),
          const SizedBox(height: 19),
          FilledButton.icon(
            onPressed: _openSuggestions,
            icon: const Icon(Icons.auto_awesome),
            label: const Text('AI recommendation'),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.check, size: 16),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey.shade300,
        side: BorderSide(color: Colors.grey.shade700),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      ),
    );
  }

  Widget _featureGrid() {
    final features = [
      _Feature('Photo Studio', Icons.camera_alt_outlined, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PhotoStudioPage()));
      }),
      _Feature('AI Post Suggestions', Icons.auto_awesome, _openSuggestions),
      _Feature('Collage Creator', Icons.photo_library_outlined, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SimpleFeaturePage(title: 'Collage Creator', icon: Icons.photo_library_outlined)));
      }),
      _Feature('Highlights Manager', Icons.star_border, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SimpleFeaturePage(title: 'Highlights Manager', icon: Icons.star_border)));
      }),
      _Feature('Content Calendar', Icons.calendar_month_outlined, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SimpleFeaturePage(title: 'Content Calendar', icon: Icons.calendar_month_outlined)));
      }),
      _Feature('Drafts', Icons.drafts_outlined, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SimpleFeaturePage(title: 'Drafts', icon: Icons.drafts_outlined)));
      }),
      _Feature('Saved Ideas', Icons.lightbulb_outline, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SimpleFeaturePage(title: 'Saved Ideas', icon: Icons.lightbulb_outline)));
      }),
      _Feature('Approval', Icons.check_circle_outline, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ApprovalPage()));
      }),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (_, i) => _featureTile(features[i]),
    );
  }

  Widget _featureTile(_Feature f) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: f.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF171D18),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(f.icon, size: 31, color: const Color(0xFF9CE7A5)),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(f.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content() => const SimpleTabPage(title: 'Content', subtitle: 'Your posts, stories, collages and drafts.');
  Widget _planner() => const SimpleTabPage(title: 'Planner', subtitle: 'Plan posts, stories and the best publishing times.');
  Widget _profile() => const SimpleTabPage(title: 'Profile', subtitle: 'GM personal style, preferences and approval settings.');
}

class _Feature {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  _Feature(this.title, this.icon, this.onTap);
}

class PhotoStudioPage extends StatefulWidget {
  const PhotoStudioPage({super.key});

  @override
  State<PhotoStudioPage> createState() => _PhotoStudioPageState();
}

class _PhotoStudioPageState extends State<PhotoStudioPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? photo;

  Future<void> _pick(ImageSource source) async {
    final result = await _picker.pickImage(source: source, imageQuality: 95);
    if (result != null) setState(() => photo = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Studio')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Expanded(
              child: photo == null
                  ? Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF171D18),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Center(
                        child: Text('Choose a photo to start', style: TextStyle(fontSize: 18)),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.file(
                        File(photo!.path),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: FilledButton.icon(onPressed: () => _pick(ImageSource.gallery), icon: const Icon(Icons.photo), label: const Text('Gallery'))),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton.icon(onPressed: () => _pick(ImageSource.camera), icon: const Icon(Icons.camera_alt), label: const Text('Camera'))),
              ],
            ),
            const SizedBox(height: 8),
            Text('GM keeps your face and body structure unchanged.',
                style: TextStyle(color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }
}

class AISuggestionsPage extends StatefulWidget {
  final List<XFile> initialPhotos;
  const AISuggestionsPage({super.key, this.initialPhotos = const []});

  @override
  State<AISuggestionsPage> createState() => _AISuggestionsPageState();
}

class _AISuggestionsPageState extends State<AISuggestionsPage> {
  final ImagePicker _picker = ImagePicker();
  late List<XFile> photos;
  bool analyzing = false;
  int bestIndex = 0;
  bool approved = false;

  @override
  void initState() {
    super.initState();
    photos = List<XFile>.from(widget.initialPhotos);
  }

  Future<void> _choosePhotos() async {
    final picked = await _picker.pickMultiImage(imageQuality: 95);
    if (picked.isEmpty) return;

    setState(() {
      photos = picked.take(3).toList();
      approved = false;
    });
  }

  Future<void> _analyze() async {
    if (photos.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select 2–3 photos first.')),
      );
      return;
    }

    setState(() => analyzing = true);
    await Future.delayed(const Duration(milliseconds: 900));

    // Temporary local ranking: this is intentionally only a functional
    // fallback. It is NOT a real vision-AI judgment of the photographs.
    final scores = List<double>.generate(
      photos.length,
      (i) => 70 + Random(i + photos[i].path.length).nextDouble() * 25,
    );
    bestIndex = scores.indexOf(scores.reduce(max));

    if (mounted) setState(() => analyzing = false);
  }

  void _approve() {
    setState(() => approved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Approved. GM will not post without your final permission.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Post Suggestions')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _intro(),
          const SizedBox(height: 18),
          if (photos.isNotEmpty) _photoStrip(),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: analyzing ? null : _choosePhotos,
            icon: const Icon(Icons.add_photo_alternate_outlined),
            label: Text(photos.isEmpty ? 'Choose 2–3 photos' : 'Choose again'),
          ),
          if (photos.length >= 2) ...[
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: analyzing ? null : _analyze,
              icon: analyzing
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.auto_awesome),
              label: Text(analyzing ? 'Analyzing…' : 'Generate recommendation'),
            ),
          ],
          if (photos.length >= 2) ...[
            const SizedBox(height: 24),
            _resultCard(),
          ],
          const SizedBox(height: 18),
          _naturalRuleCard(),
        ],
      ),
    );
  }

  Widget _intro() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF171D18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('GM Post Decision', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Give GM 2–3 photos. GM prepares one complete post recommendation: best photo, pose direction, aesthetic, caption, music and posting time.',
              style: TextStyle(color: Colors.white70, height: 1.45)),
        ],
      ),
    );
  }

  Widget _photoStrip() {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(photos[i].path),
                  width: 145,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
              if (i == bestIndex && !analyzing)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF174C27),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Best', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _resultCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF171D18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recommendation', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          _decision('Best photo', 'Photo ${bestIndex + 1}'),
          _decision('Natural pose', 'Keep the current pose natural; improve posture and framing only.'),
          _decision('Aesthetic', 'Natural • Premium • Clean • Professional'),
          _decision('Caption', 'Simple, confident and natural — matching your personal style.'),
          _decision('Music', 'Choose a currently trending track that matches the mood before publishing.'),
          _decision('Posting time', 'Use your audience analytics to choose the strongest active window.'),
          const SizedBox(height: 10),
          if (!approved)
            FilledButton.icon(
              onPressed: _approve,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Approve recommendation'),
            )
          else
            const Row(
              children: [
                Icon(Icons.verified, color: Color(0xFF9CE7A5)),
                SizedBox(width: 8),
                Text('Approved by you', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _decision(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.white70, height: 1.35))),
        ],
      ),
    );
  }

  Widget _naturalRuleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade800),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: Color(0xFF9CE7A5)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'GM keeps your look natural. No face-identity changes, no body reshaping and no fake AI appearance.',
              style: TextStyle(color: Colors.white70, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({super.key});

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  bool approved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Approval')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Final control stays with you.',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('GM prepares content, but nothing is posted automatically.',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 25),
            FilledButton.icon(
              onPressed: () => setState(() => approved = true),
              icon: const Icon(Icons.check),
              label: Text(approved ? 'Approved' : 'Approve content'),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleFeaturePage extends StatelessWidget {
  final String title;
  final IconData icon;
  const SimpleFeaturePage({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: const Color(0xFF9CE7A5)),
            const SizedBox(height: 18),
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('GM feature workspace'),
          ],
        ),
      ),
    );
  }
}

class SimpleTabPage extends StatelessWidget {
  final String title;
  final String subtitle;
  const SimpleTabPage({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
}

