import "package:flutter/material.dart";
import "package:page_transition/page_transition.dart";
import "package:propertymaster/utilities/AppColors.dart";
import "package:propertymaster/utilities/AppStrings.dart";
import "package:propertymaster/utilities/Utility.dart";
import "package:propertymaster/views/dashboard/dashboard.dart";
import "package:propertymaster/views/resale-deal/AllProperty.dart";
import "package:propertymaster/views/resale-deal/SearchedPropertyList.dart";

const List<PropertyType> propertyTypeList = [
  PropertyType(value: AppStrings.plots, name: AppStrings.plots, icon: "assets/icons/plot.png"),
  PropertyType(value: AppStrings.office, name: AppStrings.commercialSpace, icon: "assets/icons/commercial-space.png"),
  PropertyType(value: AppStrings.flat, name: AppStrings.flat, icon: "assets/icons/flat.png"),
  PropertyType(value: AppStrings.villas, name: AppStrings.houseVilla, icon: "assets/icons/villa.png"),
];

const List<String> plotTypePropertyList = <String>[
  'Residential Plot',
  'Commercial Plot',
  'Industrial Land',
  'Farmhouse Land',
  'Agriculture Land',
];
const List<String> commercialTypePropertyList = <String>[
  'Office Space',
  'Commercial Space',
  'Showroom',
  'Godown',
  'Warehouse',
];
const List<String> flatHouseTypePropertyList = <String>[
  // 'Flat',
  'Row house',
  'Bungalows',
  'Villas',
];
const List<KeyValueClass> budgetFromList = <KeyValueClass>[
  KeyValueClass(value: "Min", name: 'Min'),
  KeyValueClass(value: "1500000", name: '15 Lakh'),
  KeyValueClass(value: "2000000", name: '20 Lakh'),
  KeyValueClass(value: "3000000", name: '30 Lakh'),
  KeyValueClass(value: "4000000", name: '40 Lakh'),
  KeyValueClass(value: "5000000", name: '50 Lakh'),
  KeyValueClass(value: "6000000", name: '60 Lakh'),
  KeyValueClass(value: "7000000", name: '70 Lakh'),
  KeyValueClass(value: "8500000", name: '85 Lakh'),
  KeyValueClass(value: "10000000", name: '1 cr'),
  KeyValueClass(value: "20000000", name: '2 cr'),
  KeyValueClass(value: "30000000", name: '3 cr'),
  KeyValueClass(value: "40000000", name: '4 cr'),
  KeyValueClass(value: "50000000", name: '5 cr'),
  KeyValueClass(value: "100000000", name: '10 cr'),
];
const List<KeyValueClass> budgetToList = <KeyValueClass>[
  KeyValueClass(value: "Max", name: 'Max'),
  KeyValueClass(value: "2000000", name: '20 Lakh'),
  KeyValueClass(value: "3000000", name: '30 Lakh'),
  KeyValueClass(value: "4000000", name: '40 Lakh'),
  KeyValueClass(value: "5000000", name: '50 Lakh'),
  KeyValueClass(value: "6000000", name: '60 Lakh'),
  KeyValueClass(value: "7000000", name: '70 Lakh'),
  KeyValueClass(value: "8500000", name: '85 Lakh'),
  KeyValueClass(value: "10000000", name: '1 cr'),
  KeyValueClass(value: "20000000", name: '2 cr'),
  KeyValueClass(value: "30000000", name: '3 cr'),
  KeyValueClass(value: "40000000", name: '4 cr'),
  KeyValueClass(value: "50000000", name: '5 cr'),
  KeyValueClass(value: "100000000", name: '10 cr'),
  KeyValueClass(value: "200000000", name: '20 cr'),
];

class SearchProperty extends StatefulWidget {
  const SearchProperty({super.key});

  @override
  State<SearchProperty> createState() => _SearchPropertyState();
}

