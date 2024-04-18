# **Wheelie Good Eats**

## **Getting Started**

In the terminal, navigate to your preferred directory on your machine, and run: `git clone <link_to_this_repo>`

Once it has finished downloading, you can move into this directory with: `cd wheelie_good_eats`

Inside the directory, you will need to install and setup dependencies, as well as create, migrate, and seed the database with: `mix setup`

After setup is complete, you are ready to fire up your local instance of the application with: `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and use Wheelie Good Eats to browse SF food trucks.

## **What Does This App Do?**

Once you are live (no pun intended) in the browser, you will see a scrollable list of all the `APPROVED` food trucks from the city's permit office. (Technically, it's coming from a downloaded CSV file from their website that was parsed and seeded into your local database, but it simulates the concept.)

On the root (`/`) view you will note 2 buttons and a search box:

- `PICK FOR ME`: Selects a random truck from the list for you to dine at. It renders your result in the primary card display area.
- `REFRESH`: Allows the user to quickly return to a display of all food tracks.
- `SEARCH BOX`: Allows user to type an input into the text box and perform a query of the food trucks that match the string entered (ideally an actual food item). If no items match, you will get a message that says `Uh-oh, no matches. Craving something else?` at which point, you can enter a new input, or click either of the other buttons. If you click the search icon without entering at least one character in the search box, you will received a pop-up error message informing you that you need to enter something in the input box in order to execute the search function.

## **Testing**

A few initial tests have been added. To run the tests execute:

- `mix test` to run all tests once and stop.
- `mix test.interactive` to run all tests and remain active, watching for additional changes. This option will also allow you to isolate where it is watching for changes, or which files you wish to run tests against. Once it is running, you can simply type `?` in the terminal to see the different options.
