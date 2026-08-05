import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/movie.dart';
import '../providers/movie_provider.dart';

class MoviesScreen extends ConsumerWidget {
  final String platformId;

  const MoviesScreen({super.key, required this.platformId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (platformId.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Invalid Platform ID'),
        ),
      );
    }

    final movies = ref.watch(movieNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies for Platform $platformId'),
      ),
      body: movies.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(child: Text('No Movies Available'));
          }
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _MovieCard(
                movie: movie,
                onEdit: () => _showMovieDialog(context, ref, movie: movie),
                onDelete: () => _deleteMovie(context, ref, movie),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMovieDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showMovieDialog(
    BuildContext context,
    WidgetRef ref, {
    Movie? movie,
  }) {
    final isEditing = movie != null;

    final titleController = TextEditingController(text: movie?.title ?? '');
    final directorController =
        TextEditingController(text: movie?.director ?? '');
    final ratingController =
        TextEditingController(text: movie?.rating.toString() ?? '');
    final durationController =
        TextEditingController(text: movie?.duration.toString() ?? '');
    final posterUrlController =
        TextEditingController(text: movie?.posterUrl ?? '');
    DateTime? selectedReleaseDate =
        movie != null ? DateTime.parse(movie.releaseYear) : null;

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
                    isEditing ? 'Edit Movie' : 'Add Movie',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: directorController,
                    decoration: const InputDecoration(
                      labelText: 'Director',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: posterUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Poster URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: ratingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Rating',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Duration (mins)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(selectedReleaseDate == null
                            ? 'Select Release Date'
                            : selectedReleaseDate!.toIso8601String()),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedReleaseDate ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            selectedReleaseDate = pickedDate;
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          final title = titleController.text.trim();
                          final director = directorController.text.trim();
                          final posterUrl = posterUrlController.text.trim();
                          final rating =
                              int.tryParse(ratingController.text.trim());
                          final duration =
                              int.tryParse(durationController.text.trim());

                          if (title.isEmpty ||
                              director.isEmpty ||
                              selectedReleaseDate == null ||
                              rating == null ||
                              duration == null ||
                              posterUrl.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('All fields are required')),
                            );
                            return;
                          }

                          final updatedMovie = Movie(
                            id: movie?.id,
                            platformId: int.tryParse(platformId) ?? 0,
                            title: title,
                            director: director,
                            releaseYear: selectedReleaseDate!.toIso8601String(),
                            rating: rating,
                            duration: duration,
                            posterUrl: posterUrl,
                          );

                          if (isEditing) {
                            ref
                                .read(movieNotifierProvider.notifier)
                                .updateMovie(updatedMovie);
                          } else {
                            ref
                                .read(movieNotifierProvider.notifier)
                                .addMovie(updatedMovie);
                          }

                          Navigator.of(dialogContext).pop();
                        },
                        child: Text(isEditing ? 'Update' : 'Save'),
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

  void _deleteMovie(
    BuildContext context,
    WidgetRef ref,
    Movie movie,
  ) {
    ref.read(movieNotifierProvider.notifier).deleteMovie(movie);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${movie.title} deleted'),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MovieCard({
    required this.movie,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Movie Icon
              Container(
                //movie poster decoration
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.network(
                  movie.posterUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 16),
              // Movie Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie Title
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating and Duration using Wrap to prevent overflow
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        // Rating
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Rating: ${movie.rating}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        // Duration
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.timer,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Duration: ${movie.duration} mins',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
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
