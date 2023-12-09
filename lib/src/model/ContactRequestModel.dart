class ContactRequestModel {
  final int? id;
  final String? title, price, description, imageUrl;

  const ContactRequestModel(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.imageUrl
      });

  factory ContactRequestModel.fromJson(Map<String, dynamic> json) {
    return ContactRequestModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        imageUrl: json["image"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "image": imageUrl
    };
  }

//
}
