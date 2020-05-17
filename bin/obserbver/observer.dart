void main() {
  var subject = Subject();
  var observer = ObserverOne(subject);
  var observer2 = ObserverTwo(subject);

  subject.setState(5.8);
  print('State of ObserverOne : ${observer.state}');
  print('State of ObserverTwo : ${observer2.state}');
}

///this class will notifie all the observers when state changed
class Subject {
  ///List of [Observer]'s that will notified
  List<Observer> observers = <Observer>[];

  dynamic _state;

  void setState(dynamic state) {
    _state = state;
    notifyObservers();
  }

  dynamic get state => _state;

  void registerObserver(Observer observer) {
    observers.add(observer);
  }

  void notifyObservers() {
    for (var observer in observers) {
      observer.update();
    }
  }
}

///this is abstract class
///will get notifyied whenevre state changed by [Subject]
abstract class Observer {
  ///use this object to regester itself and lestin to state
  Subject subject;

  ///this function called by [Subject] to modify Observer
  void update();
}

class ObserverOne implements Observer {
  @override
  var subject = Subject();
// observer register itself via constractor
  ObserverOne(this.subject) {
    subject.registerObserver(this);
  }
  var state;

  ///this function will called by [Subject] whnever state is changed
  @override
  void update() {
    print('${subject.state}');
    state = subject.state;
  }
}

class ObserverTwo implements Observer {
  ObserverTwo(this.subject) {
    subject.registerObserver(this);
  }

  var state;

  @override
  Subject subject;

  @override
  void update() {
    state = subject.state;
    print('${state}');
  }
}
