const FOOD_DATA = [
  {
    "name":"Burger",
    "brand":"Hawkers",
    "price":2.99,
    "image":"burger.png"
  },{
    "name":"Cheese Dip",
    "brand":"Hawkers",
    "price":4.99,
    "image":"cheese_dip.png"
  },
  {
    "name":"Cola",
    "brand":"Mcdonald",
    "price":1.49,
    "image":"cola.png"
  },
  {
    "name":"Fries",
    "brand":"Mcdonald",
    "price":2.99,
    "image":"fries.png"
  },
  {
    "name":"Ice Cream",
    "brand":"Ben & Jerry's",
    "price":9.49,
    "image":"ice_cream.png"
  },
  {
    "name":"Noodles",
    "brand":"Hawkers",
    "price":4.49,
    "image":"noodles.png"
  },
  {
    "name":"Pizza",
    "brand":"Dominos",
    "price":17.99,
    "image":"pizza.png"
  },
  {
    "name":"Sandwich",
    "brand":"Hawkers",
    "price":2.99,
    "image":"sandwich.png"
  },
  {
    "name":"Wrap",
    "brand":"Subway",
    "price":6.99,
    "image":"wrap.png"
  }
];

class FoodData {
  const FoodData(this.name, this.price, this.brand, this.image);

  final String name;
  final double price;
  final String brand;
  final String image;
}
