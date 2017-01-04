# Towards Better Split View Controllers (I): Our Custom Split Controller
UISplitViewController is one of the most basic controllers in iOS, and can be found in many Apple applications. However, when you have a look at 3rd party applications, specially those that mind the details, you will notice that it’s not a very popular choice. Why is that? Well, there are several reasons. First of all, its appearance configuration options are really limited, what you see is what you get. You cannot really mess with the structure of the master-detail frame, their sizes, the segue animations and a lot of other things without hacking around with it, but the most important limitation of UISplitViewController is the fact that all detail screens have to share the same format and structure.

This last restriction is specially important if you want to use the split view controller for displaying different contextual pieces of information. Let’s say that you have an entity like a user with personal information, job position, location, associated credentials, etc, and you might want to use different screens for that, showing a map in the location screen, a table for the personal information, and some textfield for changing the password in the credentials screen. UISplitViewController wouldn’t be a good fit for that, because all detail screens should have the same structure, only different data.

In these scenarios, we need to develop a custom split view controller to meet our needs. In this post, we are going to do exactly that.

## Our application
Our application will manage a list of users, and, when clicking on a user, it will show a custom split view controller with three sections:
* A screen with details about the user, including the name, email, birth date, etc. This screen will allow editing the information fields for the user (by segueing to a new screen).
* A screen showing a map with the location of the user
* A screen with the credentials, including the userID, and a field to change the user’s password.

This is the respository with the source code for the post found here:
http://digitalleaves.com/blog/2017/01/towards-better-split-view-controllers-i-our-custom-split-controller/
