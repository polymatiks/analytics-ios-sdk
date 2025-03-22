# Polymatiks Analytics iOS SDK

A lightweight Swift-based analytics SDK for tracking ecommerce user behavior via Firebase Analytics.

---

## 🚀 Features

- Simple event-based tracking for ecommerce apps
- Mirrors the official Polymatiks JavaScript SDK
- Designed for integration with your own iOS app
- Firebase-based, supports environment variable config

---

## 🧩 Installation (via Swift Package Manager)

1. In Xcode, go to:
   **File → Add Packages...**

2. Use this URL:

   ```
   https://github.com/polymatiks/analytics-ios-sdk
   ```

3. Select the latest version and finish the wizard.

---

## ⚙️ Firebase Setup

**1. Add the following environment variables to your scheme:**

- Go to: `Product > Scheme > Edit Scheme > Run > Arguments`
- Under "Environment Variables", add:

```env
POLYMATIKS_APP_ID=1:XXXXXXXXX:ios:XXXXXXXXXXXXX
POLYMATIKS_SENDER_ID=XXXXXXXXX
POLYMATIKS_EVENT_API_KEY=XXXXXXXXXXXXXXXXXXXXXXXX
POLYMATIKS_PROJECT_ID=polymatiks-analytics-dev
```

You’ll get these values from Polymatiks when onboarding.

---

## 🧱 AppDelegate Setup

In your project, create a file called `AppDelegate.swift`:

```swift
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        if FirebaseApp.app() == nil {
            let options = FirebaseOptions(
                googleAppID: ProcessInfo.processInfo.environment["POLYMATIKS_APP_ID"] ?? "",
                gcmSenderID: ProcessInfo.processInfo.environment["POLYMATIKS_SENDER_ID"] ?? ""
            )
            options.apiKey = ProcessInfo.processInfo.environment["POLYMATIKS_EVENT_API_KEY"] ?? ""
            options.projectID = ProcessInfo.processInfo.environment["POLYMATIKS_PROJECT_ID"] ?? ""
            options.bundleID = Bundle.main.bundleIdentifier ?? ""

            FirebaseApp.configure(options: options)
        }

        return true
    }
}
```

Then add this to your `@main` app struct:

```swift
@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
```

---

## 🧪 Testing with DebugView (optional)

To test in Firebase DebugView, go to:
**Product > Scheme > Edit Scheme > Run > Arguments**, and add:

```
-FIRAnalyticsDebugEnabled
```

---

## 📈 Usage

In your view or controller:

```swift
import PolymatiksAnalytics

let analytics = PolymatiksAnalytics(customerId: "yourCustomerId", cartId: "yourCartId")

analytics.viewProductPageEvent(product: [
    "id": "123",
    "name": "Sample Product",
    "price": 29.99
])
```
> ℹ️ All events will automatically include the `customerId` and `cartId` values provided during initialization.  
> You do **not** need to include them manually in your event parameters.

### Other Supported Events

```swift
analytics.viewProductHomeEvent(product, position)
analytics.viewProductCategoryEvent(product, categoryId, page, position)
analytics.viewProductSearchEvent(product, term, page, position)
analytics.viewProductEvent(eventName, product, eventData)
analytics.addProductCartEvent(product, amount)
analytics.removeProductCartEvent(product)
analytics.changeProductCartEvent(product, amount)
```

---

## 📬 Support

For integration support, contact: `support@polymatiks.ai`

---

## 🧾 License

This SDK is proprietary and intended for use only by licensed Polymatiks customers.  
Contact support@polymatiks.ai for license terms and integration approval.