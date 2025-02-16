import 'package:Aanya/utils/storage_constants.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage box = GetStorage();

  // to get user Session
  static dynamic getUserSession = box.read(StorageConstants.authKey);
}
