# **Wheelie Good Eats**

## **Getting Started**

In the terminal, navigate to your preferred directory on your machine, and run: `git clone <link_to_this_repo>`

Once it has finished downloading, you can move into this directory with: `cd wheelie_good_eats`

Inside the directory, you will need to install and setup dependencies, as well as create, migrate, and seed the database with: `mix setup`

After setup is complete, you are ready to fire up your local instance of the application with: `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and use Wheelie Good Eats to browse SF food trucks.

## **What Does This App Do?**

Once you are live (no pun intended) in the browser, you will see a scrollable list of all the `APPROVED` food trucks from the city's permit office. (Technically, it's coming from a downloaded CSV file from their website that was parsed and seeded into your local database, but you get the point.)

On the root (`/`) view you will note 3 buttons:

- `PICK FOR ME`: Selects a random truck from the list for you to dine at. It renders your result at `/winner`.
- `NARROW IT DOWN`: Allows user to type an input into the text box (located above the button) and perform a query of the food trucks that match the food item entered. If no items match, you will get a message that says `Uh-oh, no matches. Craving something else?` at which point, you can enter a new input, or click either of the other buttons.
- `SHOW ALL`: Allows the user to quickly return to a display of all food tracks.

On the `/winner` view you will see 2 buttons:

- `ROLL AGAIN`: If you are not happy with the food truck that was selected for you, you can "roll again" and a new recommendation will appear on the screen.
- `BACK TO ALL TRUCKS`: As suggested this button will take you back to the root view with all the trucks displayed again.

## **Testing**

A few initial tests have been added. To run the tests execute:

- `mix test` to run all tests once and stop.
- `mix test.interactive` to run all tests and remain active, watching for additional changes. This option will also allow you to isolate where it is watching for changes, or which files you wish to run tests against. Once it is running, you can simply type `?` in the terminal to see the different options.

## **Next Steps**

Next steps would be:

- Add ability to be a registered user and favorite trucks/save queries.

- Add more tests, including an end-to-end.

- Add error handling in the event the server crashes or a query fails.
