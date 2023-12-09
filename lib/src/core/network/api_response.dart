class ApiResponse {

  final int? id;
  final String? title;
  final String? price;
  final String? description;
  final String? imageUrl;

  const ApiResponse({
    this.id,
    this.title,
    this.price,
    this.description,
    this.imageUrl});


  factory ApiResponse.fromJson (Map<String, dynamic> json){
    return ApiResponse(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        imageUrl: json["image"]
    );
  }
}

