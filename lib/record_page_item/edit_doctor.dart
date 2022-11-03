import 'package:animal_app/TTM/TTMDoctor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../MM/MM.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMUser.dart';

// void main() {
//   runApp(DoctorPage());
// }

class EditDoctorPage extends StatelessWidget {
  const EditDoctorPage( this._user , this.item , this._doctor , {Key? key}) : super(key : key);
  static const String _title = '更新紀錄';


  final TTMUser _user ;
  final TTMItem item ;
  final TTMDoctor _doctor ;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        resizeToAvoidBottomInset: false ,
        body: EditDoctor( this._user , this.item , this._doctor ),
      )

    );
  }
}


class EditDoctor extends StatefulWidget {
  //const AddDoctor({Key? key}) : super(key : key);
  EditDoctor( this._user , this._item , this._doctor , );

  final TTMUser _user ;
  final TTMItem _item ;
  final TTMDoctor _doctor ;


  @override
  State<StatefulWidget> createState() {
    return _EditDoctor(this._user , this._item , this._doctor );
  }
}

class _EditDoctor extends State<EditDoctor> {



  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _hospitalFocusNode = FocusNode();
  final FocusNode _problemFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();


  _EditDoctor( this._user , this._item , this._doctor );

  final TTMUser _user ;
  final TTMItem _item ;
  final TTMDoctor _doctor ;

  @override
  void initState() {
    _dateController.text = _doctor.getDate();//date.toString() ; //set the initial value of text field
    _hospitalController.text = _doctor.hospital ;
    _problemController.text = _doctor.problem ;
    _descriptionController.text = _doctor.description ;
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget ret =  FormBuilder(
      key: _formKey,

      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text('修改或移除',
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


                    ),

                  ),


                ],
              ),


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
                      initialValue: _doctor.date ,
                      name: 'date',
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

                    ),

                  ),

                ],
              ),


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

                      //expands: true,
                    ),
                  ),


                ],
              ),


              //
              MM.newRow( [
                MM.newElevatedButton( "更新" , (){ _onUpdate();} ),
                MM.newElevatedButton( "移除" , (){ _onDelete();} ),
                MM.newElevatedButton( "取消" , (){ MM.pop(context);} ),

              ], MainAxisAlignment.spaceAround),
            ] )
        ),
      ),
    );

    ret = MM.newScrollVertical( ret );
    return ret ;

  }

  Future<void> _onUpdate() async
  {

    try
    {
      //   final TextEditingController _hospitalController = TextEditingController();
      // 醫院
      if( _hospitalController.text.isEmpty )
        throw "未輸入醫院" ;
      if( _problemController.text.isEmpty )
        throw '未輸入問題' ;
      if( _dateController.text.isEmpty )
        throw "未輸入日期" ;
      //   final TextEditingController _problemController = TextEditingController();
      //   final TextEditingController _dateController = TextEditingController();
      //   final TextEditingController _descriptionController = TextEditingController();
      await TTMDoctor( 0 , _hospitalController.text , _problemController.text ,  DateTime.parse( _dateController.text ),
          _descriptionController.text , false , _doctor.snapshot ).upDate();
      MM.MessageBox( context , "更新成功" ).then((_)
      => Navigator.of(context).pop() );

    }catch( e )
    {
      MM.MessageBox( context , e.toString() );
      return ;
    }
  }

  Future<void> _onDelete() async
  {
    try
    {
      await _doctor.del();
      MM.MessageBox( context , "刪除成功" ).then((_)
      => Navigator.of(context).pop() );

    }catch(_){};
  }
}
