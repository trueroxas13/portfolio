import 'dart:async';

import 'package:floor/floor.dart';
import 'package:streamvault/database/movie_dao.dart';
import 'package:streamvault/database/platform_dao.dart';
import 'package:streamvault/model/movie.dart';
import 'package:streamvault/model/platform.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:streamvault/model/platform_summary_view.dart';

part 'app_database.g.dart';
@Database(
  version: 1,
  entities: [
    Movie,
    Platform,
  ],
  views: [
    PlatformSummaryView
  ]
)
abstract class AppDatabase extends FloorDatabase{
  MovieDao get movieDao;
  PlatformDao get platformDao;
}
