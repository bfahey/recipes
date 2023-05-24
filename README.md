# Recipes App

## Overview

The Recipes app demonstrates how you can isolate your model and networking layer into a reusable and testable Swift Package. This has four key benefits:

1. Composability — this architecture allows you easily import your code into app extensions, widgets, and more

2. Encapsulation — the `RecipeAPI` protocol exposes functionality of the API without leaking implementation details

3. Testablity — it makes the API easily testable with mocks and fixtures. 

4. Speed to market — mocking APIs is a great way to structure our app for SwiftUI Previews so we can quickly create apps that are more flexible and maintainable
