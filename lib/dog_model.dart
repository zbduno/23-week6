class Dog {
  String name;
  String age;

  Dog(this.name, this.age);

  get dogData {
    return '${name} ${age}\n';
  }
}
