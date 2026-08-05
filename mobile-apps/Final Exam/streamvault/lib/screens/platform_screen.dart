import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:streamvault/model/platform_summary_view.dart';
import 'package:streamvault/model/platform.dart';
import 'package:streamvault/providers/platform_provider.dart';
import 'package:streamvault/providers/streamvault_repo_provider.dart';
import 'package:streamvault/router/app_router.dart';

class PlatformScreen extends ConsumerWidget {
  const PlatformScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platforms = ref.watch(platformNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading:
            const Icon(Icons.movie, color: Color.fromARGB(255, 24, 24, 23)),
        title: const Text(
          'Streaming Platforms',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              //nice font for movies
              fontFamily: 'Cinzel',
              fontSize: 24,
              //wrap the text
              overflow: TextOverflow.visible,
              letterSpacing: 2),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightGreenAccent,
                Color.fromARGB(255, 68, 255, 143)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: platforms.when(
        data: (platforms) {
          if (platforms.isEmpty) {
            return const Center(child: Text('No Platforms Available'));
          }
          return ListView.builder(
            itemCount: platforms.length,
            itemBuilder: (context, index) {
              final platform = platforms[index];
              return _PlatformCard(
                platform: platform,
                onEdit: () =>
                    _showPlatformDialog(context, ref, platform: platform),
                onDelete: () => _deletePlatform(context, ref, platform),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Error: ${error.toString()}')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPlatformDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Platform'),
      ),
    );
  }

  /// Shows a dialog to add or edit a platform.
  void _showPlatformDialog(
    BuildContext context,
    WidgetRef ref, {
    Platform? platform,
  }) {
    final isEditing = platform != null;
    final platformNameController =
        TextEditingController(text: platform?.name ?? '');
    final countryController =
        TextEditingController(text: platform?.country ?? '');
    final logoUrlController =
        TextEditingController(text: platform?.logoUrl ?? '');
    final activeUsersController =
        TextEditingController(text: platform?.activeUsers?.toString() ?? '');
    final monthlyCostController =
        TextEditingController(text: platform?.monthlyCost?.toString() ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isEditing ? 'Edit Platform' : 'Add Platform',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: platformNameController,
                    decoration: const InputDecoration(
                      labelText: 'Platform Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: countryController,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: logoUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Logo URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: activeUsersController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Active Users',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: monthlyCostController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Monthly Cost',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancel'),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          final platformName =
                              platformNameController.text.trim();
                          final country = countryController.text.trim();
                          final logoUrl = logoUrlController.text.trim();
                          final activeUsersText =
                              activeUsersController.text.trim();
                          final monthlyCostText =
                              monthlyCostController.text.trim();

                          if (platformName.isEmpty ||
                              country.isEmpty ||
                              logoUrl.isEmpty ||
                              activeUsersText.isEmpty ||
                              monthlyCostText.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All fields must be filled!'),
                              ),
                            );
                            return;
                          }

                          final activeUsers = int.tryParse(activeUsersText);
                          final monthlyCost = int.tryParse(monthlyCostText);

                          if (activeUsers == null || monthlyCost == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Active Users and Monthly Cost must be valid numbers!'),
                              ),
                            );
                            return;
                          }

                          final updatedPlatform = Platform(
                            id: platform?.id,
                            name: platformName,
                            country: country,
                            activeUsers: activeUsers,
                            monthlyCost: monthlyCost,
                            logoUrl: logoUrl,
                          );

                          if (isEditing) {
                            ref
                                .read(platformNotifierProvider.notifier)
                                .updatePlatform(updatedPlatform);
                          } else {
                            ref
                                .read(platformNotifierProvider.notifier)
                                .addPlatform(updatedPlatform);
                          }

                          Navigator.of(dialogContext).pop();
                        },
                        icon: Icon(isEditing ? Icons.update : Icons.save),
                        label: Text(isEditing ? 'Update' : 'Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Deletes a platform and shows a snackbar notification.
  void _deletePlatform(
    BuildContext context,
    WidgetRef ref,
    Platform platform,
  ) {
    ref.read(platformNotifierProvider.notifier).deletePlatform(platform);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Platform ${platform.name} deleted'),
      ),
    );
  }
}

class _PlatformCard extends ConsumerWidget {
  final Platform platform;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PlatformCard({
    required this.platform,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ref.read(selectedPlatformIdProvider.notifier).state = platform.id;
          context.goNamed(AppRouter.moviesScreen.name,
              pathParameters: {'platformId': platform.id.toString()});
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Platform Logo
              Container(
                decoration: BoxDecoration(
                  // color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.network(
                  platform.logoUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.tv,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Platform Details and Summary
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Platform Name
                    Text(
                      platform.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Country
                    Text(
                      'Country: ${platform.country}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Platform Summary
                    StreamBuilder<PlatformSummaryView?>(
                      stream: ref
                          .read(platformNotifierProvider.notifier)
                          .observePlatformSummary(platform.id!),
                      builder: (context, snapshot) {
                        final summary = snapshot.data;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            'Loading platform details...',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          );
                        }
                        if (snapshot.hasError || summary == null) {
                          return const Text(
                            'No details available',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent,
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Total Movies
                            Row(
                              children: [
                                const Icon(
                                  Icons.movie,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    '${summary.totalMovies} Movies',
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Average Rating
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    'Average Rating: ${summary.averageRating.toStringAsFixed(1)}',
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Average Duration
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    'Average Duration: ${summary.averageDuration.toStringAsFixed(1)} mins',
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Action Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
