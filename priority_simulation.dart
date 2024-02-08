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

    // Customer? nextCustomer;

    while (completed == false) {
      Customer? nextCustomer;
      for (var i = 0; i < customers.length; i++) {
        var customer = customers[i];
        if (customer.customerData["arrival"] <= currentTime &&
            customer.customerData["servedTime"] <
                customer.customerData["serviceTime"] &&
            (nextCustomer == null ||
                customer.customerData["priority"] <
                    nextCustomer.customerData["priority"])) {
          nextCustomer = customer;
        }
      }

      if (nextCustomer != null) {
        // Perform the necessary modifications directly on the customer object
        if (!nextCustomer.customerData.containsKey("startTime")) {
          nextCustomer.customerData["startTime"] = currentTime;
        }
        if (nextCustomer.customerData["priority"] == 1 &&
            nextCustomer.customerData["servedTime"] <
                nextCustomer.customerData["serviceTime"]) {
          nextCustomer.customerData["servedTime"] +=
              nextCustomer.customerData["serviceTime"];
          currentTime += nextCustomer.customerData["serviceTime"];
          continue;
        } else if (nextCustomer.customerData["priority"] == 2 &&
            nextCustomer.customerData["servedTime"] <
                nextCustomer.customerData["serviceTime"]) {
          // if (!nextCustomer.customerData.containsKey("startTime")) {
          //   nextCustomer.customerData["startTime"] = currentTime;
          // }
          nextCustomer.customerData["servedTime"]++;
          currentTime++;
          continue;
        } else if (nextCustomer.customerData["priority"] == 3 &&
            nextCustomer.customerData["servedTime"] <
                nextCustomer.customerData["serviceTime"]) {
          // if (!nextCustomer.customerData.containsKey("startTime")) {
          //   nextCustomer.customerData["startTime"] = currentTime;
          // }
          nextCustomer.customerData["servedTime"]++;
          currentTime++;
          continue;
        }
      }

      completed = allCustomersServed();
      print("executing");
      currentTime++;
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
