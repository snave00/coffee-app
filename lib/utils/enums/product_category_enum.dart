enum ProductCategoryEnum {
  all(name: 'all'),
  hotCoffee(name: 'hot_coffee'),
  icedCoffee(name: 'iced_coffee'),
  pasta(name: 'pasta'),
  bread(name: 'bread');

  final String name;

  const ProductCategoryEnum({required this.name});
}
