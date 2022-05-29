import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zen_player/modules/vendors/base_vendor.dart';
import 'package:zen_player/modules/vendors/youtube/youtube_vendor.dart';

enum VendorType { youtube }

class VendorFactory {
  static BaseVendor fromVendorType([VendorType type = VendorType.youtube]) {
    return YouTubeVendor(dotenv.env['GOOGLE_API_KEY'] ?? "");
  }
}
