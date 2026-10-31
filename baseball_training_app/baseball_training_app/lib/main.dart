
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const ApproachBaseballApp(),
    ),
  );
}

// PROVIDER

class AppProvider extends ChangeNotifier {
  final List<String> descriptions = [
    'Build strength and power',
    'Improve flexibility and movement',
    'Improve your swing and timing',
    'Develop pitching mechanics',
    'Book a private training session',
  ];

  final List<String> itemNames = [
    'Weightlifting',
    'Mobility Training',
    'Hitting Drills',
    'Pitching Drills',
    'Private Lessons',
  ];

  final List<String> trainingCards = [
    'Weightlifting',
    'Mobility',
    'Hitting',
    'Pitching',
    'Private Lessons',
  ];

  final Map<String, List<String>> exercises = {
    'Weightlifting': [
      'Squats',
      'Bench Press',
      'Deadlifts',
      'Pull-Ups',
    ],
    'Mobility Training': [
      'Hip Mobility',
      'Shoulder Mobility',
      'Dynamic Stretching',
      'Core Mobility',
    ],
    'Hitting Drills': [
      'Tee Work',
      'Soft Toss',
      'Front Toss',
      'Timing Drills',
    ],
    'Pitching Drills': [
      'Long Toss',
      'Balance Drill',
      'Stride Drill',
      'Pitching Mechanics',
    ],
  };

  String selectedTraining = '';
  String selectedExercise = '';

  void selectTraining(String training) {
    selectedTraining = training;
    notifyListeners();
  }

  void selectExercise(String exercise) {
    selectedExercise = exercise;
    notifyListeners();
  }

  List<String> get currentExercises {
    return exercises[selectedTraining] ?? [];
  }

  int workoutsCompleted = 12;
  String trainingFocus = 'Hitting';
  String lessons = '2 Upcoming';

  void completeWorkout() {
    workoutsCompleted++;
    notifyListeners();
  }

  void updateTrainingFocus(String focus) {
    trainingFocus = focus;
    notifyListeners();
  }

  // API DATA

  List<dynamic> posts = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPosts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        posts = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      errorMessage = 'Unable to load posts. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }
}

// MAIN APP

class ApproachBaseballApp extends StatelessWidget {
  const ApproachBaseballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Approach Baseball',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.red,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const BaseballHomePage(),
    );
  }
}

// HOME PAGE

class BaseballHomePage extends StatelessWidget {
  const BaseballHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'APPROACH BASEBALL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BASEBALL TRAINING',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose Your Approach',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 135,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.trainingCards.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 145,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.sports_baseball,
                              color: Colors.black,
                              size: 38,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              provider.trainingCards[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'TRAINING OPTIONS',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: provider.itemNames.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            _getIcon(index),
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          provider.itemNames[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        subtitle: Text(
                          provider.descriptions[index],
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        ),
                        onTap: () {
                          context.read<AppProvider>().selectTraining(
                            provider.itemNames[index],
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const TrainingDetailsPage(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(15),
                  ),
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('VIEW API POSTS'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ApiPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.fitness_center;
      case 1:
        return Icons.accessibility_new;
      case 2:
        return Icons.sports_baseball;
      case 3:
        return Icons.sports;
      case 4:
        return Icons.calendar_month;
      default:
        return Icons.sports_baseball;
    }
  }
}

// TRAINING DETAILS

class TrainingDetailsPage extends StatelessWidget {
  const TrainingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.selectedTraining),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.selectedTraining.toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Training Program',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select an exercise or drill to learn more.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 25),

            Expanded(
              child: ListView.builder(
                itemCount: provider.currentExercises.length,
                itemBuilder: (context, index) {
                  final exercise =
                      provider.currentExercises[index];

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        exercise,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 16,
                      ),
                      onTap: () {
                        context.read<AppProvider>().selectExercise(
                          exercise,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ExerciseDetailsPage(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ExerciseDetailsPage extends StatelessWidget {
  const ExerciseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.selectedExercise),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.sports_baseball,
              size: 70,
              color: Colors.white,
            ),
            const SizedBox(height: 25),

            Text(
              provider.selectedTraining.toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              provider.selectedExercise,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              'ABOUT THIS DRILL',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Review the ${provider.selectedExercise} video below.',
              style: const TextStyle(
                fontSize: 17,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Recommended: 3 sets × 10 reps',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  context.read<AppProvider>().completeWorkout();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Workout completed!'),
                    ),
                  );
                },
                child: const Text('COMPLETE WORKOUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 55,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Baseball Player',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),

            const Text(
              'Approach Baseball Member',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 35),

            _profileCard(
              Icons.fitness_center,
              'Workouts Completed',
              '${provider.workoutsCompleted}',
            ),

            _profileCard(
              Icons.sports_baseball,
              'Training Focus',
              provider.trainingFocus,
            ),

            _profileCard(
              Icons.calendar_month,
              'Lessons',
              provider.lessons,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(width: 15),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// JSONPLACEHOLDER API PAGE
// ======================================================

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AppProvider>().fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('API POSTS'),
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(AppProvider provider) {

    // LOADING STATE

    if (provider.isLoading && provider.posts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    // ERROR STATE

    if (provider.errorMessage != null &&
        provider.posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red,
              ),
              const SizedBox(height: 15),

              Text(
                provider.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  context.read<AppProvider>().fetchPosts();
                },
                child: const Text('TRY AGAIN'),
              ),
            ],
          ),
        ),
      );
    }

    // EMPTY STATE

    if (provider.posts.isEmpty) {
      return RefreshIndicator(
        onRefresh: () {
          return context.read<AppProvider>().fetchPosts();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 200),
            Center(
              child: Text(
                'No posts available.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // DATA STATE

    return RefreshIndicator(
      color: Colors.black,
      backgroundColor: Colors.white,
      onRefresh: () {
        return context.read<AppProvider>().fetchPosts();
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: provider.posts.length,
        itemBuilder: (context, index) {
          final post = provider.posts[index];

          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 14),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'POST #${post['id']}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    post['title'] ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    post['body'] ?? '',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'User ID: ${post['userId']}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
