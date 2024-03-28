### Feedback Received from Jacob Peirce

The UI for the team’s program seems to be very user friendly. It’s all done in the Iphone simulation so far and the test runs well. The photo picking is easy and convenient. It will be a very functional and easy program to use once it is finished (which is the idea I believe). The dart code if clean and understandable, even though I don’t know dart, and if there are any ideas It looks likes they’ll be easy to locate and solve.

Questions:

- You had originally mentioned color selecting/editing features. Are these still getting implemented?
  
*We plan to implement the color changing as a stretch goal, but the current goals are to have a modular configuration system that allows the user to customize the model.*

- Will size and scale be changeable once the image has been chosen?:
  
*Scale and position of the overlay is currently working within the app. The user must use gestures on touchscreen to position (by dragging with one finger) or change size (pinch with two fingers to decrease scale, and zoom with two fingers to increase scale.) These parameters are also stored locally to keep track of any changes the user makes.*

- Will you be able to save each item somewhere within the app to come back to later or will it need to be configured each time?:
  
*This feature will be a sprint 4 goal. We want to create a gallery view of all of the current proofs that the user is working on, so that the user can easily modify and share multiple proofs at a time. Ideally the next team to take up this project would be able to make these proofs save to the remote database per customer, but we believe that is beyond the scope of our semester.*




### Feedback for Jacob Peirce, Reviewed by Noah Seavers**

The high-level design seems pretty easy to follow which files are interacting with other files/resources.  It makes understanding the big picture goal clear, which is important when there are a lot of moving parts. The most confusing aspect to me is the different configuration files and how they are interacted with by the user, but that is probably because I did not get to look heavily into it.

Overall the code structure for DetectAruco_PiSide.py is straightforward but the readability could be improved. Due to the lack of comments I had a hard time understanding what individual functions were doing. Going through the code I was able to follow what they did by starting at main(), but it could be more clearly organized using comments in the code. ( Without seeing the other files/resources the code is interacting with also could be causing some confusion on my end ). I also think that most of the variable names/function names are pretty clear for specific functions in the file.
