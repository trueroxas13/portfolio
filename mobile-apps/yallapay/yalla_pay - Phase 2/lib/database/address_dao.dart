import 'package:floor/floor.dart';
import 'package:yalla_pay/model/address.dart';

@dao
abstract class AddressDao {
  @Query('SELECT * FROM address')
  Stream<List<Address>> observeAddress();

  @insert
  Future<void> addAddress(Address address);

  @delete
  Future<void> deleteAddress(Address address);

  @update
  Future<void> updateAddress(Address address); 
}