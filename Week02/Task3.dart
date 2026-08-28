class Student {
  // fields: name, id, grades
  String name;
  int id;
  List<double> grades ;

  // constructor
  Student(this.name,this.id, this.grades);

  double calculateGPA() {
    // return the average of grades
    return grades.reduce((a, b) => a + b) / grades.length;
  }
}
void main(){
  var students = [
    Student('Keaton', 100, [4.0, 2.6, 3.9]),
    Student('Sam', 101, [3.2, 2.1, 4.0]),
  ];

  for (var s in students) {
    print('${s.name}: ${s.calculateGPA()}');
  }
}