// //leetcode arrays problem#1
// class PrioritySimulation {

// }
// const data=[
// {
// customer=1,
// Interarrival=4,
// serviceTime=7,
// priority=2
// },
// {
// customer=2,
// Interarrival=3,
// serviceTime=9,
// priority=3
// },
// ]
// void main() {
//   PrioritySimulation solution = PrioritySimulation();

// }
class Customer {
  final int customer;
  final int interarrival;
  final int serviceTime;
  final int priority;
  int startTime = 0;
  int endTime = 0;
  int servedTime = 0;

  Customer(this.customer, this.interarrival, this.serviceTime, this.priority);
}

class PrioritySimulation {
  List<Customer> customers = [];

  PrioritySimulation(List<Map<String, int>> data) {
    customers = [];
    for (var customerData in data) {
      var newCustomer = Customer(
        customerData['customer']!,
        customerData['interarrival']!,
        customerData['serviceTime']!,
        customerData['priority']!,
      );
      customers.add(newCustomer);
    }
  }

  void simulate() {
    customers.sort((a, b) => b.priority.compareTo(a.priority)); // Sort customers by priority (highest first)
    int currentTime = 0;
    int currentPriorityIndex = 0;

    while (true) {
      // Serve the highest priority customer if they are already waiting
      while (currentPriorityIndex < customers.length &&
          customers[currentPriorityIndex].interarrival <= currentTime) {
        var currentCustomer = customers[currentPriorityIndex];
        if (currentCustomer.servedTime == 0) {
          currentCustomer.startTime = currentTime; // Set start time
        }
        currentCustomer.servedTime++;
        currentTime++;
        if (currentCustomer.servedTime == currentCustomer.serviceTime) {
          currentCustomer.endTime = currentTime; // Set end time
          currentCustomer.servedTime = 0; // Reset served time
          currentPriorityIndex++;
        }
      }

      // Check if all customers are served
      if (currentPriorityIndex == customers.length &&
          customers.every((customer) => customer.endTime != 0)) {
        break;
      }

      // If no customers are waiting, advance time to the next arrival
      if (currentPriorityIndex >= customers.length || customers[currentPriorityIndex].interarrival > currentTime) {
        currentTime = customers[currentPriorityIndex].interarrival;
      }
    }

    // Print arrival, start, and end times for each customer
    for (var customer in customers) {
      print('Customer ${customer.customer}: Start Time - ${customer.startTime}, End Time - ${customer.endTime}');
    }
  }
}

void main() {
  List<Map<String, int>> data = [
    {'customer': 1, 'interarrival': 4, 'serviceTime': 7, 'priority': 2},
    {'customer': 2, 'interarrival': 3, 'serviceTime': 9, 'priority': 3}
  ];

  var prioritySimulation = PrioritySimulation(data);
  prioritySimulation.simulate();
}
