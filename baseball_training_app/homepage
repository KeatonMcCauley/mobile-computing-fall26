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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
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
                          child: Icon(
                            _getIcon(index),
                            color: Colors.white,
                          ),
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
                          // Add navigation here later.
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
            const Icon(
              Icons.sports_baseball,
              color: Colors.black,
              size: 38,
            ),

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