import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
  
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
 
  final List<String> _descriptions = ['Full body workout', 'Bacon and a biscuit', 'Building a homepage','Creating topics', 'Hitting'];
  final List<String> _itemName = ['Weightlifting', 'Breakfast', 'Mobile Computing','Writing Class', 'Practice'];


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Demo Home Page')),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to my Page', style: TextStyle(fontSize: 16)),
              Text(
                'Keatons Schedule',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [_card('Weight Lifting'),                                 _card('Breakfast'),_card('Mobile                                     Computing'),_card('Writing                                           Class'),_card('Practice')]
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    
                    return ListTile(
                      title: Text(_itemName[index]),
                      
                      subtitle: Text(_descriptions[index]),
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

  Widget _card(String label) => Container(
    width: 120,
    margin: EdgeInsets.all(8),
    color: Colors.deepPurple.shade50,
    child: Center(child: Text(label)),
  );
}

 



  



