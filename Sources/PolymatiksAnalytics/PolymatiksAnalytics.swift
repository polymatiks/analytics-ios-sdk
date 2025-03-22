import Foundation
import FirebaseCore
import FirebaseAnalytics

public class PolymatiksAnalytics {
    
    private var customerId: String
    private var cartId: String

    public init(customerId: String, cartId: String) {
        self.customerId = customerId
        self.cartId = cartId

        configureFirebase()
    }

    private func configureFirebase() {
        if FirebaseApp.app() == nil {
            print("🔥 Configuring Firebase inside SDK...")

            let appID = ProcessInfo.processInfo.environment["POLYMATIKS_APP_ID"] ?? ""
            let senderID = ProcessInfo.processInfo.environment["POLYMATIKS_SENDER_ID"] ?? ""
            let apiKey = ProcessInfo.processInfo.environment["POLYMATIKS_EVENT_API_KEY"] ?? ""
            let projectID = ProcessInfo.processInfo.environment["POLYMATIKS_PROJECT_ID"] ?? ""

            let options = FirebaseOptions(googleAppID: appID, gcmSenderID: senderID)
            options.apiKey = apiKey
            options.projectID = projectID
            options.bundleID = Bundle.main.bundleIdentifier ?? "com.default.bundle"

            FirebaseApp.configure(options: options)
            print("✅ Firebase manually initialized inside SDK for Bundle ID: \(options.bundleID)")
        }
    }

    public func logEvent(eventName: String, parameters: [String: Any]?) {
        // Ensure Firebase is initialized before logging events
        guard FirebaseApp.app() != nil else {
            print("❌ Firebase is not initialized. Skipping event: \(eventName)")
            return
        }
        
        Analytics.logEvent(eventName, parameters: parameters)
        print("✅ Logged event: \(eventName)")
    }

    public func viewProductPageEvent(product: [String: Any]) {
        Analytics.logEvent("view_product_page", parameters: product)
    }

    public func viewProductHomeEvent(product: [String: Any], position: Int) {
        var eventParams = product
        eventParams["position"] = position
        Analytics.logEvent("view_product_home", parameters: eventParams)
    }

    public func viewProductCategoryEvent(product: [String: Any], categoryId: String, page: Int, position: Int) {
        var eventParams = product
        eventParams["category_id"] = categoryId
        eventParams["page"] = page
        eventParams["position"] = position
        Analytics.logEvent("view_product_category", parameters: eventParams)
    }

    public func viewProductSearchEvent(product: [String: Any], term: String, page: Int, position: Int) {
        var eventParams = product
        eventParams["search_term"] = term
        eventParams["page"] = page
        eventParams["position"] = position
        Analytics.logEvent("view_product_search", parameters: eventParams)
    }

    public func viewProductEvent(eventName: String, product: [String: Any], eventData: [String: Any]) {
        var eventParams = product
        eventParams.merge(eventData) { (_, new) in new }
        Analytics.logEvent(eventName, parameters: eventParams)
    }

    public func addProductCartEvent(product: [String: Any], amount: Int) {
        var eventParams = product
        eventParams["amount"] = amount
        Analytics.logEvent("add_product_cart", parameters: eventParams)
    }

    public func removeProductCartEvent(product: [String: Any]) {
        Analytics.logEvent("remove_product_cart", parameters: product)
    }

    public func changeProductCartEvent(product: [String: Any], amount: Int) {
        var eventParams = product
        eventParams["amount"] = amount
        Analytics.logEvent("change_product_cart", parameters: eventParams)
    }
}
