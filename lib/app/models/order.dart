import 'package:nylo_framework/nylo_framework.dart';

class Order extends Model {
  static StorageKey key = "order";

  final int? id;
  final int? customerId;
  final int? productId;
  final String? customPdfUrl;
  final int? pageCount;
  final String? totalPrice;
  final String? status;
  final String? color;
  final int? couponId;
  final String? discountApplied;
  final String? note;
  final String? createdAt;
  final String? updatedAt;

  Order({
    this.id,
    this.customerId,
    this.productId,
    this.customPdfUrl,
    this.pageCount,
    this.totalPrice,
    this.status,
    this.color,
    this.couponId,
    this.discountApplied,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      productId: json['product_id'],
      customPdfUrl: json['custom_pdf_url'],
      pageCount: json['page_count'],
      totalPrice: json['total_price'],
      status: json['status'],
      color: json['color'],
      couponId: json['coupon_id'],
      discountApplied: json['discount_applied'],
      note: json['note'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'product_id': productId,
      'custom_pdf_url': customPdfUrl,
      'page_count': pageCount,
      'total_price': totalPrice,
      'status': status,
      'color': color,
      'coupon_id': couponId,
      'discount_applied': discountApplied,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'Order{id: $id, customerId: $customerId, productId: $productId, customPdfUrl: $customPdfUrl, pageCount: $pageCount, totalPrice: $totalPrice, status: $status, color: $color, couponId: $couponId, discountApplied: $discountApplied, note: $note, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Order &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    customerId == other.customerId &&
    productId == other.productId &&
    customPdfUrl == other.customPdfUrl &&
    pageCount == other.pageCount &&
    totalPrice == other.totalPrice &&
    status == other.status &&
    color == other.color &&
    couponId == other.couponId &&
    discountApplied == other.discountApplied &&
    note == other.note &&
    createdAt == other.createdAt &&
    updatedAt == other.updatedAt;
}