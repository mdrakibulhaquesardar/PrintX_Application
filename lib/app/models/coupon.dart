import 'package:nylo_framework/nylo_framework.dart';

class Coupon extends Model {
  static StorageKey key = "coupon";

  final int? id;
  final String? code;
  final String? discountType;
  final String? discountValue;
  final String? minOrderAmount;
  final String? maxDiscount;
  final int? usageLimit;
  final String? expiresAt;
  final String? createdAt;
  final String? updatedAt;

  Coupon({
    this.id,
    this.code,
    this.discountType,
    this.discountValue,
    this.minOrderAmount,
    this.maxDiscount,
    this.usageLimit,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  }) : super(key: key);

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      minOrderAmount: json['min_order_amount'],
      maxDiscount: json['max_discount'],
      usageLimit: json['usage_limit'],
      expiresAt: json['expires_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discount_type': discountType,
      'discount_value': discountValue,
      'min_order_amount': minOrderAmount,
      'max_discount': maxDiscount,
      'usage_limit': usageLimit,
      'expires_at': expiresAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

}