class Customer {
  Map<String, dynamic> customerData;
  // final int customer;
  // final int interarrival;
  // final int serviceTime;
  // final int priority;
  // final int arrival;
  // int? startTime;
  // int? endTime;
  // int servedTime = 0;

  Customer(this.customerData);
  // Customer(this.customer, this.interarrival, this.customerData["serviceTime"], this.customerData["priority"],
  //     this.customerData["arrival"]);
}

class PrioritySimulation {
  List<Customer> customers = [];
  allCustomersServed() {
    for (var customer in customers) {
      if (customer.customerData["servedTime"] !=
          customer.customerData["serviceTime"]) {
        return false;
      }
    }
    return true;
  }

  PrioritySimulation(List<Map<String, int>> data) {
    customers = [];
    for (var customerData in data) {
      var newCustomer = Customer(
        customerData,

        // customerData['customer']!,
        // customerData['interarrival']!,
        // customerData['serviceTime']!,
        // customerData['priority']!,
        // customerData['arrival']!,
      );
      customers.add(newCustomer);
    }
  }

  void simulate() {
    num currentTime = 0;
    bool completed = false;

    while (completed == false) {
      for (int i = 0; i < customers.length; i++) {
        if (customers[i].customerData["priority"] == 1 &&
            customers[i].customerData["servedTime"] <
                customers[i].customerData["serviceTime"] &&
            customers[i].customerData["arrival"] <= currentTime) {
          if (!customers[i].customerData.containsKey("startTime")) {
            customers[i].customerData["startTime"] = currentTime;
          }
          customers[i].customerData["servedTime"] +=
              customers[i].customerData["serviceTime"];
          currentTime += customers[i].customerData["serviceTime"];
          break;
        } else if (customers[i].customerData["priority"] == 2 &&
            customers[i].customerData["servedTime"] <
                customers[i].customerData["serviceTime"] &&
            customers[i].customerData["arrival"] <= currentTime) {
          if (!customers[i].customerData.containsKey("startTime")) {
            customers[i].customerData["startTime"] = currentTime;
          }
          customers[i].customerData["servedTime"]++;
          currentTime++;
          break;
        } else if (customers[i].customerData["priority"] == 3 &&
            customers[i].customerData["servedTime"] <
                customers[i].customerData["serviceTime"] &&
            customers[i].customerData["arrival"] <= currentTime) {
          if (!customers[i].customerData.containsKey("startTime")) {
            customers[i].customerData["startTime"] = currentTime;
          }
          customers[i].customerData["servedTime"]++;
          currentTime++;
          break;
        }
      }
      completed = allCustomersServed();
      print("inner loop status");
      for (var customer in customers) {
        print(customer.customerData);
      }
      // currentTime++;
    }
    for (var customer in customers) {
      print(customer.customerData);
    }
  }
}

void main() {
  List<Map<String, int>> data = [
    {
      'customer': 1,
      // 'interarrival': 4,
      'serviceTime': 7,
      "servedTime": 0,
      'priority': 2,
      "arrival": 0,
    },
    {
      'customer': 2,
      // 'interarrival': 3,
      'serviceTime': 9,
      "servedTime": 0,
      'priority': 3,
      "arrival": 2,
    },
    {
      'customer': 3,
      // 'interarrival': 3,
      'serviceTime': 9,
      "servedTime": 0,
      'priority': 1,
      "arrival": 3,
    },
  ];

  var prioritySimulation = PrioritySimulation(data);
  // prioritySimulation.customers.forEach((element) {
  //   print(element.customerData);
  // });
  prioritySimulation.simulate();
}


