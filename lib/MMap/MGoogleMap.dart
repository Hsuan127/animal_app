import 'dart:async';

import 'dart:math';
import '../MM/HYSizeFit.dart';
import '../MM/MMLoading.dart';
import '../MM/MMPlaces.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

import '../MM/MM.dart';
import '../MM/MMWidget.dart';


class MGoogleMap extends StatefulWidget {
  const MGoogleMap({Key? key}) : super(key: key);


  @override
  State<MGoogleMap> createState() => _MGoogleMap();
}


class _MGoogleMap extends State<MGoogleMap> {


  // TODO: API
  final String API_KEY = "AIzaSyAHBuP6mJoew1cAjtd46zrbfEAHc2OwT48" ;

  // TODO: Google 控制項
  Completer<GoogleMapController> _controller = Completer();

  // 目前位置
  CameraPosition _comerPosition = CameraPosition(
    target: LatLng(121.512281, 25.040445),
    zoom: 14.4746,
  );



  // 目前座標
  LatLng ?_latLng ;


  // TODO: Google Places 得到的訊息
  final MMPlaces _places = MMPlaces();

  @override
  void initState() // 初始
  {
    // 先找位置
    getUserLocation( false ) ;
  }


  // 畫面
  @override
  Widget build(BuildContext context) // build 畫面
  {

    // 還沒進來
    if( _latLng == null )
      return Text( "loading ");

    return Stack( children: [
      _initGoogleMap(),
      _initTop(),
    ], );


  }

  //
  Widget _initTop() // 上層界面
  {
    Widget gotoWidget = MMWidget.newRow([
      //Text( "v:20220629-1 " , textAlign:TextAlign.left ),
      MMWidget.newFlatButton( Text( "現在位置") , (){ _gotoUserLocation();}) ,
    ]);
    Widget c ;
    c = Column( children: [
      Text( "", textAlign:TextAlign.center ), // 空下來以免被頂端訊息蓋到，如果是全螢幕就拿掉
      gotoWidget , // 到我的位置

      _initTypeCombo(), // 類型選單
      _initFindList(), // 地點列表

    ],
      mainAxisSize : MainAxisSize.min,
    );

    // 左右拉到最大
    c = ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity),
      child: c ,
    );


    // 加白色虐框
    c = Container( child: c ,
      color: Colors.white, );
    return c ;
  }


  // map
  Widget _initGoogleMap() // map 面畫
  {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _comerPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      myLocationEnabled: true ,
      myLocationButtonEnabled: true,
      markers: Set<Marker>.of(_markers.values),
    );
  }



  //
  //
  Future<void> _gotoUserLocation() async // 到我目前的位置
  {
    await getUserLocation();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_comerPosition));

  }
  //
  bool _isFindPlaces = false ;
  Future<void> _findPlaces( String keyword ) async // 找我附近的位置
  {
    print( "_findPlaces ..." );

    if( _isFindPlaces )
      return ;
    _isFindPlaces = false ;
    MMLoading.show( context );
    try
    {
      // 1. 找目前位置
      await getUserLocation( false );
      if( _latLng != null )
      {
        // 2. 呼叫 MMPlaces 找點
        dynamic ret = await _places.getPlaces(API_KEY, _latLng!.latitude , _latLng!.longitude , 100, keyword );


        // 3. 更新標示
        _initMarker();
        // 4. 更新畫面
        setState((){}) ;
      }
      /*
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));*/
    }catch( e )
    {
    }

    MMLoading.hide( context );
    _isFindPlaces = false ;
    print( "_findPlaces done" );
  }


  // LocationData? currentLocation = null ;
  Future<LatLng?> getUserLocation( [ bool isShowDialog = true ] ) async // 到我的位置
  {

    if( isShowDialog )MMLoading.show( context );
    try {
     // _latLng = null ;
      Location location = new Location();
      LocationData   _locationData = await location.getLocation();
      _latLng = LatLng( _locationData.latitude! , _locationData.longitude! );
      _comerPosition = CameraPosition(
        target: _latLng! ,
        zoom: 14.4746,
      );
      //

      setState((){}) ;


   //   return _latLng ;
    } catch( e )
    {

      print( e );
  //    return null;
    }

    if( isShowDialog ) MMLoading.hide(context);
  }


  //
  //
  //
  //   動物醫院
  // 動物美容院
  // 寵物用品店
  // 寵物旅館
  //
  //
  //
  final List<String> _itemList = [ "動物醫院" , "動物美容院" , "寵物用品店" , "寵物旅館" ] ;
  String _dropdownValue = "動物醫院" ;
  // TODO: 20220807 建版
  Widget _initTypeCombo() // 建模式列表
  {
    Widget t = Text( "Find:") ;
    Widget c = DropdownButton<String>(
      value: _dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.amberAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          _dropdownValue = newValue!;
        }
        );
      },
      items: _itemList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    //
    Widget b = FlatButton( child: Text( "搜尋"),
        color: Colors.amber,
        onPressed: ()=> _findPlaces(_dropdownValue) );
    //
    c =  Row( children: [ t,  c , b ] ,
      mainAxisAlignment: MainAxisAlignment.spaceAround ,
    ) ;

    return c ;
  }

  // 初始列表
  Widget _initFindList() // 找到的列表
  {
    List<String> strList = [] ;
    final List<MMPlaceItem> list = _places.placesList ;
    if( list.length == 0 )
      return SizedBox.shrink();

    // TODO: 20220807 sort
    /*
    list.sort((a,b)
    {
      if( a.lensp < b.lensp )
        return -1 ;
      if( a.lensp > b.lensp )
        return 1 ;
      return 0 ;
    });*/
    //
    for( MMPlaceItem d in list )
      {
        if( strList.indexOf( d.name )== -1 )
          strList.add( d.name );
      }

    /*
    strList.sort((a,b)
      {
        return a.compareTo( b ) ;
      });*/

    Widget c = DropdownButton<MMPlaceItem>(
      isExpanded:true ,
      value: _mmPlaceItem ,// TODO: 20220807
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.amberAccent,
      ),
      onChanged: (MMPlaceItem? newValue) {
        if( newValue != null )
          _goto( newValue.name );
      },

      items: list
          .map<DropdownMenuItem<MMPlaceItem>>((MMPlaceItem value) {
        String name = value.name ;
        int index = name.indexOf( "." ) ;
           if( index >= 0 )if( index < 4 )
             name = name.substring( index  + 1) ;
            double len = value.len ;
            var int_len = len.toInt();

        String lenText = "$int_len m" ;

        Widget row = Row(
            mainAxisAlignment : MainAxisAlignment.spaceBetween ,
          children: [
          Text( name ) ,
          Text( "$lenText")
        ],);

        return DropdownMenuItem<MMPlaceItem>(
          value: value,
          child: row ,//Text(text),
        );
      }).toList(),
    );

    c = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: double.infinity),
      child: c ,
    );

  //  c = Padding( child: c , padding : EdgeInsets.fromLTRB(  20 , 0 ,  20 , 0 ));
    // 拉到最寬
     c = FractionallySizedBox( child : c ,  widthFactor: 0.9 );
    //
