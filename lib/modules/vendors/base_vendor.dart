import 'package:zen_player/modules/vendors/video.dart';abstract class BaseVendor {  final String? secret;  BaseVendor(this.secret);  Future<List<Video>> search(String keyword);}