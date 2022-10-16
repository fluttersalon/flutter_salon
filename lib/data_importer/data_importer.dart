import 'data_importer_stub.dart'
// ignore: uri_does_not_exist
    if (dart.library.io) 'data_importer_app.dart'
// ignore: uri_does_not_exist
    if (dart.library.html) 'data_importer_web.dart';

abstract class DataImporter {
  String getValue(String text);

  factory DataImporter() => getDataImporter();
}