/*
    c = SingleChildScrollView( child: c ,
      scrollDirection : Axis.horizontal ,
    );*/

    return c ;
  }

  Future<void> _goto( String str )async // 到指定位置
  {

    List<MMPlaceItem> list = _places.placesList ;

    for( MMPlaceItem d in list ) {
      if( d.name == str ) {
        _markerString = str ;

        CameraPosition toDest = CameraPosition(
          //    bearing: 192.8334901395799,
            target: LatLng( d.lat, d.lng ),
            //    tilt: 59.440717697143555,
            zoom: 18
        );
        setState(() {

        });

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(toDest));

        return ;
      }
    }

  }

  // -------------------------------------------------------------
  // 標示
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  LatLng _center =  LatLng(9.669111, 80.014007);
  String _markerString = "" ;
  MMPlaceItem? _mmPlaceItem = null ;// TODO: 20220807
  void _initMarker() // 建立標示
  {
    List<MMPlaceItem> list = _places.placesList ;

    int index = 0  ;
    _markers = <MarkerId, Marker>{};
    for( final MMPlaceItem d in list )
    {
      final MarkerId markerId = MarkerId( d.name );
      if( _markerString == d.name ) {
        index = 1;
        _mmPlaceItem = d ;// TODO: 20220807
      }
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
            d.lat , d.lng
        ),
        //  畫面彈出   infoWindow: InfoWindow(title: d.name , snippet: d.data.formattedAddress ),
        // dialog 彈出
        onTap: () {
          //  _onMarkerTapped(markerId);
          _onMarkerCallback( d );
        },
      );

      _markers[ markerId ] = marker ;
    }

    // 第一個位置
    if(index == 0 )
      if( list.length > 0 ) {
        _mmPlaceItem = list[0] ;// TODO: 20220807
        _markerString = list[0].name;
      }
/*
    setState(() {
    });*/
  }

 void _onMarkerCallback( final MMPlaceItem d ) // 點標 標示時
  {
    // TODO: 20220703 更新，dialog 版面
    // 取資料，有讀到就更新
    d.getDetails( API_KEY ).then((_)
        {
          String ?photo = d.getPhoto( API_KEY );
          Widget p = photo != null ? Image.network( photo ) :
          MMWidget.newNullWidget();
          Widget c = MMWidget.newColumn( [
            Text( d.toString() ),
            //   Text( d.data.formattedAddress??"" ),
            p ,

          ]);
          c = MMWidget.newScroll( c );
          MM.ShowDialog( context , c );
        }
    );

  }

}
