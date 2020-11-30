import 'dart:io';
import 'dart:ui';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/database_service.dart';
import 'package:e_commerce_app/services/form_field_validation.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/widgets/category_choice_builder.dart';
import 'package:e_commerce_app/widgets/custom_textbox.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:e_commerce_app/widgets/image_upload_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

addEditProduct({
  BuildContext context,
  Product product,
  bool isEditing = false,
}) {
  print("Product passed: $product -- Is Editing: $isEditing");
  return showCupertinoModalBottomSheet(
    expand: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => AddEditProductBottomSheet(
      product: product,
      isEditing: isEditing,
    ),
  );
}

class AddEditProductBottomSheet extends StatefulWidget {
  const AddEditProductBottomSheet({Key key, this.product, this.isEditing})
      : super(key: key);
  final Product product;
  final bool isEditing;

  @override
  _AddEditProductBottomSheetState createState() =>
      _AddEditProductBottomSheetState();
}

class _AddEditProductBottomSheetState extends State<AddEditProductBottomSheet> {
  DatabaseService _dbService = DatabaseService();
  final List<String> errors = [];
  String name = "", description = "";
  double rating = 0.0, price = 0.0;
  bool isFavourite = false, isPopular = false;
  double height = 0;
  bool isEditing = false;

  final _formKey = GlobalKey<FormState>();

  List<String> _category = [];

  String addError(String error) {
    print("NEw Error: $error");
    setState(() {
      errors.add(error);
    });
    return error;
  }

  String removeError(error) {
    setState(() {
      errors.remove(error);
    });
    return error;
  }

  Function(S2MultiState<String>) onChange(state) {
    print(state.value);
    setState(() {
      _category = state.value;
    });
  }

  void Function(int) onDelete(i) {
    print(i);
    print(_category);
    setState(() {
      _category.remove(
        _category[i],
      );
    });
  }

  File _displayImage;
  List<dynamic> _otherImages = [];
  final picker = ImagePicker();
  List<Asset> _otherImagesAsset = List<Asset>();

  String _error;

