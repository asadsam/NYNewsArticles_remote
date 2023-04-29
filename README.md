# NYNewsArticles_remote
A simple app to demonstrate understanding and use of Object Oreinted concepts(OOP), design patterns - structural (MVVM), test driven development (TDD), dependency injection (loosely coupled code), following SOLID principles, etc.

* shows list of most popular articles 
* shows details when clicked on an article
* Test case for NewsListViewModel
* UI test case for NewsList and DetailsView

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Test cases](#testcases)

## General info
Most popular articles app

## Technologies
Project is created with:
* Swift 5

## Installation

* Installation by cloning the repository
* Go to directory
* use command + B or Product -> Build to build the project
* Press run icon in Xcode or command + R to run the project on Simulator

# Architecture
This project uses MVVM design pattern and project is developed in Swift5.

## Test cases
* A simple text case for a view model - passing a mock web service object and see if the control calls the delegate method implemented inside this mock class
* A simple UI test case - launch the app to fetch and load the most popular articles, then tap on the first cell to see if the deatils are really fetched and loaded

# How to run the Test Cases
* There are a couple of ways to run or execute the test cases, one of which is as follows
* In the navigator tab which is usually located right above the projectname(xcodeproj file), select Test Navigator tab (which is usually the 5th tab).
* This will list out all the test cases written for the project 
* You can either execute individual test by right clicking on it and selecting 'run' or also by pressing the small button to the right corner of each test case.
* If the test case passes, the button next to the tests will turn green or else if the test case fails it will turn red separately for each individual tests.


