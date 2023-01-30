class ContactModel {
  final int id;
  final String imgUrl;
  final String name;
  final bool? favorite;

  ContactModel({
    required this.id,
    required this.imgUrl,
    required this.name,
    this.favorite = false,
  }) : super();
}
