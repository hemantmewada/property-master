// Future<void> realEstateDetailListingFirstLoadAPI(BuildContext context, bool isLoad) async {
//     if(isLoad){
//       Loader.ProgressloadingDialog(context, true);
//     }
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(Urls.leadsListUrl),
//       );
//       Map<String, String> header = {
//         "content-type": "application/json",
//         "accept": "application/json",
//         "x-api-key" : Utilities.xApiKey,
//       };
//       request.headers.addAll(header);
//       request.fields['user_id'] =  userID;
//       request.fields['role'] =  role;
//       request.fields['page'] =  widget.page;
//       request.fields['length'] =  _limit.toString();
//       request.fields['start'] =  _page.toString();
//       request.fields['searchParameter'] = searchParameter;
//       print(request.fields);
//       var response = await request.send();
//       if(isLoad){
//         Loader.ProgressloadingDialog(context, false);
//       }
//       response.stream.transform(convert.utf8.decoder).listen((event) async {
//         print(Urls.leadsListUrl);
//         Map<String, dynamic> map = convert.jsonDecode(event);
//         RealEstateListModel response = await RealEstateListModel.fromJson(map);
//         if(response.status == true) {
//           leadList!.clear();
//           phoneNumberController.clear();
//           leadList = response.data!.listing;
//           setState(() {});
//           if(leadList!.isEmpty){
//             Utilities().toast("No Data Found");
//           }
//         }else{
//           Utilities().toast(response.message);
//         }
//       });
//     } catch (e) {
//       Loader.ProgressloadingDialog(context, false);
//       Utilities().toast('error: $e');
//     }
//     return;
//   }