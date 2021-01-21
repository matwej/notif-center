# Interview assignment
new project - ​ the backend for a new notification center​ . Admins should be able to
set up these notifications and clients should be able to get the latest notifications relevant for them.

Implementation and deliverable

Your implementation will be a Rails 5 project:
- ​ Ruby on Rails​ ​ 5 ​ language
- ​ Postgresql 12​ database
- You can use any gems if you consider them needed
- ​ The result​ will be a link to a git repository

Functionality
Develop a program in which your project manager can create “notification messages” for your company clients.
Those notifications need to be delivered to your clients through the company REST API.

You will need to deliver the following features:
- 2 roles: Admins and Clients
- ​ Admins​ are able to create notifications for ​ clients​ ; each notification has at least a date, a title, a description
- ​ The client​ is able to use a REST API to get all his notifications
- ​ Admin​ has to know if a new notification has been seen by the ​ client
