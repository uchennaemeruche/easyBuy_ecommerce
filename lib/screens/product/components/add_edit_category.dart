import 'dart:ui';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/database_service.dart';

import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

addEditCategory({BuildContext context, Product product}) {
  print("Product passed: $product");
  return showCupertinoModalBottomSheet(
    expand: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => AddProductCategory(product: product),
  );
}

class AddProductCategory extends StatefulWidget {
  const AddProductCategory({Key key, this.product}) : super(key: key);
  final Product product;

  @override
  _AddProductCategoryState createState() => _AddProductCategoryState();
}

class _AddProductCategoryState extends State<AddProductCategory> {
  DatabaseService _dbService = DatabaseService();
  String catName = "";
  final _formKey = GlobalKey<FormState>();

  List<String> _category = [];

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

  bool _isError = false;
  String _error = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Category>>.value(
        value: DatabaseService().categories,
        catchError: (BuildContext context, Object obj) {
          print(
              "Hello, an error occurred in the category stream builder: $obj");
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // buildAddEditProductForm(context),
                          SizedBox(height: 20),
                          CategoryCard()
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

  Form buildAddCategoryForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        onSaved: (value) {
          print("value: $value");
          setState(() => catName = value);
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              _error = "";
              _isError = false;
            });
          }
        },
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _error = "Empty Field not allowed";
              _isError = true;
            });
            return _error;
          } else {
            setState(() {
              _error = "";
              _isError = false;
            });
            return _error;
          }
        },
        decoration: InputDecoration(
          errorText: _error,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: kTextColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: kTextColor),
          ),
          contentPadding: EdgeInsets.only(left: 40.0),
          // labelText: "Enter category name",
          labelStyle: TextStyle(),
          hintText: "Enter Category name",
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: InkWell(
              child: Container(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(15.0),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Plus Icon.svg",
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                _formKey.currentState.validate();
                FormState form = _formKey.currentState;
                form.save();

                dynamic res = await _dbService.createCategory(
                  Category(
                    name: catName,
                  ),
                );
              }),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 150),
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
                        child: Icon(Icons.add),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Product Category Management',
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
                                  'Fill out the fields below',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: buildAddCategoryForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _selected = false, _isReadOnly = true;
  DatabaseService _dbService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    final List<Category> categories = Provider.of<List<Category>>(context);

    return Wrap(
      children: [
        if (categories != null)
          ...List.generate(
            categories.length,
            (index) => Container(
              width: 180,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
              child: InputChip(
                selected: _selected,
                label: TextFormField(
                  onTap: () {},
                  initialValue: categories[index].name,
                  readOnly: categories[index].isReadOnly,
                  autocorrect: false,
                  scrollPadding: EdgeInsets.all(10.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                  ),
                ),
                avatar: CircleAvatar(
                  child: Icon(Icons.edit),
                ),
                deleteIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () async {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sure to delete??"),
                              Text("Yes"),
                            ],
                          ),
                          backgroundColor: Colors.grey,
                          duration: Duration(seconds: 120),
                          action: SnackBarAction(
                            label: "No",
                            textColor: Colors.green,
                            onPressed: () {},
                          ),
                        ),
                      );
                      // await _dbService.deleteCategory(categories[index].id);
                    }),
                padding: EdgeInsets.only(right: 0.0),
                tooltip: 'Click to delete or edit',
                onDeleted: () {
                  print("Deleted");
                },
              ),
            ),
          )
        else
          Text("Loading...")
      ],
    );
  }
}

// ...List.generate(
//           categories.length,
//           (index) =>
//         )
