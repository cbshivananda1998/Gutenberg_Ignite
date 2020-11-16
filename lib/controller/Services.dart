
import 'package:get/get.dart';
import 'package:ignite_practice/model/allbooks.dart';
import 'package:http/http.dart' as http;

class Service extends GetxController {
  var allFetchedBooks = allBooks().obs;
  var validBooks = allBooks().obs;
  var allBooksList = List<Book>().obs;
  RxInt size = 0.obs;
  var loading = true.obs;
  var page1Complete = false.obs;
  var searched = false.obs;
  var newSearchInput="".obs;
  @override
  void onClose() {
    allFetchedBooks = allBooks().obs;
    validBooks = allBooks().obs;
    allBooksList = List<Book>().obs;
    size.value = 0;
    page1Complete.value = false;
    searched.value=false;
    super.onClose();
  }

  Future<allBooks> fetchAllBooks(String category, String searchInput) async {
    try {
      if (page1Complete.value == false) {
        final response = await http.get(
            "http://skunkworks.ignitesol.com:8000/books/?topic=$category&search=$searchInput");
        if (response.statusCode == 200) {
          final allBooks books = booksFromJson(response.body);

          return books;
        }
      } else {
        final response = await http.get(allFetchedBooks.value.nextPage);
        if (response.statusCode == 200) {
          final allBooks books = booksFromJson(response.body);
          return books;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void getValidBooks(String category, String searchInput) async{

    if (searched.value == true) {
      allFetchedBooks = allBooks().obs;
      validBooks = allBooks().obs;
      allBooksList = List<Book>().obs;
      size.value = 0;
      page1Complete.value = false;
      searched.value=false;
    }
    await fetchAllBooks(category, searchInput).then((newbooks) {
      RxList<Book> newFictionBooks = new RxList<Book>();
      allFetchedBooks.value.books = newbooks.books;
      allFetchedBooks.value.nextPage = newbooks.nextPage;
      page1Complete.value = true;
      allFetchedBooks.value.books.forEach((element) {
        if (element.formats.imageJpeg != null) {
          if (!newFictionBooks.contains(element)) {
            String s=element.authors[0].name;
            List<String> name = s.split(",");
            String newName="";
            for(int i=name.length-1;i>=0;i--){
              newName+=name[i]+" ";
            }
            element.newAuthor=newName ;
            newFictionBooks.add(element);
          }
        }
      });
      allBooksList = newFictionBooks;

      if (validBooks.value.books == null) {
        validBooks.value.books = allBooksList;
      } else {
        validBooks.value.books.addAll(allBooksList);
      }
      size.value = validBooks.value.books.length;


      loading.value = false;
      if (size.value < 15) {
        getValidBooks(category, searchInput);
      }
    });
  }

  String getViewUrl(int index) {
    if (validBooks.value.books[index].formats.textHtmlCharsetUtf8 != null &&
        !validBooks.value.books[index].formats.textHtmlCharsetUtf8
            .contains("zip")) {
      return validBooks.value.books[index].formats.textHtmlCharsetUtf8;
    } else if (validBooks.value.books[index].formats.textHtmlCharsetUsAscii !=
            null &&
        !validBooks.value.books[index].formats.textHtmlCharsetUsAscii
            .contains("zip")) {
      return validBooks.value.books[index].formats.textHtmlCharsetUsAscii;
    } else if (validBooks.value.books[index].formats.textHtmlCharsetIso88591 !=
            null &&
        !validBooks.value.books[index].formats.textHtmlCharsetIso88591
            .contains("zip")) {
      return validBooks.value.books[index].formats.textHtmlCharsetIso88591;
    } else if (validBooks.value.books[index].formats.applicationPdf != null &&
        !validBooks.value.books[index].formats.applicationPdf.contains("zip")) {
      return validBooks.value.books[index].formats.applicationPdf;
    } else if (validBooks.value.books[index].formats.textPlain != null &&
        !validBooks.value.books[index].formats.textPlain.contains("zip")) {
      return validBooks.value.books[index].formats.textPlain;
    } else if (validBooks.value.books[index].formats.textPlainCharsetUtf8 !=
            null &&
        !validBooks.value.books[index].formats.textPlainCharsetUtf8
            .contains("zip")) {
      return validBooks.value.books[index].formats.textPlainCharsetUtf8;
    } else if (validBooks.value.books[index].formats.textPlainCharsetIso88591 !=
            null &&
        !validBooks.value.books[index].formats.textPlainCharsetIso88591
            .contains("zip")) {
      return validBooks.value.books[index].formats.textPlainCharsetIso88591;
    } else if (validBooks.value.books[index].formats.textPlainCharsetUsAscii !=
            null &&
        !validBooks.value.books[index].formats.textPlainCharsetUsAscii
            .contains("zip")) {
      return validBooks.value.books[index].formats.textPlainCharsetUsAscii;
    } else {
      return null;
    }
  }
}
