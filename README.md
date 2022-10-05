# CoreDataTeams
A quick example to show CoreData in Swift/SwiftUI

In this app, you can create a team, which just takes in a name.  This is then saved as an Entity in Core Data.

Once you have a team, you can add players to that team.  A player has a First Name, Last Name, Number and Position.  This is also saved as an Entity in Core Data.

There is a One to Many relationship between Team and Player, meaning that a Team can have multiple players.

Both a Team and a Player can be deleted by swiping.  A Team has cascading deletion, meaning that if a Team is deleted, all of it's players are deleted as well.

Currently only a Player can be edited.  Select a player from a team and a Modal will be displayed showing all of their information.

The modal includes a couple options.  The fields can be edited, the player can switch teams or the player can be deleted.

Creating this little project helped me to better understand Core Data, hopefully it might help someone else as well.
