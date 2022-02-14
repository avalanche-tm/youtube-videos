class ShoppingItem {
  int id;
  String name;
  double price;
  String imageUrl;
  String description;
  ShoppingItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

List<ShoppingItem> getMockShoppingItems() {
  return [
    ShoppingItem(
      id: 1,
      name: 'Lightsaber',
      price: 200,
      imageUrl:
          'https://static.turbosquid.com/Preview/2015/11/28__08_19_48/LukeSkywalkerLightsaber3dmodel02.jpg5099fd3c-58fd-4c2f-95b1-0124eae10089Large.jpg',
      description: 'Weapon of a Jedi',
    ),
    ShoppingItem(
      id: 2,
      name: 'Ring of Powah',
      price: 2000,
      imageUrl:
          'https://canary.contestimg.wish.com/api/webimage/58d87f21d4eba555708e8fdc-large.jpg?cache_buster=251bbd543a234746307808eebd8c0488',
      description: 'Sauron\'s ring | BUY NOW, PRECIOUS, BUY!',
    ),
    ShoppingItem(
      id: 3,
      name: 'Your Momma\'s underwear',
      price: 300,
      imageUrl:
          'https://static-01.daraz.com.bd/p/f002276cf9ef21480df896d48b7dfb59.jpg',
      description: 'Used panties',
    ),
  ];
}
