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
  //not part of assignment checking to be sure its running correctly
  Student student = Student("Keaton",100,[100.0, 83.5, 95.2] );
  print(student.calculateGPA());
}