  Future<void> getImage(ImageSource source) async {
    PickedFile selectedImage = await picker.getImage(source: source);

    setState(() {
      if (selectedImage != null) {
        isEditing = false;
        height = 200;
        _displayImage = File(selectedImage.path);
        _otherImages.insert(0, _displayImage);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> loadAssets() async {
    setState(() {
      _otherImagesAsset = List<Asset>();
      // height = 200;
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: _otherImagesAsset,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      isEditing = false;
      height = 200;
    });
    for (int i = 0; i < resultList.length; i++) {
      var path =
          await FlutterAbsolutePath.getAbsolutePath(resultList[i].identifier);
      File file = await getImageFileFromAsset(path);
      _otherImages.add(file);
      // print("File: $file");
    }
    setState(() {
      _otherImagesAsset = resultList;

      if (error == null) _error = 'No Error Dectected';
    });
  }

  Future _cropImage(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.red,
        ));

    setState(() {
      _displayImage = croppedImage ?? _displayImage;
    });
  }

  void _clearImage(image) {
    setState(() => _displayImage = null);
    setState(() => _otherImages.remove(image));
    if (_otherImages?.length == 0) {
      setState(() => height = 0);
    }
  }

  getImageFileFromAsset(String path) async {
    final File file = File(path);
    return file;
  }

  @override
  void initState() {
    super.initState();
    if (widget.product != null && widget.isEditing == true) {
      name = widget.product.name;
      description = widget.product.description;
      rating = widget.product.rating;
      price = widget.product.price;
      isFavourite = widget.product.isFavourite;
      isPopular = widget.product.isPopular;
      _category = widget.product.categories;
      _otherImages = widget.product.images;
      _otherImages.length > 0 ? height = 200 : height = 0;

      isEditing = widget.isEditing;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Category>>.value(
        value: _dbService.categories,
        catchError: (BuildContext context, Object obj) {
          print(
              "Hello, an error occurred  Add Product page in the category stream builder: $obj");
          return obj;
        },
        builder: (context, snapshot) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Material(
              color: Colors.transparent,
              child: Scaffold(
                backgroundColor: CupertinoTheme.of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(0.95),
                extendBodyBehindAppBar: true,
                appBar: appBar(context),
                body: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          buildAddEditProductForm(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  // showImageUploadForm(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     builder: (context) => Column(
  //       children: [
  //         SizedBox(height: 10),
  //         ImageUploadContainer(
  //           onTap: () {},
  //           caption: "Click here to Upload display image",
  //         ),
  //         SizedBox(height: 20.0),
  //         ImageUploadContainer(
  //           onTap: () {},
  //           caption: "Click here to Other images",
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildImagesGrid() {
    if (_otherImages != null || _otherImages != [])
      return GridView.count(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        crossAxisCount: 1,
        children: List.generate(_otherImages.length, (index) {
          final image = _otherImages[index];

          return Column(
            children: [
              Container(
                // color: Colors.red,
                width: 150,
                height: 100,
                child: image.runtimeType == String
                    ? Image.network(image)
                    : Image.file(image),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isEditing)
                    FlatButton(
                      child: Icon(Icons.crop),
                      onPressed: () => _cropImage(image),
                    ),
                  FlatButton(
                    child: Icon(Icons.delete),
                    onPressed: () => _clearImage(image),
                  ),
                ],
              )
            ],
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Form buildAddEditProductForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20.0),
          CustomTextFormField(
            initialValue: name,
            hintText: "Product Name",
            labelText: "Name",
            suffixIcon: "assets/icons/Discover.svg",
            isPasswordField: false,
            textFieldType: "text",
            onSaved: (value) {
              setState(() => name = value);
            },
            onChanged: (value) {
              FormFieldValidation(
                addError: addError,
                removeError: removeError,
                errors: errors,
              ).onChangedTextField(value, "others");
            },
            validator: (value) {
              FormFieldValidation(
                addError: addError,
                removeError: removeError,
                errors: errors,
              ).validateField(value, "others");
            },
          ),
          SizedBox(height: 10),
          Divider(height: 1),
          SizedBox(height: 10),
          CustomTextFormField(
            initialValue: description,
            hintText: "product description",
            labelText: "Description",
            suffixIcon: "assets/icons/receipt.svg",
            isPasswordField: false,
            textFieldType: "description",
            onSaved: (value) {
              setState(() => description = value);
            },
            onChanged: (value) {
              FormFieldValidation(
                addError: addError,
                removeError: removeError,
                errors: errors,
              ).onChangedTextField(value, "others");
            },
            validator: (value) {
              FormFieldValidation(
                addError: addError,
                removeError: removeError,
                errors: errors,
              ).validateField(value, "others");
            },
          ),
          SizedBox(height: 10),
          Divider(height: 1),
          SizedBox(height: 10),
          CustomTextFormField(
            initialValue: price.toString(),
            hintText: "Selling Price",
            labelText: "price",
            suffixIcon: "assets/icons/Cash.svg",
            isPasswordField: false,
            textFieldType: "number",
            onSaved: (value) {
              setState(() => price = double.parse(value));
            },
            onChanged: (value) {
              FormFieldValidation(
                addError: addError,
                removeError: removeError,
                errors: errors,
              ).onChangedTextField(value, "others");
            },
            validator: (value) {
              FormFieldValidation(
                addError: addError,
                removeError: removeError,
                errors: errors,
              ).validateField(value, "others");
            },
          ),
          SizedBox(height: 10),
          Divider(height: 1),
          SizedBox(height: 10),
          CustomTextFormField(
            initialValue: rating.toString(),
            hintText: "rating",
            labelText: "Rating",
            suffixIcon: "assets/icons/Star Icon.svg",
            isPasswordField: false,
            textFieldType: "number",
            onSaved: (value) {
              setState(() => rating = double.parse(value));
            },
            onChanged: (value) {
              FormFieldValidation(
                addError: addError,
                removeError: removeError,
                errors: errors,
              ).onChangedTextField(value, "others");
            },
            validator: (value) {
              FormFieldValidation(
                addError: addError,
                removeError: removeError,
                errors: errors,
              ).validateField(value, "others");
            },
          ),
          SizedBox(height: 10),
          Divider(height: 1),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isFavourite,
                    onChanged: (value) {
                      setState(() {
                        isFavourite = value;
                      });
                    },
                    activeColor: kPrimaryColor,
                  ),
                  Text("Add to Favourite"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPopular,
                    onChanged: (value) {
                      setState(() {
                        isPopular = value;
                      });
                    },
                    activeColor: kPrimaryColor,
                  ),
                  Text("Add to Popular"),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(height: 1),
          SizedBox(height: 10),
          SizedBox(height: 10),
          Divider(height: 1),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 5.0,
                  color: Colors.red[200],
                )
              ],
            ),
            child: Builder(
              builder: (BuildContext context) {
                final List<Category> categories =
                    Provider.of<List<Category>>(context);
                return categories != null
                    ? CategoryChoiceBuilder(
                        category: _category,
                        categories: categories,
                        // categories: _dbService.categories,
                        onChange: onChange,
                        onDelete: onDelete,
                      )
                    : Center(
                        child: LinearProgressIndicator(),
                      );
              },
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              ImageUploadContainer(
                onTap: () => getImage(ImageSource.gallery),
                caption:
                    "${widget.isEditing ? 'Update' : 'Upload'} display image",
              ),
              SizedBox(width: 0.0),
              ImageUploadContainer(
                onTap: () => loadAssets(),
                caption:
                    "${widget.isEditing ? 'Update' : 'Upload'} Other images",
              ),
            ]),
          ),
          // Center(child: Text('Error: $_error')),
          // Text("${_displayImage}"),
          SizedBox(height: 20.0),
          Container(
            height: height,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildImagesGrid(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          DefaultButton(
            text: widget.isEditing ? "Update" : "Save",
            onPressed: () async {
              if (_formKey.currentState.validate() && errors.length < 1) {
                _formKey.currentState.save();
                if (widget.isEditing) {
                  dynamic res = await _dbService.updateProduct(
                    Product(
                      id: widget.product.id,
                      name: name,
                      description: description,
                      price: price,
                      rating: rating,
                      isPopular: isPopular,
                      isFavourite: isFavourite,
                      images: _otherImages,
                      categories: _category,
                    ),
                  );
                } else {
                  dynamic res = await _dbService.addProduct(
                    Product(
                      name: name,
                      description: description,
                      price: price,
                      rating: rating,
                      isPopular: isPopular,
                      isFavourite: isFavourite,
                      images: _otherImages,
                      categories: _category,
                    ),
                  );
                }

                return true;
              } else {
                print("Field not valid");
                return false;
              }

              return true;
              // if (_formKey.currentState.validate() && errors.length < 1) {
              //   _formKey.currentState.save();

              // } else {
              //   print("Not valid");
              //   return false;
              // }
            },
          )
        ],
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 74),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: CupertinoTheme.of(context)
                .scaffoldBackgroundColor
                .withOpacity(0.8),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 18),
                      CircleAvatar(
                        child: Icon(widget.isEditing ? Icons.edit : Icons.add),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              widget.isEditing
                                  ? 'Edit Product'
                                  : 'Add new product to store',
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  ' ${widget.isEditing ? "Update" : "Fill out"} the fields below',
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .actionTextStyle
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                SizedBox(width: 2),
                                Icon(
                                  CupertinoIcons.right_chevron,
                                  size: 14,
                                  color:
                                      CupertinoTheme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 14),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                    ],
                  ),
                ),
                Divider(height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
