import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const StreamBoostersApp());

const Color ink = Color(0xFF10110F);
const Color panel = Color(0xFF1B1D19);
const Color accent = Color(0xFFFFD43B);
const Color spotifyGreen = Color(0xFF1DB954);

class StreamBoostersApp extends StatelessWidget {
  const StreamBoostersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamBoosters',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ink,
        colorScheme: const ColorScheme.dark(
          primary: accent,
          secondary: spotifyGreen,
          surface: panel,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ink,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: panel,
          indicatorColor: accent.withValues(alpha: 0.18),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: 11,
              color: states.contains(WidgetState.selected)
                  ? accent
                  : Colors.white60,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: panel,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomeShell(),
    );
  }
}

class Track {
  const Track({
    required this.title,
    required this.artist,
    required this.genre,
    required this.spotifyUrl,
  });

  final String title;
  final String artist;
  final String genre;
  final String spotifyUrl;
}

const demoTracks = <Track>[
  Track(
    title: 'Your First Release',
    artist: 'Demo Artist',
    genre: 'Pop',
    spotifyUrl: 'https://open.spotify.com/',
  ),
  Track(
    title: 'Midnight Lights',
    artist: 'Demo Artist',
    genre: 'Alternative',
    spotifyUrl: 'https://open.spotify.com/',
  ),
  Track(
    title: 'New Horizons',
    artist: 'Another Artist',
    genre: 'Instrumental',
    spotifyUrl: 'https://open.spotify.com/',
  ),
];

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int selectedIndex = 0;

  static const pages = <Widget>[
    DashboardPage(),
    ArtistsPage(),
    CampaignsPage(),
    ReportsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Row(
          children: [
            Icon(Icons.graphic_eq_rounded, color: accent, size: 28),
            SizedBox(width: 10),
            Text('Stream', style: TextStyle(fontWeight: FontWeight.w800)),
            Text('Boosters', style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Informasi aplikasi',
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'StreamBoosters',
              applicationVersion: '0.1.0 MVP',
              applicationLegalese:
                  'Promosi musik organik. Klik tautan bukan bukti stream.',
            ),
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => setState(() => selectedIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.mic_none_rounded), selectedIcon: Icon(Icons.mic_rounded), label: 'Artis'),
          NavigationDestination(icon: Icon(Icons.campaign_outlined), selectedIcon: Icon(Icons.campaign), label: 'Kampanye'),
          NavigationDestination(icon: Icon(Icons.bar_chart_rounded), selectedIcon: Icon(Icons.bar_chart), label: 'Laporan'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF33301D), Color(0xFF1B1D19)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: accent.withValues(alpha: 0.25)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MUSIC GROWS ORGANICALLY', style: TextStyle(color: accent, fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w800)),
              SizedBox(height: 10),
              Text('Bawa musikmu\nke pendengar baru.', style: TextStyle(fontSize: 27, height: 1.15, fontWeight: FontWeight.w800)),
              SizedBox(height: 10),
              Text('Kelola katalog multi-artis, bagikan tautan resmi, dan evaluasi hasil promosi.', style: TextStyle(color: Colors.white70, height: 1.4)),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const SectionHeading(title: 'Ringkasan', subtitle: 'Data contoh — belum terhubung ke Spotify'),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(child: MetricCard(icon: Icons.library_music_outlined, label: 'Lagu', value: '03')),
            SizedBox(width: 10),
            Expanded(child: MetricCard(icon: Icons.campaign_outlined, label: 'Kampanye', value: '00')),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(child: MetricCard(icon: Icons.link_rounded, label: 'Klik tautan', value: '—')),
            SizedBox(width: 10),
            Expanded(child: MetricCard(icon: Icons.headphones_rounded, label: 'Stream valid', value: '—')),
          ],
        ),
        const SizedBox(height: 22),
        const SectionHeading(title: 'Mulai di sini', subtitle: 'Langkah promosi yang dapat diukur'),
        const SizedBox(height: 12),
        const ActionTile(
          icon: Icons.library_add_outlined,
          title: 'Periksa katalog musik',
          subtitle: 'Kelola daftar lagu dan tautan Spotify.',
        ),
        const ActionTile(
          icon: Icons.ios_share_rounded,
          title: 'Bagikan lagu secara organik',
          subtitle: 'Ajak pendengar asli melalui kanal promosi.',
        ),
        const ActionTile(
          icon: Icons.file_upload_outlined,
          title: 'Siapkan laporan resmi',
          subtitle: 'Impor metrik dari laporan resmi saat fitur tersedia.',
        ),
        const SizedBox(height: 12),
        const ComplianceNote(),
      ],
    );
  }
}

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final artists = demoTracks.map((track) => track.artist).toSet().toList();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionHeading(title: 'Katalog artis', subtitle: 'Contoh data lokal untuk demonstrasi'),
        const SizedBox(height: 16),
        ...artists.map((artist) {
          final count = demoTracks.where((track) => track.artist == artist).length;
          return Card(
            color: panel,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: accent.withValues(alpha: 0.15),
                child: const Icon(Icons.person_rounded, color: accent),
              ),
              title: Text(artist, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('$count lagu dalam contoh katalog'),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          );
        }),
        const SizedBox(height: 8),
        const ComplianceNote(),
      ],
    );
  }
}

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionHeading(title: 'Kampanye promosi', subtitle: 'Rencanakan distribusi konten organik'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(18)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.campaign_rounded, color: accent, size: 30),
              SizedBox(height: 12),
              Text('Belum ada kampanye', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              SizedBox(height: 8),
              Text('Versi awal ini menampilkan rancangan antarmuka. Pembuatan kampanye, pelacakan klik, dan sinkronisasi backend belum aktif.', style: TextStyle(color: Colors.white70, height: 1.45)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const ActionTile(icon: Icons.video_library_outlined, title: 'Konten pendek', subtitle: 'Rencanakan video untuk Reels, Shorts, dan TikTok.'),
        const ActionTile(icon: Icons.groups_2_outlined, title: 'Komunitas pendengar', subtitle: 'Bagikan rilisan di komunitas yang relevan tanpa spam.'),
        const ActionTile(icon: Icons.qr_code_2_rounded, title: 'Tautan dan QR', subtitle: 'Fitur pembuatan tautan kampanye akan ditambahkan.'),
      ],
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionHeading(title: 'Laporan performa', subtitle: 'Angka hanya ditampilkan jika sumber datanya tersedia'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(18)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Belum ada data laporan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              SizedBox(height: 8),
              Text('Hubungkan sumber data resmi yang diizinkan atau impor laporan resmi. Spotify Web API tidak boleh diasumsikan menyediakan angka stream harian untuk semua lagu.', style: TextStyle(color: Colors.white70, height: 1.45)),
              SizedBox(height: 18),
              Divider(color: Colors.white12),
              SizedBox(height: 8),
              MetricRow(label: 'Klik tautan kampanye', value: 'Belum tersedia'),
              MetricRow(label: 'Stream dari laporan resmi', value: 'Belum tersedia'),
              MetricRow(label: 'Periode laporan', value: 'Belum tersedia'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const ComplianceNote(),
      ],
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      );
}

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accent, size: 22),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 3),
            Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      );
}

class ActionTile extends StatelessWidget {
  const ActionTile({super.key, required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 9),
        decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: Icon(icon, color: accent),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        ),
      );
}

class MetricRow extends StatelessWidget {
  const MetricRow({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(color: Colors.white70))),
            const SizedBox(width: 12),
            Text(value, style: const TextStyle(color: accent, fontWeight: FontWeight.w700)),
          ],
        ),
      );
}

class ComplianceNote extends StatelessWidget {
  const ComplianceNote({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white12),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.verified_user_outlined, color: spotifyGreen, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Promosi organik saja. Aplikasi tidak membuat pemutaran otomatis. Klik tautan tidak sama dengan stream; gunakan laporan resmi untuk angka stream.',
                style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.45),
              ),
            ),
          ],
        ),
      );
}

Future<void> openSpotifyLink(String value) async {
  final uri = Uri.tryParse(value);
  if (uri == null || uri.scheme != 'https' || uri.host != 'open.spotify.com') {
    throw const FormatException('Masukkan tautan Spotify HTTPS yang valid.');
  }
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Tautan Spotify tidak dapat dibuka.');
  }
}