class _SearchPropertyState extends State<SearchProperty> {
  var localityProjectLandmarkController = TextEditingController();
  String propertyType = "";
  String childrenPropertyType = "";
  String typeOfProperty = "";
  String budgetFrom = budgetFromList.first.value;
  String budgetTo = budgetToList.first.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(
          AppStrings.searchProperty,
          style: TextStyle(color: AppColors.white,),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15.0,),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.colorSecondary,
                      width: 1.0,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  color: AppColors.colorSecondary,
                ),
                child: const Text("Buy",style: TextStyle(color: AppColors.white,),),
              ),
              const SizedBox(height: 25.0,),
              const Text("Locality/Project/Landmark",style: TextStyle(fontWeight: FontWeight.bold,),),
              const SizedBox(height: 10.0,),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                decoration: containerDecoration,
                child: TextFormField(
                  controller: localityProjectLandmarkController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                  cursorColor: AppColors.textColorGrey,
                  decoration: inputDecoration(AppStrings.projectColonyName),
                ),
              ),
              const SizedBox(height: 25.0,),
              const Text(AppStrings.propertyType,style: TextStyle(fontWeight: FontWeight.bold,),),
              const SizedBox(height: 10.0,),
              // Row(
              //   children: [
              //     PlotType(
              //       heading: AppStrings.plots,
              //       image: "assets/icons/plot.png",
              //       isSelected:  propertyType == AppStrings.plots ? true : false,
              //       onChange: (value) {
              //         propertyType = value;
              //         typeOfProperty = "";
              //         childrenPropertyType = AppStrings.plotType;
              //         setState(() {});
              //       },
              //     ),
              //     const SizedBox(width: 5.0,),
              //     PlotType(
              //       heading: AppStrings.commercialSpace,
              //       image: "assets/icons/commercial-space.png",
              //       isSelected: propertyType == AppStrings.commercialSpace ? true : false,
              //       onChange: (value) {
              //         propertyType = value;
              //         typeOfProperty = "";
              //         childrenPropertyType = AppStrings.spaceType;
              //         setState(() {});
              //       },
              //     ),
              //     const SizedBox(width: 5.0,),
              //     PlotType(
              //       heading: AppStrings.flatHouseVilla,
              //       image: "assets/icons/flat.png",
              //       isSelected: propertyType == AppStrings.flatHouseVilla ? true : false,
              //       onChange: (value) {
              //         propertyType = value;
              //         typeOfProperty = "";
              //         childrenPropertyType = AppStrings.homeType;
              //         setState(() {});
              //       },
              //     ),
              //   ],
              // ),
              const SizedBox(height: 10.0,),
              SizedBox(
                height: 100.0,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: propertyTypeList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 5.0,),
                        child: PlotType(
                          heading: propertyTypeList[index].name,
                          value: propertyTypeList[index].value,
                          image: propertyTypeList[index].icon,
                          isSelected: propertyType == propertyTypeList[index].value ? true : false,
                          onChange: (value) {
                            propertyType = value;
                            typeOfProperty = "";
                            setState(() {});
                          },
                        ),
                      );
                    }
                ),
              ),
              propertyType == "" || propertyType == AppStrings.flat ? Container() :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25.0,),
                  Text(
                    propertyType == AppStrings.plots ? AppStrings.plotType : propertyType == AppStrings.office ? AppStrings.spaceType : AppStrings.homeType,
                    style: const TextStyle(fontWeight: FontWeight.bold,),
                  ),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    height: 100.0,
                    child: propertyType == AppStrings.plots ?
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: plotTypePropertyList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 5.0,),
                          child: PlotType(
                            heading: plotTypePropertyList[index],
                            value: plotTypePropertyList[index],
                            image: "assets/icons/plot.png",
                            isSelected: typeOfProperty == plotTypePropertyList[index] ? true : false,
                            onChange: (value) {
                              typeOfProperty = value;
                              setState(() {});
                            },
                          ),
                        );
                      }
                    ) :
                    propertyType == AppStrings.office ?
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: commercialTypePropertyList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 5.0,),
                            child: PlotType(
                              heading: commercialTypePropertyList[index],
                              value: commercialTypePropertyList[index],
                              image: "assets/icons/commercial-space.png",
                              isSelected: typeOfProperty == commercialTypePropertyList[index] ? true : false,
                              onChange: (value) {
                                typeOfProperty = value;
                                setState(() {});
                              },
                            ),
                          );
                        }
                    ) :
                    propertyType == AppStrings.villas ?
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: flatHouseTypePropertyList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 5.0,),
                            child: PlotType(
                              heading: flatHouseTypePropertyList[index],
                              value: flatHouseTypePropertyList[index],
                              image: "assets/icons/flat.png",
                              isSelected: typeOfProperty == flatHouseTypePropertyList[index] ? true : false,
                              onChange: (value) {
                                typeOfProperty = value;
                                setState(() {});
                              },
                            ),
                          );
                        }
                    ) :
                    null,
                  ),
                ],
              ),
              const SizedBox(height: 25.0,),
              const Text(AppStrings.budget,style: TextStyle(fontWeight: FontWeight.bold,),),
              const SizedBox(height: 5.0,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.colorSecondary,
                            width: 1.0,
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: BudgetFromDropdown(
                        reason: budgetFrom,
                        onChange: (newValue){
                          setState((){
                            budgetFrom = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.colorSecondary,
                            width: 1.0,
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: BudgetToDropdown(
                        reason: budgetTo,
                        onChange: (newValue){
                          setState((){
                            budgetTo = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
              InkWell(
                onTap: () {
                  // print("propertyType--------$propertyType");
                  // print("typeOfProperty--------$typeOfProperty");
                  // print("budgetFrom--------$budgetFrom");
                  // print("budgetTo--------$budgetTo");
                  navigateTo(context, SearchedPropertyList(
                    search: localityProjectLandmarkController.text,
                    propertyType: propertyType,
                    typeOfProperty: typeOfProperty,
                    budgetFrom: budgetFrom,
                    budgetTo: budgetTo,
                  ));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50.0,
                  decoration: BoxDecoration(color: AppColors.colorSecondary,borderRadius: BorderRadius.circular(50.0),),
                  child: const Text(
                    AppStrings.searchProperties,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0,color: AppColors.white,fontWeight: FontWeight.w700,),
                  ),
                ),
              ),
              const SizedBox(height: 15.0,),
            ],
          ),
        ),
      ),
    );
  }
}

class PlotType extends StatefulWidget {
  final String heading;
  final String value;
  final String image;
  final bool isSelected;
  final Function(String) onChange; // Callback function
  const PlotType({super.key,required this.heading,required this.value,required this.image,required this.isSelected,required this.onChange,});

  @override
  State<PlotType> createState() => _PlotTypeState();
}

class _PlotTypeState extends State<PlotType> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChange(widget.isSelected ? "" : widget.value);
        setState(() {});
      },
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0,),),
          border: Border.all(style: BorderStyle.solid,width: 1.0,color: AppColors.colorSecondaryLight2),
          color: widget.isSelected ? AppColors.colorSecondaryLight2 : AppColors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0,),
        // alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(widget.image), color: widget.isSelected == true ? AppColors.white : AppColors.black, width: 25.0,),
            const SizedBox(height: 10.0,),
            Text(widget.heading,style: TextStyle(fontSize: 12.0,color: widget.isSelected == true ? AppColors.white : AppColors.black),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}

class BudgetFromDropdown extends StatefulWidget {
  String reason;
  final Function(String) onChange; // Callback function
  BudgetFromDropdown({super.key,required this.reason,required this.onChange,});

  @override
  State<BudgetFromDropdown> createState() => _BudgetFromDropdownState();
}
class _BudgetFromDropdownState extends State<BudgetFromDropdown> {
  String dropdownValue = budgetFromList.first.value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.black,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: budgetFromList.map<DropdownMenuItem<String>>((KeyValueClass item) {
        return DropdownMenuItem<String>(
          value: item.value,
          child: Text(item.name),
        );
      }).toList(),
    );
  }
}

class BudgetToDropdown extends StatefulWidget {
  String reason;
  final Function(String) onChange; // Callback function
  BudgetToDropdown({super.key,required this.reason,required this.onChange,});

  @override
  State<BudgetToDropdown> createState() => _BudgetToDropdownState();
}
class _BudgetToDropdownState extends State<BudgetToDropdown> {
  String dropdownValue = budgetToList.first.value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.black,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: budgetToList.map<DropdownMenuItem<String>>((KeyValueClass item) {
        return DropdownMenuItem<String>(
          value: item.value,
          child: Text(item.name),
        );
      }).toList(),
    );
  }
}