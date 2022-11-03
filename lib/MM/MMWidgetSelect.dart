
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MMWidgetSelect extends StatefulWidget {
  final String ?selectedValue ;
  final List<String> expenseItems ;
  final String titleStr ;
  final String helpStr ;
  final onCallback ;
  MMWidgetSelect( this.expenseItems , this.titleStr , this.helpStr , this.onCallback , [ this.selectedValue = null ]) ;

  @override
  State<MMWidgetSelect> createState() => _MMWidgetSelect( this.expenseItems
      , this.titleStr , this.helpStr , this.onCallback , this.selectedValue
  );
}


class _MMWidgetSelect extends State<MMWidgetSelect>
{
  //
  String ?selectedValue ;
  bool _categoryHasError = false;


  final List<String> expenseItems ;
  final String titleStr ;
  final String helpStr ;
  final onCallback ;
  _MMWidgetSelect( this.expenseItems , this.titleStr , this.helpStr , this.onCallback , this.selectedValue ) ;

  //
  //
  @override
  Widget build(BuildContext context) {
    // 修正 select
    if( selectedValue != null )
      {
        if( expenseItems.indexOf(selectedValue! ) < 0 )
          selectedValue = null ;
      }
    // TODO: implement build
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Text( titleStr ,  style: TextStyle(fontSize: 20,)),
          ),
          Expanded(
            flex: 3,
            child: FormBuilderDropdown<String>(
              initialValue: selectedValue,
              name: 'category',
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: EdgeInsets.only(left: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffix: _categoryHasError ? const Icon(Icons.error) : const Icon(Icons.check),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: Text(
                helpStr ,
                style: TextStyle(fontSize: 14),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              itemHeight: 50,
              // buttonPadding: const EdgeInsets.only(
              //     left: 20, right: 10),
              borderRadius: BorderRadius.circular(8),
              // ),
              items: expenseItems
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
              // validator: (value) {
              //   if (value == null) {
              //     return '請選擇花費類別';
              //   }
              // },
              onChanged: (value)
              {
                selectedValue = value.toString();
                setState(() {
                  _categoryHasError =( selectedValue == null );
                });
                onCallback( selectedValue );
              },


            ),
          ),

        ],
      );
  }

}
