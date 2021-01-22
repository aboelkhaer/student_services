import 'package:flutter/material.dart';
import 'package:student_services/models/book_model.dart';
import 'package:student_services/screens/details/book_details.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';

Widget singleBook(context, Book book) {
  Size _size = MediaQuery.of(context).size;
  return Stack(
    children: [
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BookDetails(
                  book: book,
                );
              },
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(16),
          width: _size.width * 0.3,
          height: _size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
            // image: DecorationImage(
            //   image: NetworkImage(
            //     book.bookImageUrl == null
            //         ? 'https://i.pinimg.com/236x/c6/e1/ce/c6e1cef909c51f9d4f134c0817ec0c6e.jpg'
            //         : book.bookImageUrl,
            //   ),
            //   fit: BoxFit.cover,
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Image.network(
            book.bookImageUrl == null || book.bookImageUrl == ''
                ? 'https://i.pinimg.com/236x/c6/e1/ce/c6e1cef909c51f9d4f134c0817ec0c6e.jpg'
                : book.bookImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Container();
            },
          ),
        ),
      ),
      Positioned(
          bottom: 30,
          left: 15,
          child: Column(
            children: [
              Container(
                width: _size.width * 0.16,
                height: _size.height * 0.033,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                alignment: Alignment.center,
                child: MyText(
                  text: book.level,
                  color: Colors.white,
                  size: 14,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: _size.width * 0.16,
                height: _size.height * 0.033,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                alignment: Alignment.center,
                child: MyText(
                  text: book.term,
                  color: Colors.white,
                  size: 14,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          )),
    ],
  );
}

// Widget bookList(BuildContext context, Book book, Users users) {
//   Query myBooks = StudentServicesApp.firebaseFirestore
//       .collection('books')
//       .where('userUID', isEqualTo: users.id)
//       .orderBy('time', descending: true);

//   Size size = MediaQuery.of(context).size;
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             MyText(
//               text: 'Books',
//               size: 19,
//               weight: FontWeight.w500,
//             ),
//             Icon(
//               Icons.arrow_forward,
//               size: 25,
//             ),
//           ],
//         ),
//       ),
//       StreamBuilder<QuerySnapshot>(
//           stream: myBooks.snapshots(),
//           builder: (context, snapshot) {
//             return Container(
//               height: size.height * 0.3,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: snapshot.data.docs.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   Book book = Book.fromJson(snapshot.data.docs[index].data());
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.data == null) return CircularProgressIndicator();
//                   if (snapshot.hasError) {
//                     return Center(
//                       child: Text('Some thing went error.'),
//                     );
//                   }
//                   if (snapshot.hasData) {
//                     return singleBook(context, book);
//                   } else {
//                     return Center(
//                       child: Text('No Books Yet.'),
//                     );
//                   }
//                 },
//               ),
//             );
//           }),
//     ],
//   );
// }
