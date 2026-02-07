# Exercise

## General Information

This exercise is divided into two parts:
- **Part 1**: Improvements to the existing Pokedex project
- **Part 2**: Create a new application from scratch

---

# Part 1: Pokedex Improvements

In this part, you will work with the Pokedex project we have developed in class. You must implement the following improvements:

---

## 1.1 Programmatic Search Bar (20 points)

### Objective
Add a search bar (`UISearchController`) to the Pokémon list that allows filtering by name.

### Requirements
- [ ] The search bar must be created **programmatically**
- [ ] It must integrate with the `UINavigationController`
- [ ] Filtering must be done in the `PokemonListViewModel`
- [ ] Search must be **case-insensitive**. You must be able to search by Pokémon name and number
- [ ] The table must update in real-time as the user types
- [ ] When the search text is cleared, the complete list must be shown

---

## 1.2 Nested Properties: Weaknesses and Evolutions (25 points)

### Objective
Update the data model and detail view to show each Pokémon's weaknesses and evolutions.

### Requirements
- [ ] Update `Pokemon.swift` to decode the `weaknesses`, `next_evolution`, and `prev_evolution` properties
- [ ] Create an `Evolution` struct with `name` and `num` properties
- [ ] Display **weaknesses** in the `PokemonDetailViewController`
- [ ] Display **previous evolutions** if they exist
- [ ] Display **next evolutions** if they exist
- [ ] The design must be clear and readable

---

## 1.3 Navigation to Evolution Detail (15 points)

### Objective
Allow the user to tap on an evolution and navigate to that Pokémon's detail.

### Requirements
- [ ] Evolutions must be **tappable**
- [ ] When tapping an evolution, it must open the `PokemonDetailViewController` with the selected Pokémon's information
- [ ] Navigation must work for both previous and next evolutions
- [ ] If the evolution Pokémon is not found in the list, show an alert indicating it

---

## 1.4 Close Button on Map Modal (5 points)

### Objective
Add a button to easily close the modal that shows the Pokémon's location.

### Requirements
- [ ] Add a close button (X) in the top right corner of `PokemonLocationViewController`
- [ ] The button must be created **programmatically**
- [ ] When tapped, it must close the modal (`dismiss`)
- [ ] The button must be clearly visible over the map

---

## 1.5 Location Permission Alert (15 points)

### Objective
Show an alert when the user has not granted location permissions.

### Requirements
- [ ] Detect when location permission is denied or restricted
- [ ] Show a `UIAlertController` explaining that permissions are needed
- [ ] The message must be clear and friendly
- [ ] Include an "OK" button that closes the map modal

### Hints
- Check the `locationManagerDidChangeAuthorization(_:)` method from `CLLocationManagerDelegate`
- Check `CLAuthorizationStatus` states: `.denied`, `.restricted`

---

## 1.6 ViewModel for PokemonLocationViewController (20 points)

### Objective
Create a ViewModel to separate business logic from the view in `PokemonLocationViewController`.

### Requirements
- [ ] Create a new file `PokemonLocationViewModel.swift`
- [ ] The ViewModel must handle:
  - Pokémon information (name, location)
  - Pokémon image
  - `CLLocationManager` and its configuration
  - Location authorization status
- [ ] Create a **protocol/delegate** to communicate changes to the ViewController
- [ ] The ViewController **MUST NOT** have any `CLLocationManager` logic
- [ ] The ViewController should only:
  - Configure the UI
  - Respond to ViewModel notifications
  - Update the map when the ViewModel indicates

---

# Part 2: "Don Bigotes" App 🐱

In this part, you will create a new application. The app will display information about a fictional pet store chain called "Don Bigotes" (Mr. Whiskers).

---

## General Description

The application will have **3 screens**:

1. **Home Screen**: Chain information and button to view branches
2. **Branch List**: TableView with all branches
3. **Branch Detail**: Complete information with integrated map

---

## 2.1 Initial Setup (5 points)

### Requirements
- [ ] Create a new Xcode project called "DonBigotes"
- [ ] Configure the project to use **programmatic UIKit**
- [ ] Configure `SceneDelegate` to start the app programmatically
- [ ] Add the `don_bigotes.json` file to the project
- [ ] Add location permission in `Info.plist`

---

## 2.2 Data Models (15 points)

### Requirements
- [ ] Create the necessary models to decode the JSON
- [ ] All models must conform to `Codable`
- [ ] Correctly handle days that are closed

---

## 2.3 Home Screen (20 points)

### Requirements
- [ ] Create `HomeViewController` programmatically
- [ ] Create `HomeViewModel` to manage data
- [ ] Display:
  - Store logo (image from URL or placeholder)
  - Chain name (large font)
  - Slogan
  - Description (in a scroll view if necessary)
  - "View Branches" button
- [ ] The button must navigate to the branch list


## 2.4 Branch List (20 points)

### Requirements
- [ ] Create `BranchListTableViewController`
- [ ] Create `BranchListViewModel`
- [ ] Each cell must show:
  - Branch name
  - Address
- [ ] When selecting a cell, navigate to the branch detail
- [ ] Navigation must be with **push** (inside a `UINavigationController`)

---

## 2.5 Branch Detail with Map (40 points)

### Requirements
- [ ] Create `BranchDetailViewController` programmatically
- [ ] Create `BranchDetailViewModel`
- [ ] The screen must show **in the same view**:
  - Branch name
  - Full address
  - Phone number
  - Opening hours (Monday-Friday, Saturday, Sunday)
  - If a day is closed, show "Closed"
  - List of available services
  - **Map with the branch location**
- [ ] The map must:
  - Show a **pin** at the branch location
  - Have an **appropriate zoom** to clearly see the location
  - **NOT** need to show user location
- [ ] The design must use `UIScrollView` to allow scrolling if content is long
- [ ] The map must have a fixed size (e.g., 300 pts height)

---

## Suggested Project Structure

```
DonBigotes/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Models/
│   ├── Store.swift
│   ├── Branch.swift
│   └── OpeningHours.swift
├── Home/
│   ├── HomeViewController.swift
│   └── HomeViewModel.swift
├── BranchList/
│   ├── BranchListViewController.swift
│   └── BranchListViewModel.swift
├── BranchDetail/
│   ├── BranchDetailViewController.swift
│   └── BranchDetailViewModel.swift
├── Resources/
│   └── don_bigotes.json
└── Info.plist
```

---

## Extra Points (Optional)

- **+10 points**: Add a search bar in the branch list
- **+5 points**: Implement Dark Mode correctly
- **-10 points**: Use of `print` statements


**Good luck! 🍀**
