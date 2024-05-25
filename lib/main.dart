import 'package:flutter/material.dart';
import 'models/student.dart';
import 'services/api_service.dart';

void main() {
  runApp(StudentListApp());
}

class StudentListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentListPage(),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late Future<List<Student>> futureStudents;

  @override
  void initState() {
    super.initState();
    futureStudents = ApiService().fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Center(
        child: FutureBuilder<List<Student>>(
          future: futureStudents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StudentList(students: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class StudentList extends StatelessWidget {
  final List<Student> students;

  StudentList({required this.students});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return StudentCard(student: students[index]);
      },
    );
  }
}

class StudentCard extends StatelessWidget {
  final Student student;

  StudentCard({required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(student.image),
              radius: 40,
            ),
            SizedBox(height: 10),
            Text(
              student.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text('ID: ${student.id}'),
            Text('Age: ${student.age}'),
            Text('Gender: ${student.gender}'),
            SizedBox(height: 5),
            Text(
              '${student.address.street}, ${student.address.city}, ${student.address.zip}, ${student.address.country}',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text('Email: ${student.email}'),
            Text('Phone: ${student.phone}'),
            SizedBox(height: 5),
            Text('Courses: ${student.courses.join(", ")}'),
            Text('GPA: ${student.gpa}'),
          ],
        ),
      ),
    );
  }
}
