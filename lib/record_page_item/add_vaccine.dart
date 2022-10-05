import 'package:animal_app/TTM/TTMVaccine.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../MM/MM.dart';
import '../TTM/TTMItem.dart';
import '../TTM/TTMUser.dart';

// void main() {
//   runApp(AddVaccinePage());
// }

class AddVaccinePage extends StatelessWidget {
  const AddVaccinePage(this.user , this.item , {Key? key}) : super(key : key);
  static const String _title = '新增紀錄';

  final TTMUser user ;
  final TTMItem item ;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: new Scaffold(
        body: new AddVaccine( user , item ),
      ),
    );
  }
}


class AddVaccine extends StatefulWidget {


  final TTMUser user ;
  final TTMItem item ;
  AddVaccine( this.user , this.item );
  //const AddVaccine({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _AddVaccine( this.user , this.item );
  }
}

class _AddVaccine extends State<AddVaccine> {
  final TextEditingController _vaccineController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _vaccineFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  // 資料
  final TTMUser user ;
  final TTMItem item ;
  _AddVaccine( this.user , this.item );

  // Map<String, dynamic> _editTodo = {
  //   'type': '',
  //   'expense': '',
  //   'date': '',
  //   'description':'',
  //   'done': false,
  // };
  // _nextFocus(FocusNode focusNode) {
  //   FocusScope.of(context).requestFocus(focusNode);
  // }
  Future _submitForm() async  {

    // 名稱
    try
    {
    //   final TextEditingController _vaccineController = TextEditingController();
      if( _vaccineController.text.isEmpty )
        throw "未輸入名稱" ;
      if( _dateController.text.isEmpty )
        throw "未輸入日期" ;
      await item.addVaccine( TTMVaccine( 0 , _vaccineController.text ,  DateTime.parse( _dateController.text ),
          _descriptionController.text , false ));
      MM.MessageBox( context , "OK" ).then((_)
          => Navigator.of(context).pop() );
    }catch( e )
    {
      MM.MessageBox( context , e.toString() );
      return ;
    }
    return ;
    // 日期
    //   final TextEditingController _dateController = TextEditingController();
    // 備註
    //   final TextEditingController _descriptionController = TextEditingController();

    if (_formKey.currentState!.validate()) {
        // final vaccine_record = {
        //   'name': _vaccineController.text,
        //   'date': _dateController.text,
        //   'note': _descriptionController.text,
        // };
        // print(vaccine_record.toString());

        // If the form passes validation, display a Snackbar.

        // final snackBar = SnackBar(
        //     content: const Text('紀錄已儲存'),);
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        _formKey.currentState!.save();
        _formKey.currentState!.reset();
        //_nextFocus(_vaccineFocusNode);
      }
  }
  String? _validateInput(String value) {
      if(value.trim().isEmpty) {
      return 'Field required';
    }
    return null;
  }


  @override
  void initState() {
    // _dateController.text = ""; //set the initial value of text field
    // _vaccineController.text = "";
    // _descriptionController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    // _descriptionFocusNode.dispose();

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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(60.0),
        child: FormBuilder(
          key: _formKey,
          onChanged: () => print("Form has been changed."),
          autovalidateMode: AutovalidateMode.always ,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text('增加',
                            style: TextStyle(fontSize: 24,)
                        ),
                      ),
                    ),

                    Divider(
                      color: Colors.grey[400],
                      height: 10,
                      thickness: 2,
                    ),

                    // SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('疫苗', style: TextStyle(fontSize: 20,)),
                        ),
                        Expanded(
                          flex: 3,
                          child: FormBuilderTextField(
                            name: 'vaccine',
                            focusNode: _vaccineFocusNode,

                            onSubmitted: (String ?value) {
                              //Do anything with value
                              TextInputAction.next;
                              // _nextFocus(_dateFocusNode);
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
                            ),
                            controller: _vaccineController,
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
                          child: Text('日期', style: TextStyle(fontSize: 20,)),
                        ),
                        Expanded(
                          flex: 3,
                          child: FormBuilderDateTimePicker(
                            name: 'date',
                            initialDate: DateTime.now(),
                            initialValue: DateTime.now(),
                            focusNode: _dateFocusNode,
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            initialEntryMode: DatePickerEntryMode.calendar,
                            onFieldSubmitted: (DateTime ?value) {
                              //Do anything with value
                              TextInputAction.next;
                              // _nextFocus(_descriptionFocusNode);
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              hintText: '選擇施打日期',
                              hintStyle: const TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _dateController,
                            // onTap: () async {
                            //   DateTime? pickedDate = await showDatePicker(
                            //       context: context,
                            //       initialDate: DateTime.now(),
                            //       firstDate: DateTime(1950),
                            //       //DateTime.now() - not to allow to choose before today.
                            //       lastDate: DateTime(2100));
                            //     if (pickedDate != null) {
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
                            focusNode: _descriptionFocusNode,
                            onFieldSubmitted: (String value) {
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
                            //expands: true,
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
                        _submitForm();
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('紀錄已儲存')));
                        }
                      },
                      child: const Text('送出', style: TextStyle(fontSize: 20),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            //),

          //),
        ),
      ),


    );


  }
}