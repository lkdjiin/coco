Feature: Running a project
As a developper
I want to run a project
So that I am aware of the coverage of my code

Scenario: Developper sees the summary on stdout
Given a default configuration
When I run the project
Then I can see the summary
