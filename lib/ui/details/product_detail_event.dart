import 'package:flutter_kd/ui/event.dart';

abstract class ProductDetailEvent implements Event {
  factory ProductDetailEvent.addProductSuccess() => AddProductSuccessEvent();
  factory ProductDetailEvent.updateProductSuccess() => UpdateProductSuccessEvent();
}
class AddProductSuccessEvent implements ProductDetailEvent {  }

class UpdateProductSuccessEvent implements ProductDetailEvent {

}