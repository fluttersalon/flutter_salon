import 'data_importer.dart';

class DataImporterApp implements DataImporter {
  DataImporterApp();

  String getValue(String text) {
    return 'DataImporterApp: $text';
  }
}

DataImporter getDataImporter() => DataImporterApp();
