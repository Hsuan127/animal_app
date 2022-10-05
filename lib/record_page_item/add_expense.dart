import 'package:animal_app/TTM/TTMItem.dart';
import 'package:animal_app/TTM/TTMSpendRecords.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../MM/MM.dart';
import '../TTM/TTMUser.dart';
/*
void main() {
  runApp(ExpensePage());
}
*/
class ExpensePage extends StatelessWidget {
  const ExpensePage( TTMUser user , TTMItem item , {Key? key}) :

        _user = user ,
        _item = item
  ;
  final TTMUser _user ;
  final TTMItem _item ;
  static const String _title = '新增花費';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: AddExpense( _user , _item ),
      );
  }
}


class AddExpense extends StatefulWidget {
  AddExpense(TTMUser user , TTMItem item , {Key? key})
      :
      _user = user ,
      _item = item
  ;

  final TTMUser _user ;
  final TTMItem _item ;
  @override
  State<StatefulWidget> createState() {
    return _AddExpense( _user , _item );
  }
}

class _AddExpense extends State<AddExpense> {
  // 花費日期'
  final TextEditingController _dateController = TextEditingController();
  // 花費金額
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _expenseFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  void _onChanged(dynamic val) => debugPrint(val.toString());

  //
  _AddExpense( TTMUser user , TTMItem item ):
        _user = user ,
        _item = item
  ;

