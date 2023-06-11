import 'package:equatable/equatable.dart';

import '../utils/parser_util.dart';

class PhotoModel extends Equatable {
  final String? url;
  final String? title;
  final String? description;
  final String? authorName;
  final String? authorImage;
  final String? authorBio;
  final bool? availbleForHire;

  const PhotoModel(
      {this.url,
      this.title,
      this.description,
      this.authorName,
      this.authorImage,
      this.authorBio,
      this.availbleForHire});

  factory PhotoModel.fromJson(Map json) {
    Map<String, dynamic> innerjson = Map<String, dynamic>.from(json);

    return PhotoModel(
      authorName: ParserUtil.parseJsonString(innerjson["user"], "name"),
      authorBio: ParserUtil.parseJsonString(innerjson["user"], "bio"),
      availbleForHire:
          ParserUtil.parseJsonBoolean(innerjson["user"], "for_hire"),
      authorImage: ParserUtil.parseJsonString(
          innerjson["user"]["profile_image"], "medium"),
      url: ParserUtil.parseJsonString(innerjson["urls"], "regular"),
      description: ParserUtil.parseJsonString(innerjson, "description"),
    );
  }

  @override
  List<Object?> get props => [
        url,
        title,
        description,
        authorName,
        authorImage,
        authorBio,
        availbleForHire,
      ];
}
