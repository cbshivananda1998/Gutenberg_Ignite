
import 'dart:convert';

allBooks booksFromJson(String str) => allBooks.fromJson(json.decode(str));

String booksToJson(allBooks data) => json.encode(data.toJson());

class allBooks {
  allBooks({
    this.nextPage = null,
    this.books = null,
  });

  String nextPage;
  List<Book> books;

  factory allBooks.fromJson(Map<String, dynamic> json) => allBooks(
    nextPage: json["next"],
    books: List<Book>.from(json["results"].map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next": nextPage,
    "results": List<dynamic>.from(books.map((x) => x.toJson())),
  };
}

class Book {
  Book({
    this.id=null,
    this.authors=null,
    this.bookshelves=null,
    this.formats=null,
    this.languages=null,
    this.mediaType=null,
    this.subjects=null,
    this.title=null,
    this.newAuthor=null
  });

  int id;
  List<Author> authors;
  List<String> bookshelves;
  Formats formats;
  List<String> languages;
  String mediaType;
  List<String> subjects;
  String title;
  String newAuthor;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
    bookshelves: List<String>.from(json["bookshelves"].map((x) => x)),
    formats: Formats.fromJson(json["formats"]),
    languages: List<String>.from(json["languages"].map((x) => x)),
    mediaType: json["media_type"],
    subjects: List<String>.from(json["subjects"].map((x) => x)),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
    "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
    "formats": formats.toJson(),
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "media_type": mediaType,
    "subjects": List<dynamic>.from(subjects.map((x) => x)),
    "title": title,
  };
}

class Author {
  Author({
    this.birthYear,
    this.deathYear,
    this.name,
  });

  int birthYear;
  int deathYear;
  String name;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    birthYear: json["birth_year"],
    deathYear: json["death_year"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "birth_year": birthYear,
    "death_year": deathYear,
    "name": name,
  };
}
//
// class Formats {
//   Formats({
//     this.applicationXMobipocketEbook,
//     this.applicationPdf,
//     this.textPlainCharsetUsAscii,
//     this.textPlainCharsetUtf8,
//     this.applicationRdfXml,
//     this.applicationZip,
//     this.applicationEpubZip,
//     this.textHtmlCharsetUtf8,
//   });
//
//   String applicationXMobipocketEbook;
//   String applicationPdf;
//   String textPlainCharsetUsAscii;
//   String textPlainCharsetUtf8;
//   String applicationRdfXml;
//   String applicationZip;
//   String applicationEpubZip;
//   String textHtmlCharsetUtf8;
//
//   factory Formats.fromJson(Map<String, dynamic> json) => Formats(
//     applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
//     applicationPdf: json["application/pdf"],
//     textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"],
//     textPlainCharsetUtf8: json["text/plain; charset=utf-8"],
//     applicationRdfXml: json["application/rdf+xml"],
//     applicationZip: json["application/zip"],
//     applicationEpubZip: json["application/epub+zip"],
//     textHtmlCharsetUtf8: json["text/html; charset=utf-8"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "application/x-mobipocket-ebook": applicationXMobipocketEbook,
//     "application/pdf": applicationPdf,
//     "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
//     "text/plain; charset=utf-8": textPlainCharsetUtf8,
//     "application/rdf+xml": applicationRdfXml,
//     "application/zip": applicationZip,
//     "application/epub+zip": applicationEpubZip,
//     "text/html; charset=utf-8": textHtmlCharsetUtf8,
//   };
// }
class Formats {
  Formats({
    this.applicationXMobipocketEbook=null,
    this.applicationPdf=null,
    this.textPlainCharsetUsAscii=null,
    this.textPlainCharsetUtf8=null,
    this.applicationRdfXml=null,
    this.applicationZip=null,
    this.applicationEpubZip=null,
    this.textHtmlCharsetUtf8=null,
    this.textPlainCharsetIso88591=null,
    this.imageJpeg=null,
    this.textPlain=null,
    this.textHtmlCharsetUsAscii=null,
    this.textHtml=null,
    this.textRtf=null,
    this.textHtmlCharsetIso88591=null,
    this.applicationPrsTex=null,
  });

