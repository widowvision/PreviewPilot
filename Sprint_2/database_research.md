Just sticking this in here for future use since stuff in Discord tends to get buried.

For our database, at first i was thinking we might do a relational database in SQL-- this might still work since the designs will need to be modular to allow for further customization. However, I am seeing issues that might arise if we go with this strategy.

For 2D objects, I am not sure if we can effectively make 2D objects modular and allow for an overlay using AR/Camera/whatever. I imagine the database *might* be easier to put together with this strategy, and of course the database will be smaller and use fewer resources.

A 3D database will probably more effectively achieve the modular designs we want, and it will probably be easier (maybe??) to do the overlay with the pegboards (it also might be just as easy as 2D, I'm really not sure). My biggest concern with a 3D collection is making it efficient and not so large that it can't be efficiently run on mobile devices.

A relational database may end up being useful for finalized designs that are attached to a client and user as opposed to unattached designs or modular components. SQLite seems to go with flutter for this.

Maybe we'll end up going with a relational db for actual designs for clients, and some other alternative for the modular components?

Could look like this:

modular components in some collection

user creates design

user saves design to specific client (relational db comes in)

now a 1:M relation between a client and designs/configurations

Questions: 
- Are all modular pieces compatible with each other? How are the parts broken up? How to account for color/font changes? ALSO adding logos?

How can we efficiently create a collection for 2D/3d objects in a mobile app? Is a mixed approach going to be the most resource-efficient approach to this?
