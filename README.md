# NYTimes
User Stories
- This App Create in Swift 4.0  with Xcode Version 10.0 and minimum Deplyment Target is 9.0 

- First Create single app and add pod in app for calling web-service 

- Pod Create with terminal
    - Pod init
        - Add in pod file 
            - pod 'Alamofire'
            - pod 'SwiftyJSON' 
            
- Then after Pod Install

- Add Project Helper, Progress bar , Constant, 

- In Helper 
    - WebService Helper
    - For Get and post Web-service method implement
    - MBProgress HUD
-For user wait for calling web-services
    - Helper File   
    - In Helper File apply method when we use on multiple screen

- View Contains  StoryBoard for the app and apply Design on them
- Controller  Contains Group of folder which have differentiate appdelegate, viewcontroller
- Constant Contains Static file which have use in app like colour file

- NY TimesList VC
    - This view Controller contains List of most popular view articles and show in list 
    - Get api call for this ""http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=a69e1cdbb16b4f23841c8f01be77f31a"
    - Get api Call and render in Tableview and show the initial data
    - For Image create extension for image load

- NYTimes Details VC 
    - When Click on Particular articles to navigate details page 
    - In this details page load url which have contains in json 

- Usage
- Download or Clone of Project and run in Xcod
    - all the set up is don after that run in simulator and check how it works

-Testing 
    Unit Test with Simulator 





    
