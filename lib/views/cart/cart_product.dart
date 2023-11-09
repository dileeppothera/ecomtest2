import 'package:hive/hive.dart';
part 'cart_product.g.dart';

@HiveType(typeId: 0)
class CartProduct extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;
  @HiveField(4)
  int? price;
  @HiveField(5)
  int? count;

  Map<String, dynamic> toJson() => {
        "product_id": id.toString(),
        "quantity": count.toString(),
        "price": price.toString(),
      };
}
