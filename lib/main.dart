import 'package:flutter/material.dart';

import 'data.dart';
import 'detail.dart';
import 'theme.dart';

void main() => runApp(const HanzoApp());

class HanzoApp extends StatelessWidget {
  const HanzoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Hanzo Flutter',
        debugShowCheckedModeBanner: false,
        theme: hanzoTheme(),
        home: const Shell(),
      );
}

/// NavigationBar + IndexedStack: each tab keeps its own scroll position and
/// state, which is what users expect and what a naive `switch` throws away.
class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: _tab,
          children: const [FeedTab(), SearchTab(), AboutTab()],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (i) => setState(() => _tab = i),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Feed'),
            NavigationDestination(
                icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(
                icon: Icon(Icons.info_outline), selectedIcon: Icon(Icons.info), label: 'About'),
          ],
        ),
      );
}

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('Hanzo Flutter')),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, i) => ItemCard(item: items[i]),
            ),
          ),
        ],
      );
}

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DetailPage(item: item)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.tag.toUpperCase(),
                  style: text.labelSmall?.copyWith(color: seed, letterSpacing: 1)),
              const SizedBox(height: 6),
              Text(item.title, style: text.titleMedium),
              const SizedBox(height: 4),
              Text(item.blurb, style: text.bodyMedium?.copyWith(color: Colors.white60)),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final hits = items
        .where((i) => '${i.title}${i.blurb}${i.tag}'.toLowerCase().contains(_q.toLowerCase()))
        .toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchBar(
              hintText: 'Search',
              leading: const Icon(Icons.search),
              onChanged: (v) => setState(() => _q = v),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: hits.isEmpty
                  ? const Center(child: Text('No matches.', style: TextStyle(color: Colors.white54)))
                  : ListView.builder(
                      itemCount: hits.length,
                      itemBuilder: (context, i) => ListTile(
                        title: Text(hits[i].title),
                        trailing: Text(hits[i].tag, style: const TextStyle(color: Colors.white54)),
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => DetailPage(item: hits[i]))),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            ListTile(title: Text('Framework'), trailing: Text('Flutter', style: TextStyle(color: Colors.white54))),
            Divider(height: 1),
            ListTile(title: Text('Targets'), trailing: Text('iOS · Android · web', style: TextStyle(color: Colors.white54))),
            Divider(height: 1),
            ListTile(title: Text('Design'), trailing: Text('Material 3', style: TextStyle(color: Colors.white54))),
          ],
        ),
      );
}
