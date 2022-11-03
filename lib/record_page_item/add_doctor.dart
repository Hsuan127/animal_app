import 'package:animal_app/TTM/TTMDoctor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../MM/HYSizeFit.dart';
import '../MM/MM.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMUser.dart';

// void main() {
//   runApp(DoctorPage());
// }

class AddDoctorPage extends StatelessWidget {
  const AddDoctorPage( this._user , this.item , this._doctor , {Key? key}) : super(key : key);
  static const String _title = '新增紀錄';


  final TTMUser _user ;
  final TTMItem item ;
  final TTMDoctor? _doctor ;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: new Scaffold(

        body: new AddDoctor( this._user , this.item , this._doctor ),
      )

    );
  }
}


class AddDoctor extends StatefulWidget {
  //const AddDoctor({Key? key}) : super(key : key);
  AddDoctor( this.user , this.item , this._doctor , );

  final TTMUser user ;
  final TTMItem item ;
  final TTMDoctor? _doctor ;


  @override
  State<StatefulWidget> createState() {
    return _AddDoctor(this.user , this.item);
  }
}

class _AddDoctor extends State<AddDoctor> {



  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _hospitalFocusNode = FocusNode();
  final FocusNode _problemFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();


  _AddDoctor( this.user , this.item );

  final TTMUser user ;
  final TTMItem item ;
  // Map<String, dynamic> _editTodo = {
  //   'type': '',
  //   'expense': '',
  //   'date': '',
  //   'description':'',
  //   'done': false,
  // };
  // _nextFocus(FocusNode focusNode) {
  //
  //   FocusScope.of(context).requestFocus(focusNode);
  // }
  // _submitForm() {
  //   Scaffold.of(context).showSnackBar(SnackBar(content:
  //   Text('紀錄已儲存！')));
  // }

  @override
  void initState() {
    _dateController.text = ""; //set the initial value of text field
    _hospitalController.text = "";
    _problemController.text = "";
    _descriptionController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle : true ,
        title:  const Text('增加就醫記錄') ,

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.piw),
        child: FormBuilder(
          key: _formKey,
        //child: Padding(
        //height: 1000,
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
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if( false )
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text('增加',
                                style: TextStyle(fontSize: 24,)
                            ),
                          ),
                        ),
                  if( false )
                        Divider(
                          color: Colors.grey[400],
                          height: 10,
                          thickness: 2,
                        ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text('就醫細項',
                          style: TextStyle(fontSize: 24,)
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 10,
                    thickness: 2,
                  ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('醫院', style: TextStyle(fontSize: 20,)),
                            ),
                            Expanded(
                              flex: 3,
                              child: FormBuilderTextField(
                                name: 'hospital',
                                textInputAction: TextInputAction.next ,
                                focusNode: _hospitalFocusNode,
                                onSubmitted: (String ?value) {
                                  //Do anything with value
                                  //_nextFocus(_dateFocusNode);
                                  TextInputAction.next;
                                },
                                decoration: InputDecoration(
                                  //Add isDense true and zero Padding.
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  //isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  hintText: '輸入看診醫院',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),

                                  controller : _hospitalController ,
                                keyboardType: TextInputType.text,
                              ),
                            ),

                          ],
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('問題', style: TextStyle(fontSize: 20,)),
                            ),
                            Expanded(
                              flex: 3,
                              child: FormBuilderTextField(
                                name: 'problem',
                                textInputAction: TextInputAction.next ,
                                focusNode: _problemFocusNode,
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
                                  hintText: '輸入就診原因',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                controller: _problemController,
                                keyboardType: TextInputType.multiline,
                                /*
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],*/
                              ),

                            ),


                          ],
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
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
                                textInputAction: TextInputAction.next ,
                                focusNode: _dateFocusNode,
                                onFieldSubmitted: (DateTime ?value) {
                                  //Do anything with value
                                  TextInputAction.next;
                                },
                                format: DateFormat("yyyy-MM-dd"),
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
                                initialEntryMode: DatePickerEntryMode.calendar,
                                controller: _dateController,
                                // onTap: () async {
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
                        // SizedBox(
                        //   height: 20,
                        // ),
                        //Container(
                        //height: 100,
                        //child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('備註', style: TextStyle(fontSize: 20,)),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                textInputAction: TextInputAction.done ,
                                focusNode: _descriptionFocusNode,
                                onFieldSubmitted: (String value) {
                                  //Do anything with value
                                //  _submitForm();
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
                                controller: _descriptionController,
                                ),
                            ),


                          ],
                        ),

                        //),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        ElevatedButton(
                          onPressed: () {
                          //  _formKey.
                            _onSave();

                            /*
                            if (_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              _formKey.currentState!.reset();
                            }*/

                          },
                          child: const Text('送出', style: TextStyle(fontSize: 20),
                          ),
                        ),

                      ],
                  ),
              ),
            ),
          ),

          //),
        //),

      ),


    );


  }

  Future<void> _onSave() async
  {

    try
    {
      //   final TextEditingController _hospitalController = TextEditingController();
      // 醫院
      if( _hospitalController.text.isEmpty )
        throw "未輸入醫院" ;
      if( _problemController.text.isEmpty )
        throw "未輸入問題" ;
      if( _dateController.text.isEmpty )
        throw "未輸入日期" ;
      //   final TextEditingController _problemController = TextEditingController();
      //   final TextEditingController _dateController = TextEditingController();
      //   final TextEditingController _descriptionController = TextEditingController();
      await item.addDoctor( TTMDoctor( 0 , _hospitalController.text , _problemController.text ,  DateTime.parse( _dateController.text ),
          _descriptionController.text , false ));
      MM.MessageBox( context , "新增完成" ).then((_)
      => Navigator.of(context).pop() );

    }catch( e )
    {
      MM.MessageBox( context , e.toString() );
      return ;
    }
  }
}
