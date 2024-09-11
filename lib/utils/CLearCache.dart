import 'dart:io';
import 'package:path_provider/path_provider.dart';

/*
 * 计算清除缓存
 */
class ClearCache {

  ///加载缓存
  static Future<String> loadCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await ClearCache._getTotalSizeOfFilesInDir(tempDir);
      // tempDir.list(followLinks: false,recursive: true).listen((file){
      //     //打印每个缓存文件的路径
      //   print(file.path);
      // });
      return ClearCache._renderSize(value);
    } catch (err) {
      print(err);
    }
  }

  // 清理缓存
  static Future<bool> clearCache() async {
    //此处展示加载loading
    try {
      Directory tempDir = await getTemporaryDirectory();
      //删除缓存目录
      await ClearCache.delDir(tempDir);
      await ClearCache.loadCache();
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      //此处隐藏加载loading
    }
  }

  /// 递归方式 计算文件的大小
  static Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null)
          for (final FileSystemEntity child in children)
            total += await ClearCache._getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  ///递归方式删除目录
  static Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      print(e);
    }
  }

  /// 格式化文件大小
  static String _renderSize(double value) {
    if (null == value) {
      return '0';
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      // value = value / 1024;
      value = value / 8024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

}