import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class CategoryChoiceBuilder extends StatelessWidget {
  List<String> category;
  List<Category> categories;
  Function(S2MultiState<String>) onChange;
  void Function(int) onDelete;

  CategoryChoiceBuilder(
      {Key key, this.category, this.categories, this.onChange, this.onDelete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.multiple(
        title: "Product Category",
        value: category,
        modalType: S2ModalType.bottomSheet,
        modalStyle: S2ModalStyle(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
            ),
          ),
        ),
        choiceType: S2ChoiceType.chips,
        choiceLayout: S2ChoiceLayout.grid,
        // choiceStyle:S2ChoiceStyle(),
        // choiceHeaderStyle:S2ChoiceHeaderStyle()
        onChange: onChange,
        choiceItems: S2Choice.listFrom<String, Category>(
          source: categories,
          value: (index, item) => item.id,
          title: (index, item) => item.name,
        ),
        // choiceItems: S2Choice.listFrom<String, Map<String, String>>(
        //   source: categories,
        //   value: (index, item) => item['value'],
        //   title: (index, item) => item['title'],
        // ),
        tileBuilder: (context, state) {
          return S2Tile.fromState(
            state,
            hideValue: true,
            body: S2TileChips(
              chipLength: state.valueObject.length,
              chipLabelBuilder: (context, i) {
                return Text(
                  state.valueObject[i].title,
                );
              },
              chipAvatarBuilder: (context, i) {
                return CircleAvatar();
              },
              chipOnDelete: onDelete,
              chipColor: Colors.blue[400],
              chipBrightness: Brightness.dark,
              chipBorderOpacity: .5,
            ),
          );
        });
  }
}
