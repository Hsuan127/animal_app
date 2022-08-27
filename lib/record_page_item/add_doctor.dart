import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// void main() {
//   runApp(DoctorPage());
// }

class AddDoctorPage extends StatelessWidget {
  const AddDoctorPage({Key? key}) : super(key : key);
  static const String _title = '新增紀錄';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: new Scaffold(
        body: new AddDoctor(),
      )

    );
  }
}


class AddDoctor extends StatefulWidget {
  //const AddDoctor({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _AddDoctor();
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
    Scaffold.of(context).showSnackBar(SnackBar(content:
    Text('紀錄已儲存！')));
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(60.0),
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
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                inputType: InputType.date,
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
                            if (_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              _formKey.currentState!.reset();
                            }

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
}
