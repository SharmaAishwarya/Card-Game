Feature: a way to sign up for an account for the card game

  As a player
  I would like to create an account
  So that I can join games and play them

  Background: The following users have been added to database

    Given the following users exist:
    | username      | email                                | password      |
    | GrumpyBunny   | botiqueBooth@gmail.com               | 123           |
    | bablingCreek  | creepyLawyer@creepyLawyer.gov        | 1234          |
    | WarmBlanket   | Beethoven@vienna.edu                 | ;)            |
    | softPillow    | saltedButterWasAMistake@walmart.com  | glorrrious    |
    | rollingHills  | 300@thisIsSparta.com                 | PersiansSuck  |

    And I'm on the sign-up page

Scenario: Creating a new user account when the username and email are already taken
  When I try to create new account with username, email, password: "GrumpyBunny, botiqueBooth@gmail.com, 123"
  Then I should see a flash telling me it already exists

Scenario: Creating a new user account with fresh info
  When I try to create new account with username, email, password: "Glumps, glumps@gmail.com, 123"
  Then the following username/email combination exists: "Glumps, glumps@gmail.com"