# Firebase-TODO-List

ToDo List managed in thi application.

To run this app in your device please change GoogleService-info.plist file first.

We uses a firebase realtime database to implement this.

It loads your todo list and sync with firebase realtime database.

This can be use as offline and online ToDo List. When device has no internet connection and you add your todo list. this will keep in your device and it will automatically get sync when device get internet connection. You can add / edit / delete your todo list while you are offline. 

# Test Cases:
- User is online and added new  todo task it reflacted on firebase realtime database.
- We added new todo list while device is offline. When got internet connection this is reflected on firebase realtime database 
- if user adds new firebase data from firebase console. Newly added data will automataclly shown on device.
