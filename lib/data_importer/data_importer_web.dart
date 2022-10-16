import 'data_importer.dart';

class DataImporterWeb implements DataImporter {
  DataImporterWeb();

  String getValue(String text) {
    return 'DataImporterWeb: $text';
  }
}

DataImporter getDataImporter() => DataImporterWeb();
