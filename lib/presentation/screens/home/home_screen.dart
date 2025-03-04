import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_base/presentation/widget/buttons/primary_button.dart';
import 'package:source_base/presentation/widget/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isLoading = false;

  // Các items trong bottom navigation bar
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.explore, 'label': 'Explore'},
    {'icon': Icons.notifications, 'label': 'Notifications'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  // Các widget tương ứng với mỗi tab
  final List<Widget> _screens = [
    const _HomeTabContent(),
    const Center(child: Text('Explore Content')),
    const Center(child: Text('Notifications Content')),
    const Center(child: Text('Profile Content')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings screen
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _screens[_selectedIndex],
          if (_isLoading)
            LoadingIndicator.fullScreen(
              message: 'Loading...',
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: _navItems
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item['icon']),
                  label: item['label'],
                ))
            .toList(),
      ),
    );
  }
}

class _HomeTabContent extends StatelessWidget {
  const _HomeTabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context),
          const SizedBox(height: 24),
          _buildFeaturedSection(context),
          const SizedBox(height: 24),
          _buildRecentActivitySection(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, User!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'We hope you\'re having a great day.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Get Started',
              onPressed: () {
                // Action when button is pressed
              },
              suffixIcon: Icons.arrow_forward,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Item ${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Description for item ${index + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Colors.primaries[index % Colors.primaries.length],
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              title: Text('Activity ${index + 1}'),
              subtitle: Text('This is a description for activity ${index + 1}'),
              trailing: Text(
                '${index + 1}h ago',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              onTap: () {
                // Handle tap on activity
              },
            );
          },
        ),
      ],
    );
  }
}
