class CarResponse {
  final String? idCar;
  final String? carName;
  final String? description;
  final String? origin;
  final String? specificationName;
  final Map<String, dynamic>? image;
  final Map<String, dynamic>? trailer;
  final String? paymentCurrency;
  final double? rate;
  final String? price;
  CarResponse({
    this.idCar,
    this.carName,
    this.description,
    this.origin,
    this.specificationName,
    this.image,
    this.rate,
    this.trailer,
    this.paymentCurrency,
    this.price,
  });

  factory CarResponse.fromJson(Map<String, dynamic> json) {
    return CarResponse(
      idCar: json['id'],
      carName: json['car_name'],
      description: json['description'],
      origin: json['origin'],
      specificationName: json['specification_name'],
      image: json['image'],
      trailer: json['trailer'],
      paymentCurrency: json['payment_currency'],
      rate: (json['rate'] as num?)?.toDouble(),
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idCar,
      'car_name': carName,
      'description': description,
      'origin': origin,
      'specification_name': specificationName,
      'image': image,
      'trailer': trailer,
      'rate': rate,
      'payment_currency': paymentCurrency,
      'price': price
    };
  }
}
