

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'MM.dart';
import 'MMWidget.dart';
import 'dart:math';

/// ---------------------------------------------------------------
///
///
///
/// TODO Places
///
///
///
///
/// ---------------------------------------------------------------
// 選項
/// -------------------------------------------------------------------
///
/// 全部
///
class MMPlaceItem
{
  MMPlaceItem( int index , PlacesSearchResult data , double len )
  : _data = data
  , _len = len
      // TODO: 20220807 改名稱
  //, name = "${MM.strSubTo( data.name )}"
  , name = "${index.toString().padLeft(2,'0')}. ${MM.strSubTo( data.name )}"
  ;

  //
  final String name ;
  //
  bool _isDetails = false ;
  //
  PlacesDetailsResponse? _details = null ;
  //
  final PlacesSearchResult _data ; // 回傳的資料在此
  final double _len ;

  get len => _len ;

//  String get name => _data.name;

  Location? get location => _data.geometry!.location ;

  double get lat => ( _data.geometry != null )? _data.geometry!.location.lat : 0 ;
  double get lng => ( _data.geometry != null )? _data.geometry!.location.lng : 0 ;

  PlacesSearchResult get data => _data ;

  String ?getPhoto( String API_KEY ) // 取得照列的繪址
  {
    try
    {
      if( _data.photos.length > 0 )
      {/*
    https://maps.googleapis.com/maps/api/place/photo
    ?maxwidth=400
    &photo_reference=Aap_uEA7vb0DDYVJWEaX3O-AtYp77AaswQKSGtDaimt3gt7QCNpdjp1BkdM6acJ96xTec3tsV_ZJNL_JP-lqsVxydG3nh739RE_hepOOL05tfJh2_ranjMadb3VoBYFvF0ma6S24qZ6QJUuV6sSRrhCskSBP5C1myCzsebztMfGvm7ij3gZT
    &key=YOUR_API_KEY*/
        return "https://maps.googleapis.com/maps/api/place/photo" +
            "?maxwidth=400" +
            "&photo_reference=" + _data.photos[0].photoReference +
            "&key=" + API_KEY ;
      }
    }catch( e )
    {
    }
    return null ;
  }

  // 詳細資料
  Future<void> getDetails( String googleKey ) async
  {
    if( _isDetails )
      return ;
    _isDetails = true ;
    GoogleMapsPlaces pp = new GoogleMapsPlaces( apiKey: googleKey );
    PlacesDetailsResponse res = await pp.getDetailsByPlaceId( _data.placeId , language: "zh-TW");
    if( res.isOkay )
      _details = res ;

  }


  //
  String toStr( String key , Object ?str  ) // 方便做換行
  {
    if( str == null )
      return "" ;
    if( key.length == 0 )
      return "$str\n" ;
    return "$key: $str\n" ;
  }

  @override
  String toString() // 文字
  {
    String ret = _data.name + "\n";

    ret += toStr("地址", _data.formattedAddress);
    if (_details != null)
      ret += toStr( "電話" , _details!.result.formattedPhoneNumber );
    ret += toStr("星等", _data.rating);
    ret += toStr("價格水平", _data.priceLevel);

    if (_details != null)
    {
      PlaceDetails dd = _details!.result ;

      ret += toStr("", getOpeningHours( dd ));
    }else
    {
      ret += toStr("地址", _data.formattedAddress);
      ret += toStr("", getOpeningHours( _data ));
    }


    return ret ;
  }



  String? getOpeningHours( dd )
  {
   if( dd.openingHours == null )return null ;
   String ret = "休息中\n" ;
   OpeningHoursDetail oo = dd.openingHours! ;
    if( oo.openNow  )
      ret = "營業中\n";
    /*
   for( OpeningHoursPeriod d in oo.periods )
     {
       if( d.open != null )
         {
           OpeningHoursPeriodDate open = d.open! ;
           ret += "  星期${open.day} ${open.time}\n" ;
         }
     }
*/

   for( String d in oo.weekdayText )
   {

       ret += "$d\n" ;
   }
   return ret ;
  }
}

/// ------------------------------------------------------------------
///
/// 全部
class MMPlaces
{

  MMPlaces()
  {
  }

  // 取得列表
  List<MMPlaceItem> get placesList
  {
    List<MMPlaceItem> ret = [] ;
    ret.addAll(  _mPlaces );
    return ret ;
  }


  ///
  //
  //
  final List<MMPlaceItem> _mPlaces = [];
  String _runPlaceName = "" ;



  Future<dynamic> getPlaces( String googleKey , double lat , double lng , double radius , String keyWord ) async// 找位置
  {
    //  pd.style(message: "get places...");
    //   pd.show();
    try
    {
      // 1. 建立 google places
      Location location = Location(lat: lat, lng: lng);
      GoogleMapsPlaces pp = new GoogleMapsPlaces( apiKey: googleKey );



      // 2. 找字串
    //  PlacesSearchResponse result = await pp.searchByText("金王子有限公司" , location: location , language: "zh-TW" );
      PlacesSearchResponse result = await pp.searchByText( keyWord , location: location , language: "zh-TW" );
      if (result.status == "OK")
      {

        // 3. 清空舊資料
        _mPlaces.clear();
        for( final PlacesSearchResult d in result.results )
          if( d.geometry != null )
          {

            // 4. 加到清單中
            Location ll = d.geometry!.location ;

            double len = _getDistance( ll.lat , ll.lng , location.lat , location.lng );
            final MMPlaceItem item = new MMPlaceItem( _mPlaces.length +1 , d , len ) ;
            _mPlaces.add( item );
          }

        /// 5. 依距離遠近排序排序
        _mPlaces.sort(( a , b )
        {
          if( a.len > b.len )
            return 1 ;
          else if( a.len == b.len )
            return 0 ;
          return -1 ;
        });
        //   _PlaceName = result.
        //   _mPlaces = result.results ;
        //   MMWidget.showMessage( context , _pageName() );
        print( "getPlaces: ok : $radius last:${_mPlaces[0].name} : ${_mPlaces[0].len}" );
        return _mPlaces.length ;
      }else
      {
        return result.status ;
        //MMWidget.showMessage( context , Text( "error:${result.status}" ) );
      }
    }catch( e )
    {
      print( "getPlaces: ${e.toString()}");
    }
  }

  //
  // TODO: 20220807 經度轉緯度
  double _getDistance(double lat1, double lng1, double lat2, double lng2) {
    /// 单位：米
    double def = 6378137.0;
    double radLat1 = _rad(lat1);
    double radLat2 = _rad(lat2);
    double a = radLat1 - radLat2;
    double b = _rad(lng1) - _rad(lng2);
    double s = 2 * asin(sqrt(pow(sin(a / 2), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b / 2), 2)));
    return (s * def ).roundToDouble();
  }

  double _rad(double d) {
    return d * pi / 180.0;
  }
}
