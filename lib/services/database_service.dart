import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/cloud_storage_service.dart';
import 'package:flutter/services.dart';

class DatabaseService {
  // Collection reference
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection("categories");

  // Future updateUserData() async{}

// Get and Convert Product List from Snapshot
  // List<Product> _productListSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs
  //       .map(
  //         (doc) => Product(
  //           name: doc.data()['name'] ?? "",
  //           images: List<String>.from(doc.data()['images']) ?? [""],
  //           price: (doc.data()['price']).toDouble() ?? 0.0,
  //           rating: (doc.data()['rating']).toDouble() ?? 0.0,
  //           description: doc.data()['description'] ?? "",
  //           categories: List<String>.from(doc.data()['categories']) ?? [""],
  //           isPopular: doc.data()['isPopular'] ?? false,
  //           isFavourite: doc.data()['isFavourite'] ?? false,
  //         ),
  //       )
  //       .toList();
  // }

  Stream<List<Product>> get products {
    return productCollection.snapshots().map(
          (QuerySnapshot snapshot) => snapshot.docs.map(
            (doc) {
              return Product.fromMap(doc.data(), doc.id);
            },
          ).toList(),
        );
  }

  Stream<List<Category>> get categories {
    return categoryCollection.snapshots().map(
          (QuerySnapshot snapshot) => snapshot.docs.map(
            (doc) {
              return Category.fromMap(
                doc.data(),
                doc.id,
              );
            },
          ).toList(),
        );
  }

  Future<CloudStorageResult> uploadImages({images, String name}) async {
    final _cloudStorageService = CloudStorageService();
    CloudStorageResult storageResult;

    storageResult = await _cloudStorageService.uploadImages(
      imageList: images,
      name: name,
    );
    return storageResult;
  }

  Future addProduct(Product product) async {
    print("Passed product Name: ${product.name}");

    CloudStorageResult storageResult =
        await uploadImages(images: product.images, name: product.name);

    product..images = storageResult.imageUrls;
    DocumentReference docRef = await productCollection.add(product.toMap());
    print("Doc Ref: $docRef");
    return docRef;
  }

  Future updateProduct(Product product) async {
    dynamic newImageUrls = [];
    for (var image in product.images) {
      if (image.runtimeType != String) {
        dynamic url = await uploadImages(images: [image], name: product.name);
        newImageUrls.addAll(url.imageUrls);
      } else {
        newImageUrls.add(image);
      }
    }

    product..images = newImageUrls;
    try {
      await productCollection.doc(product.id).update(product.toMap());
      return true;
    } catch (e) {
      if (e is PlatformException) return e.message;
      return false;
    }
  }

  Future deleteProduct(String productId) async {
    await productCollection.doc(productId).delete().then(
          (value) => print("Product $productId deleted"),
        );
    return true;
  }

  Future createCategory(Category category) async {
    print("Passed Categeory: $category");

    DocumentReference docRef = await categoryCollection.add(category.toMap());
    print("Category Ref: $docRef");
    return docRef;
  }

  Future deleteCategory(String docId) async {
    print("ID to deleted: $docId");
    await categoryCollection.doc(docId).delete().then((value) {
      print("$docId deleted");
    });
    return true;
  }
}
