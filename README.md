
Project is built in storyboard using MVVM.
Combine is used for API calls.
App supports ipad/iphones and been tested on all sizes.
Unit tests included.

The  primary view controller is Home.
The detail view controller is DetailVC.

Home            - dataApiCall() call the combine api and passes the data to refactorData.
                      -  refactorAndInsertIntoViewModel is within an external struct CleanData. 
                      - The function takes data from the api call and inputs it into the viewModel then passes it back using a completion or throwing if there is an error or incomplete data.
                      - didSet within the cell binds the data to the cell.

DetailVC        - modally appears and displays the ID.

HttpClient        - Contains Combine API calls.

DataModels      - Contains the models and viewModels.

Orientation change is supported.

Images from the api take a long time to load. 
A basic loading placeholder is inserted into the cashe while the data is attempting to load. 
If the load fails, then the system house image is inserted into the cashe. 
If the load succeeds, then the proper image is inserted into the cashe. 
If the loading of the image times out, then a house image is inserted into the cashe and it's marked within the cashe that it timed out so that it will attempt to load the image again in the future. 

There is a loading icon behind the tableview on the Home VC. It is hidden as  soon as data loads. Alternately a tableview  cell explainging that the content is loading could have been created to display when the relevant count is 0. Or an animation gif.

