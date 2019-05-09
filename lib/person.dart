class Person {
  String firstName;
  String fullName;

  Person.fromSnapshot(document) {
    this.firstName = document['first_name'];
  }

  @override
  String toString() {
    return 'First Name: $firstName';
  }
}
