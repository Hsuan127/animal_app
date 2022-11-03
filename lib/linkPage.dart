import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('連結'),
        centerTitle: true,
      ),
      body:

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // OutlinedButton.icon(
                //     onPressed: () async {
                //       var url = Uri.parse("https://github.com/evachang0925");
                //       await launchUrl(url);
                //     },
                //     icon: const Icon(Icons.people_alt_outlined),
                //     label: const Text('iPet 寵物生活與配對好夥伴'),
                //     style: OutlinedButton.styleFrom(
                //     fixedSize: const Size(300, 80),
                //     primary: Colors.black,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15.0),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                OutlinedButton.icon(
                  onPressed:() async {
                    var url = Uri.parse("https://drive.google.com/file/d/1N-lsRcmqXr4HABo1wZlBejlN29iBN6Sc/view?usp=sharing");
                    await launchUrl(url);
                  },
                  icon: const Icon(Icons.pets_rounded),
                  label: const Text('狂犬病疫苗預防注射 獸醫診療機構名冊'),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(300, 80),
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                OutlinedButton.icon(
                  onPressed:() async {
                    var url = Uri.parse("https://drive.google.com/file/d/1wRhFc-1QQJt5aRCGXKuEyauiD6IDfFdz/view?usp=sharing");
                    await launchUrl(url);
                  },
                  icon: const Icon(Icons.pets_rounded),
                  label: const Text('臺北市提供夜間急診或 24 小時營業動物醫院一覽表'),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(300, 80),
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                OutlinedButton.icon(
                  onPressed:() async {
                    var url = Uri.parse("https://drive.google.com/file/d/1K1Tyeqv3ZO02N03vBS6Kj0rt19ljJZDV/view?usp=sharing");
                    await launchUrl(url);
                  },
                  icon: const Icon(Icons.pets_rounded),
                  label: const Text('TAS 浪愛滿屋犬貓收容及認養計畫'),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(300, 80),
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                OutlinedButton.icon(
                  onPressed:() async {
                    var url = Uri.parse("https://www.tcapo.gov.taipei/Default.aspx");
                    await launchUrl(url);
                  },
                  icon: const Icon(Icons.local_hospital),
                  label: const Text('台北市動物保護處'),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(300, 80),
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    var url = Uri.parse("http://www.langlangdontcry.com.tw");
                    await launchUrl(url);
                  },
                  icon: const Icon(Icons.pets_rounded),
                  label: const Text('浪浪別哭 官方網站'),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(300, 80),
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                OutlinedButton.icon(
                  onPressed:() async {
                    var url = Uri.parse("https://www.pettalk.tw");
                    await launchUrl(url);
                  },
                  icon: const Icon(Icons.pets_rounded),
                  label: const Text('pet talk 說寵物'),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(300, 80),
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
