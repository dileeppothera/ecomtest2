import 'package:ecomtest2/helpers/api_provider.dart';
import 'package:ecomtest2/helpers/storage_helper.dart';
import 'package:ecomtest2/helpers/toast.dart';
import 'package:ecomtest2/views/customers/add_customer_response.dart';
import 'package:ecomtest2/views/customers/customers_response.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class CustomerController extends ChangeNotifier {
  bool customerLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController streetController1 = TextEditingController();
  TextEditingController streetController2 = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  CustomersResponse? customersResponse;
  ApiProvider repository = ApiProvider();

  CustomerController() {
    init();
    getCust();
  }

  init() async {
    var customers = await StorageHelper().readCustomers();
    if (customers != []) {
      customersResponse = CustomersResponse(
        data: customers,
      );
    }
  }

  void getCust() async {
    customerLoading = true;
    notifyListeners();
    Either<CustomersResponse, Failure> resp = await repository.getCustomers();
    resp.fold((l) async {
      if (customersResponse != null) {
        var flag = false;
        l.data!.forEach((lData) {
          for (var element in customersResponse!.data!) {
            if (element.id == lData.id) {
              flag = true;
            }
          }
          if (!flag) {
            customersResponse!.data!.add(lData);
          }
        });
      } else {
        customersResponse = l;
      }
      StorageHelper().storeCustomers(customersResponse!.data ?? []);

      customerLoading = false;
      notifyListeners();
    }, (r) {
      customerLoading = false;
      notifyListeners();
    });
  }

  void addCustomer(BuildContext context) async {
    if (validate(context)) {
      Either<AddCustomerResponse, Failure> resp = await repository.addCustomer(
        name: nameController.text,
        mail: emailController.text,
        state: stateController.text,
        street1: streetController1.text,
        street2: streetController2.text,
        country: countryController.text,
        city: cityController.text,
        mobile: mobileController.text,
        pincode: pincodeController.text,
      );
      resp.fold(
        (l) => appToast(context, l.message!),
        (r) => appToast(context, r.text!),
      );
      Navigator.pop(context);
      getCust();
    }
  }

  bool validate(BuildContext context) {
    if (nameController.text.isEmpty) {
      appToast(context, 'Enter a name');
      return false;
    }
    if (mobileController.text.isEmpty) {
      appToast(context, 'Enter a valid mobile number');
      return false;
    }
    if (!mobileController.text.contains(RegExp(r'(^[0-9]{10,12}$)'))) {
      appToast(context, 'Enter a valid mobile number');
      return false;
    }
    if (emailController.text.isEmpty) {
      appToast(context, 'Enter a valid email');
      return false;
    }
    if (streetController1.text.isEmpty) {
      appToast(context, 'Enter a street name');
      return false;
    }
    if (streetController2.text.isEmpty) {
      appToast(context, 'Enter a second street name');
      return false;
    }
    if (cityController.text.isEmpty) {
      appToast(context, 'Enter a city');
      return false;
    }
    if (pincodeController.text.isEmpty) {
      appToast(context, 'Enter a pincode');
      return false;
    }
    if (countryController.text.isEmpty) {
      appToast(context, 'Enter a country name');
      return false;
    }

    if (stateController.text.isEmpty) {
      appToast(context, 'Enter a state');
      return false;
    }

    return true;
  }
}
