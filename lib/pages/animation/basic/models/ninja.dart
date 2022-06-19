class Ninja {
  final String id;
  final String name;
  final int age;
  final int power;

  Ninja({required this.id, required this.name, required this.age, required this.power});
}

final ninjas = [
  Ninja(id: '0', name: 'Samuel', age: 22, power: 8),
  Ninja(id: '1', name: 'Jakson', age: 18, power: 5),
  Ninja(id: '2', name: 'Mr. Red', age: 33, power: 9),
];
