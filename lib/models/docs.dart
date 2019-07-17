import 'package:json_annotation/json_annotation.dart';

part 'docs.g.dart';

// {
//   id: 83,
//   document_id: 981,
//   document_type: "article",
//   url: "https://example.com/articles/981",
//   title: "My Title 2",
//   explain: "",
//   date: "2019-07-17",
//   subtype: "記事",
//   image: "https://s3.ap-northeast-1.amazonaws.com/example.com/document/article/981/thumb_20190716235223.jpg",
//   picks: [
//     {
//       comment: "",
//       document: {
//         id: 83,
//         document_id: 981,
//         document_type: "article",
//         url: "https://example.com/articles/981",
//         title: "My Title",
//         explain: "",
//         date: "2019-07-17",
//         subtype: "記事",
//         image: "https://s3.ap-northeast-1.amazonaws.com/example.com/document/article/981/thumb_20190716235223.jpg"
//       },
//       account: {
//         id: 5728,
//         user: 5729,
//         name: "My Name",
//         company: "example company",
//         position: "",
//         bio: "",
//         icon: "https://s3.ap-northeast-1.amazonaws.com/example.com/account/3385472856a37b7d9183ca93f8b035f8/IMG_1666.jpg",
//         tags: ["my", "tag"],
//         thumb: "https://s3.ap-northeast-1.amazonaws.com/example.com/CACHE/images/account/3385472856a37b7d9183ca93f8b035f8/IMG_1666.f08d32efdf5d.jpg",
//         link: "https://localhost:8000/u/5729",
//         company_link: "http://localhost:9000/companies/1?page=person-profile&location=company-link"
//       }
//     }
//   ]
// }

@JsonSerializable()
class DocsModel {
  List<DocsAttr> data;

  DocsModel(this.data);

  factory DocsModel.fromJson(Map<String, dynamic> json) =>
      _$DocsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocsModelToJson(this);
}

@JsonSerializable()
class DocsAttr {
  @JsonKey(nullable: false)
  int id;

  @JsonKey(name: 'document_id', nullable: false)
  int documentId;

  @JsonKey(name: 'document_type', nullable: false)
  String documentType;

  @JsonKey(nullable: false)
  Uri url;

  @JsonKey(nullable: false)
  String title;

  @JsonKey(nullable: true)
  String explain;

  @JsonKey(nullable: false)
  DateTime date;

  @JsonKey(nullable: true)
  String subtype;

  @JsonKey(nullable: false)
  Uri image;

  DocsAttr(this.id, this.documentId, this.documentType, this.url, this.title,
      this.explain, this.date, this.subtype, this.image);

  factory DocsAttr.fromJson(Map<String, dynamic> json) =>
      _$DocsAttrFromJson(json);

  Map<String, dynamic> toJson() => _$DocsAttrToJson(this);
}
