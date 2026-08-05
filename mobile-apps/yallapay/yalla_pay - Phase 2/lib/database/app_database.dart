import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:yalla_pay/database/address_dao.dart';
import 'package:yalla_pay/database/bank_account_dao.dart';
import 'package:yalla_pay/database/user_dao.dart';
import 'package:yalla_pay/model/address.dart';
import 'package:yalla_pay/model/bank_account.dart';
import 'package:yalla_pay/model/user.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [BankAccount, User, Address])
abstract class AppDatabase {
  UserDao get userDao;
  AddressDao get addressDao;
  BankAccountDao get bankAccountDao;
}