  String applicationXMobipocketEbook;
  String applicationPdf;
  String textPlainCharsetUsAscii;
  String textPlainCharsetUtf8;
  String applicationRdfXml;
  String applicationZip;
  String applicationEpubZip;
  String textHtmlCharsetUtf8;
  String textPlainCharsetIso88591;
  String imageJpeg;
  String textPlain;
  String textHtmlCharsetUsAscii;
  String textHtml;
  String textRtf;
  String textHtmlCharsetIso88591;
  String applicationPrsTex;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
    applicationXMobipocketEbook: json["application/x-mobipocket-ebook"] == null ? null : json["application/x-mobipocket-ebook"],
    applicationPdf: json["application/pdf"] == null ? null : json["application/pdf"],
    textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"] == null ? null : json["text/plain; charset=us-ascii"],
    textPlainCharsetUtf8: json["text/plain; charset=utf-8"] == null ? null : json["text/plain; charset=utf-8"],
    applicationRdfXml: json["application/rdf+xml"],
    applicationZip: json["application/zip"] == null ? null : json["application/zip"],
    applicationEpubZip: json["application/epub+zip"] == null ? null : json["application/epub+zip"],
    textHtmlCharsetUtf8: json["text/html; charset=utf-8"] == null ? null : json["text/html; charset=utf-8"],
    textPlainCharsetIso88591: json["text/plain; charset=iso-8859-1"] == null ? null : json["text/plain; charset=iso-8859-1"],
    imageJpeg: json["image/jpeg"] == null ? null : json["image/jpeg"],
    textPlain: json["text/plain"] == null ? null : json["text/plain"],
    textHtmlCharsetUsAscii: json["text/html; charset=us-ascii"] == null ? null : json["text/html; charset=us-ascii"],
    textHtml: json["text/html"] == null ? null : json["text/html"],
    textRtf: json["text/rtf"] == null ? null : json["text/rtf"],
    textHtmlCharsetIso88591: json["text/html; charset=iso-8859-1"] == null ? null : json["text/html; charset=iso-8859-1"],
    applicationPrsTex: json["application/prs.tex"] == null ? null : json["application/prs.tex"],
  );

  Map<String, dynamic> toJson() => {
    "application/x-mobipocket-ebook": applicationXMobipocketEbook == null ? null : applicationXMobipocketEbook,
    "application/pdf": applicationPdf == null ? null : applicationPdf,
    "text/plain; charset=us-ascii": textPlainCharsetUsAscii == null ? null : textPlainCharsetUsAscii,
    "text/plain; charset=utf-8": textPlainCharsetUtf8 == null ? null : textPlainCharsetUtf8,
    "application/rdf+xml": applicationRdfXml,
    "application/zip": applicationZip == null ? null : applicationZip,
    "application/epub+zip": applicationEpubZip == null ? null : applicationEpubZip,
    "text/html; charset=utf-8": textHtmlCharsetUtf8 == null ? null : textHtmlCharsetUtf8,
    "text/plain; charset=iso-8859-1": textPlainCharsetIso88591 == null ? null : textPlainCharsetIso88591,
    "image/jpeg": imageJpeg == null ? null : imageJpeg,
    "text/plain": textPlain == null ? null : textPlain,
    "text/html; charset=us-ascii": textHtmlCharsetUsAscii == null ? null : textHtmlCharsetUsAscii,
    "text/html": textHtml == null ? null : textHtml,
    "text/rtf": textRtf == null ? null : textRtf,
    "text/html; charset=iso-8859-1": textHtmlCharsetIso88591 == null ? null : textHtmlCharsetIso88591,
    "application/prs.tex": applicationPrsTex == null ? null : applicationPrsTex,
  };
}