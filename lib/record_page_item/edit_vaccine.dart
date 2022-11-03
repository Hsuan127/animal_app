import 'package:animal_app/TTM/TTMDoctor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../MM/MM.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMUser.dart';
import '../TTM/TTMVaccine.dart';

// void main() {
//   runApp(DoctorPage());
// }

class EditVaccinePage extends StatelessWidget {
  const EditVaccinePage( this._user , this.item , this._vaccine , {Key? key}) : super(key : key);
  static const String _title = '更新紀錄';


  final TTMUser _user ;
  final TTMItem item ;
  final TTMVaccine _vaccine ;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        resizeToAvoidBottomInset: false ,
        body: EditVaccine( this._user , this.item , this._vaccine ),
      )

    );
  }
}


class EditVaccine extends StatefulWidget {
  //const AddDoctor({Key? key}) : super(key : key);
  EditVaccine( this._user , this._item , this._vaccine , );

  final TTMUser _user ;
  final TTMItem _item ;
  final TTMVaccine _vaccine ;


  @override
  State<StatefulWidget> createState() {
    return _EditVaccine(this._user , this._item , this._vaccine );
  }
}

class _EditVaccine extends State<EditVaccine> {



  final TextEditingController _vaccineController = TextEditingController();
//  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _hospitalFocusNode = FocusNode();
  final FocusNode _problemFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();


  _EditVaccine( this._user , this._item , this._vaccine );

  final TTMUser _user ;
  final TTMItem _item ;
  final TTMVaccine _vaccine ;

  @override
  void initState() {
    _dateController.text = _vaccine.getDate();//date.toString() ; //set the initial value of text field
    _vaccineController.text = _vaccine.name ;
  //  _problemController.text = _doctor.problem ;
    _descriptionController.text = _vaccine.description ;
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
                      name: 'vaccine',
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
                        hintText: '輸入疫苗名稱',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),

                      controller : _vaccineController ,
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
                    child: Text('日期', style: TextStyle(fontSize: 20,)),
                  ),
                  Expanded(
                    flex: 3,
                    child: FormBuilderDateTimePicker(
                      initialValue: _vaccine.date ,
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
      if( _vaccineController.text.isEmpty )
        throw "未輸入疫苗名稱" ;

      if( _dateController.text.isEmpty )
        throw "未輸入日期" ;
      //   final TextEditingController _problemController = TextEditingController();
      //   final TextEditingController _dateController = TextEditingController();
      //   final TextEditingController _descriptionController = TextEditingController();
      await TTMVaccine( 0 , _vaccineController.text ,  DateTime.parse( _dateController.text ),
          _descriptionController.text , false , _vaccine.snapshot ).upDate();
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
      await _vaccine.del();
      MM.MessageBox( context , "刪除成功" ).then((_)
      => Navigator.of(context).pop() );

    }catch(_){};
  }
}
