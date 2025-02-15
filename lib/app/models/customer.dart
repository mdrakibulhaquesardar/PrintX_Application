import 'package:nylo_framework/nylo_framework.dart';

class Customer extends Model {
  static StorageKey key = "customer";

  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? studentId;
  final String? address;
  final int? totalOrders;
  final String? totalDue;
  final String? createdAt;
  final String? updatedAt;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.studentId,
    this.address,
    this.totalOrders,
    this.totalDue,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      studentId: json['student_id'],
      address: json['address'],
      totalOrders: json['total_orders'],
      totalDue: json['total_due'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'student_id': studentId,
      'address': address,
      'total_orders': totalOrders,
      'total_due': totalDue,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'Customer{id: $id, name: $name, email: $email, phone: $phone, studentId: $studentId, address: $address, totalOrders: $totalOrders, totalDue: $totalDue, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Customer &&
    runtimeType == other.runtimeType &&
    id == other.id &&
    name == other.name &&
    email == other.email &&
    phone == other.phone &&
    studentId == other.studentId &&
    address == other.address &&
    totalOrders == other.totalOrders &&
    totalDue == other.totalDue &&
    createdAt == other.createdAt &&
    updatedAt == other.updatedAt;
}