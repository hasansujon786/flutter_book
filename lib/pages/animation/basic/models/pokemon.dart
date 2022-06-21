class PokemonData {
  final String id;
  final String name;
  final int age;
  final int power;

  PokemonData({required this.id, required this.name, required this.age, required this.power});
}

final pokemonsData = [
  PokemonData(id: '0', name: 'Pikachu', age: 5, power: 5),
  PokemonData(id: '1', name: 'Charizard', age: 12, power: 9),
  PokemonData(id: '2', name: 'Bulbasaur', age: 3, power: 9),
];
