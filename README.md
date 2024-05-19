# todo_concept

A todo application built using Flutter

### Functionality to test

Functionality, user should be able to:

    - [ ] Check/Uncheck existing tasks
    - [ ] Add new tasks
    - [ ] Edit existing tasks


### Simple Code Structure

The code is organized in the `./lib` folder following best practices easier maintainability. Here's the structure:

    - `lib/repositories`: Contains epositories (interfaces for data access).
    - `lib/domain`: Holds the BLoC patter in `./bloc`, business logic, entities and stores data models (`./models`)
    - `lib/presentation`: Contains UI widgets (TodoList, AddTodoScreen).
