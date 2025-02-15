import 'package:nylo_framework/nylo_framework.dart';

class Product extends Model {
  static StorageKey key = "product";

  final int? id;
  final String? title;
  final String? description;
  final String? fileUrl;
  final String? pricePerPage;
  final String? createdAt;
  final String? updatedAt;

  Product({
    this.id,
    this.title,
    this.description,
    this.fileUrl,
    this.pricePerPage,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      fileUrl: json['file_url'],
      pricePerPage: json['price_per_page'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'file_url': fileUrl,
      'price_per_page': pricePerPage,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, title: $title, description: $description, fileUrl: $fileUrl, pricePerPage: $pricePerPage, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Product &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    title == other.title &&
    description == other.description &&
    fileUrl == other.fileUrl &&
    pricePerPage == other.pricePerPage &&
    createdAt == other.createdAt &&
    updatedAt == other.updatedAt;
}