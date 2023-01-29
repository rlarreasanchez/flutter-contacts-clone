class ContactModel {
  final String imgUrl;
  final String name;
  final bool? favorite;

  ContactModel({
    required this.imgUrl,
    required this.name,
    this.favorite = false,
  }) : super();
}
