import 'package:flutter/material.dart';

void main() {
  runApp(const ApproachBaseballApp());
}

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
        colorScheme: ColorScheme.dark(
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

class BaseballHomePage extends StatelessWidget {
  const BaseballHomePage({super.key});

  final List<String> descriptions = const [
    'Build strength and power',
    'Improve flexibility and movement',
    'Improve your swing and timing',
    'Develop pitching mechanics',
    'Book a private training session',
  ];

  final List<String> itemNames = const [
    'Weightlifting',
    'Mobility Training',
    'Hitting Drills',
    'Pitching Drills',
    'Private Lessons',
  ];

  final List<String> trainingCards = const [
    'Weightlifting',
    'Mobility',
    'Hitting',
    'Pitching',
    'Private Lessons',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'APPROACH BASEBALL',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
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
              // Header
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

              // Horizontal training cards
              SizedBox(
                height: 135,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trainingCards.length,
                  itemBuilder: (context, index) {
                    return _trainingCard(trainingCards[index]);
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

              // Training list
              Expanded(
                child: ListView.builder(
                  itemCount: itemNames.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),

                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(_getIcon(index), color: Colors.white),
                        ),

                        title: Text(
                          itemNames[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),

                        subtitle: Text(
                          descriptions[index],
                          style: const TextStyle(color: Colors.black54),
                        ),

                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        ),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrainingDetailsPage(
                                trainingType: itemNames[index],
                              ),
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
      ),
    );
  }

  // White horizontal training card
  Widget _trainingCard(String label) {
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
            const Icon(Icons.sports_baseball, color: Colors.black, size: 38),

            const SizedBox(height: 10),

            Text(
              label,
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
  }

  // Different icon for each training option
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

class TrainingDetailsPage extends StatelessWidget {
  final String trainingType;

  const TrainingDetailsPage({super.key, required this.trainingType});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> exercises = {
      'Weightlifting': ['Squats', 'Bench Press', 'Deadlifts', 'Pull-Ups'],
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

    final List<String> currentExercises = exercises[trainingType] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(trainingType)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trainingType.toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Training Program',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Select an exercise or drill to learn more.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.builder(
                itemCount: currentExercises.length,
                itemBuilder: (context, index) {
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
                        currentExercises[index],
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailsPage(
                              trainingType: trainingType,
                              exerciseName: currentExercises[index],
                            ),
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
  final String trainingType;
  final String exerciseName;

  const ExerciseDetailsPage({
    super.key,
    required this.trainingType,
    required this.exerciseName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exerciseName)),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.sports_baseball, size: 70, color: Colors.white),

            const SizedBox(height: 25),

            Text(
              trainingType.toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              exerciseName,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
              'Practice $exerciseName to improve your '
              'baseball performance. Focus on proper '
              'technique, controlled movement, and consistency.',
              style: const TextStyle(fontSize: 17, height: 1.5),
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
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.black, size: 55),
            ),

            const SizedBox(height: 20),

            const Text(
              'Baseball Player',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              'Approach Baseball Member',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 35),

            _profileCard(Icons.fitness_center, 'Workouts Completed', '12'),

            _profileCard(Icons.sports_baseball, 'Training Focus', 'Hitting'),

            _profileCard(Icons.calendar_month, 'Lessons', '2 Upcoming'),
          ],
        ),
      ),
    );
  }

  Widget _profileCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 30),

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
