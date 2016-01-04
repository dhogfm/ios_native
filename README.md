# GoFundMe

Native iOS App  

### Project Configs
* Debug
* Release Ad Hoc
* Release App Store

### Preprocessor Macros
* Debug: DEBUG  
* Release Ad Hoc: ADHOC, PRODUCTION  
* Release App Store: APPSTORE, PRODUCTION  

### Cocoapods
* [Moya](https://github.com/Moya/Moya) v5.3.0 - Framework for network abstraction layer
* [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) v4.0.0 - Framework for functional reactive programming 
* [RealmSwift](https://realm.io/docs/swift/latest/) v0.97.0 - Framework for model layer

### Application Architecture
The application is built following the [MVVM](http://www.sprynthesis.com/2014/12/06/reactivecocoa-mvvm-introduction/)(Model View View-Model) design pattern, using ReactiveCocoa 4.0 for the bindings.
