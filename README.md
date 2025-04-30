# real_estate_app_dtt

A real estate app built in Flutter as part of a technical assessment for a mobile development internship at **DTT Media**.

---

## Overview

This application displays a list of real estate properties retrieved from a remote API. Users can:
- View an overview list of properties (sorted by price, cheapest first)
- Search properties by zip code
- Tap a property to view detailed information
- See a pin on the map for the property's location
- Tap the map to launch Google Maps for navigation
- Handle missing search results with a friendly empty state

The design closely follows the workflow UI provided in the assignment.

---

## Features

- Built in **Flutter (3.29.3 stable)**
- **Clean architecture** using `models`, `services`, and `screens`
- Data loaded via HTTP with custom headers
- JSON deserialization into typed model
- Google Maps integration with markers and directions
- SVG icons rendering
- Platform navigation (e.g. back button, bottom navigation)
- Location permission (to be extended)

---

## Tested On

-  Android (SDK 26+)
-  Flutter 3.29.3 (stable)

> iOS was not tested due to platform limitations
