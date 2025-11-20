class MenuModel {
  final String name;
  final String image;
  final int price;
  final String description;
  final String category;
  final bool isRecommended;

  MenuModel({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
    this.isRecommended = false,
  });
}
