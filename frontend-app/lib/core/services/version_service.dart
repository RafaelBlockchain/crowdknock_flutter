import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class VersionInfo {
  final String name;
  final String version;
  final String build;
  final String commit;
  final String description;
  final String environment;
  final String flutterVersion;

  VersionInfo({
    required this.name,
    required this.version,
    required this.build,
    required this.commit,
    required this.description,
    required this.environment,
    required this.flutterVersion,
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) {
    return VersionInfo(
      name: json['name'],
      version: json['version'],
      build: json['build'],
      commit: json['commit'],
      description: json['description'],
      environment: json['environment'],
      flutterVersion: json['flutter_version'],
    );
  }
}

class VersionService {
  static Future<VersionInfo> loadVersionInfo() async {
    final jsonString = await rootBundle.loadString('version.json');
    final jsonData = json.decode(jsonString);
    return VersionInfo.fromJson(jsonData);
  }
}
