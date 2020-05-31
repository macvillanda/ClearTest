# CLEAR Test

### Installation/Run
XCode Version: 11.3.1
Swift: 5.0

The project includes all PODS dependencies and should run without running a `pod install`.

### Architecture
The app uses the architecture 
![MVVM-C](https://marcosantadev.com/wp-content/uploads/mvvm-c.jpg?v=1)

Every viewcontroller will have a viewmodel. The **Viewmodel** will be reponsible for the business logic and will feed the data to the view. The **Viewcontroller** is just a view whereas it's only reponsibility is to render the data provided by the **ViewModel**. The **Model** is just a struct/class that represents the data that will be retrieved in the apis. The **Coordinator** will be responsible for routing in the app like pushing, presenting and dismissing viewcontrollers. To complete the binding between the **ViewModel** and **View** the app uses [RXSwift](https://github.com/ReactiveX/RxSwift) to bind and make the **ViewModel** data reactive so that the view will be notified of the changes instantaneously.