  final TTMUser _user ;
  final TTMItem _item ;
  // Map<String, dynamic> _editTodo = {
  //   'type': '',
  //   'expense': '',
  //   'date': '',
  //   'description':'',
  //   'done': false,
  // };
  _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
  _submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
    Text('紀錄已儲存！')));
  }

  @override
  void initState() {
    // _dateController.text = ""; //set the initial value of text field
    // _expenseController.text = "";
    // _descriptionController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    //_descriptionFocusNode.dispose();

    super.dispose();
  }
  //
  // void _saveForm() {
  //   final isValid = _formKey.currentState.validate();
  //   if (isValid) {
  //     _formKey.currentState.save();
  //     print(_editTodo['type']);
  //     print(_editTodo['expense']);
  //     print(_editTodo['date']);
  //     print(_editTodo['description']);
  //     final Todo newTodo = Todo(
  //       type: _editTodo['type'],
  //       expense: _editTodo['expense'],
  //       date: _editTodo['date'],
  //       description: _editTodo['description'],
  //       done: false,
  //     );
  //     Provider.of<Todos>(context, listen: false).addTodo(newTodo);
  //     Navigator.of(context).pop();
  //   }
  // }


  //const AddExpense({Key? key}) : super(key: key);

  final List<String> expenseItems = [
    '食品或保健品',
    '日用品',
    '醫療或健康檢查',
    '美容',
    '住宿或寄養',
  ];
  String? selectedValue = null;
  bool _categoryHasError = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle : true ,
        title:  const Text('增加花費') ,

      ),
      body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: 'uniqueTag',
              // flightShuttleBuilder: (BuildContext flightContext,
              //     Animation<double> animation,
              //     HeroFlightDirection flightDirection,
              //     BuildContext fromHeroContext,
              //     BuildContext toHeroContext,)
              // {
              //   return SingleChildScrollView(
              //     child: fromHeroContext.widget,
              //   );
              // },
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                _formKey.currentState!.save();
                debugPrint(_formKey.currentState!.value.toString());
                },
              child: Material(
                type: MaterialType.transparency,
                        child: Container(
                          height: 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text('增加',
                                      style: TextStyle(fontSize: 24,)
                                  ),
                                ),
                              ),
                              //SizedBox(height: 15),

                              Divider(
                                color: Colors.grey[400],
                                height: 10,
                                thickness: 2,
                              ),
                              //SizedBox(height: 20),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('類別', style: TextStyle(fontSize: 20,)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: FormBuilderDropdown<String>(
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
                                      hint: const Text(
                                        '選擇花費類別',
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
                                        setState(() {
                                          _categoryHasError = !(_formKey
                                              .currentState?.fields['category']
                                              ?.validate() ??
                                              false);
                                        });
                                      },
                                      onSaved: (value) {
                                        selectedValue = value.toString();
                                      },

                                    ),
                                  ),

                                ],
                              ),
                              //SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('金額', style: TextStyle(fontSize: 20,)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: FormBuilderTextField(
                                      name: 'expense',
                                      focusNode: _expenseFocusNode,
                                      onSubmitted: (String ?value) {
                                        //Do anything with value
                                        //_nextFocus(_dateFocusNode);
                                        TextInputAction.next;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        hintText: '輸入花費金額',
                                        hintStyle: const TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: _expenseController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),

                                  ),


                                ],
                              ),
                              //SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('日期', style: TextStyle(fontSize: 20,)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: FormBuilderDateTimePicker(
                                      name: 'date',
                                      initialDate: DateTime.now(),
                                      initialValue: DateTime.now(),
                                      inputType: InputType.date,
                                      focusNode: _dateFocusNode,
                                      format: DateFormat("yyyy-MM-dd"),
                                      initialEntryMode: DatePickerEntryMode.calendar,
                                      onFieldSubmitted: (DateTime ?value) {
                                        //Do anything with value
                                        TextInputAction.next;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        hintText: '選擇花費日期',
                                        hintStyle: const TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: _dateController,
                                      // onEditingComplete: () async {
                                      //   DateTime? pickedDate = await showDatePicker(
                                      //       context: context,
                                      //       initialDate: DateTime.now(),
                                      //       firstDate: DateTime(1950),
                                      //       //DateTime.now() - not to allow to choose before today.
                                      //       lastDate: DateTime(2100));
                                      //
                                      //   if (pickedDate != null) {
                                      //     print(
                                      //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      //     String formattedDate =
                                      //     DateFormat('yyyy-MM-dd').format(pickedDate);
                                      //     print(
                                      //         formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //     setState(() {
                                      //       _dateController.text =
                                      //           formattedDate; //set output date to TextField value.
                                      //     });
                                      //   }
                                      //   else {}
                                      // },
                                    ),

                                  ),

                                ],
                              ),
                              //SizedBox(height: 20),
                              //Container(
                              //height: 100,
                              //child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('備註', style: TextStyle(fontSize: 20)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: FormBuilderTextField(
                                      name: 'description',
                                      enabled: true,
                                      focusNode: _descriptionFocusNode,
                                      onSubmitted: (String ?value) {
                                        //Do anything with value
                                        _submitForm();
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        ),

                                        hintText: '有什麼想備註的嗎？',
                                        hintStyle: const TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      controller: _descriptionController ,
                                      //expands: true,
                                    ),
                                  ),


                                ],
                              ),

                              //),
                              //SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _push ,
                                child: const Text('送出', style: TextStyle(fontSize: 20),
                                ),
                              ),

                            ],
                          ),
                        ),


                    ),


              ),

              //),
            ),
          ),


            //),

    );


  }

  //
  //
  void _push()
  {
    try
    {
      if( selectedValue == null ) {
        throw "not select item" ;
      }
      if( _expenseController.text.isEmpty ) {
        throw "not enter expense" ;
      }
      if( _dateController.text.isEmpty ) {
        throw "not set date " ;
      }

      final int money = int.parse( _expenseController.text );
      final String description = _descriptionController.text ;
      final String dateText = _dateController.text ;

      final callback = ()async
      {
        try
        {
          await _item.addSpendRecords( TTMSpendRecords(
              selectedValue! , money , dateText ,
              DateTime.now() , description )
          );
          MM.MessageBox( context , "add down" , "push" ).then((_){ MM.pop(context);});

        }catch( e )
        {
          MM.MessageBox( context , e.toString() , "push error" );
        }
      };
      callback();
    }catch( e )
    {
      MM.MessageBox( context , e.toString() , "push error" );
    }
    /*
    if (_formKey.currentState!.validate())
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('紀錄已儲存')));
      _formKey.currentState!.save();
      _formKey.currentState!.reset();
    }
*/
  }
}