import 'package:crash_free_mobile_app/api/VehicleApi.dart';
import 'package:crash_free_mobile_app/models/ApiResponse.dart';
import 'package:crash_free_mobile_app/models/Vehicle.dart';
import 'package:crash_free_mobile_app/util/toast.dart';
import 'package:flutter/material.dart';

class AddEditVehiclePage extends StatelessWidget {
  
  final Vehicle vehicle;

  // receive data from the FirstScreen as a parameter
  AddEditVehiclePage({Key key, this.vehicle}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: vehicle.id != null ? Text("Update Vehicle") : Text("Add Vehicle"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: VehicleForm(vehicle: vehicle),
      )
    );
  }
}

// Create a Form widget.
class VehicleForm extends StatefulWidget {

  final Vehicle vehicle;

  const VehicleForm({Key key, this.vehicle}) : super(key: key);

  @override
  VehicleFormState createState() {
    return VehicleFormState(vehicle);
  }
}

class VehicleFormState extends State<VehicleForm> {
  final _formKey = GlobalKey<FormState>();
  Vehicle vehicle;
  VehicleFormState(this.vehicle);
  bool dialogVisible = false; 

  ApiResponse response;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(child: 
      Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Vehicle No',
            ),
            initialValue: vehicle != null ? vehicle.vehicleNo : null,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your vehicle no';
              }
              return null;
            },
            onChanged: (String value) {  
                setState(() {  
                  vehicle.vehicleNo = value;
                });  
              },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Brand',
            ),
            initialValue: vehicle != null ? vehicle.brand : null,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your vehcile brand';
              }
              return null;
            },
            onChanged: (String value) {  
                setState(() {  
                  vehicle.brand = value;  
                });  
              },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Model',
            ),
            initialValue: vehicle != null ? vehicle.model : null,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your vehcile model';
              }
              return null;
            },
            onChanged: (String value) {  
                setState(() {  
                  vehicle.model = value;     
                });  
              },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Vehcile Type',
            ),
            initialValue: vehicle != null ? vehicle.type : null,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your vehicle type';
              }
              return null;
            },
            onChanged: (String value) {  
                setState(() {  
                  vehicle.type = value;    
                });  
              },
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child : Padding(
              padding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
              child: vehicle.id != null ? 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {                                                                          
                          showLoaderDialog(context);
                          await updateVehicle(vehicle).then((value) => {
                              response = value,
                              showSuccess(response.response),
                              Navigator.of(context, rootNavigator: true).pop(),
                              Navigator.pop(context)
                            });                                                
                          
                        }
                      },
                      child: Text('UPDATE VEHICLE'),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {                                                                          
                          showLoaderDialog(context);
                          await deleteVehicle(vehicle).then((value) => {
                              response = value,
                              showSuccess(response.response),
                              Navigator.of(context, rootNavigator: true).pop(),
                              Navigator.pop(context)
                            });
                        }
                      },
                      child: Text('DELETE VEHICLE'),
                    ),
                    
                ],
              ) : 

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {                                                                          
                          showLoaderDialog(context);
                          await saveVehicle(vehicle).then((value) => {
                              response = value,
                              showSuccess(response.response),
                              Navigator.of(context, rootNavigator: true).pop()
                            });                                                
                        }
                      },
                      child: Text('ADD VEHICLE'),
                    ),
                    
                ],
              )

            )
          )
        ],
      ),
    )
    );
  }
}

showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }