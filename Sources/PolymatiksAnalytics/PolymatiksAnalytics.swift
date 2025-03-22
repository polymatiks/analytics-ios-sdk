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
        guard FirebaseApp.app() == nil else { return }

        let appID = ProcessInfo.processInfo.environment["POLYMATIKS_APP_ID"] ?? ""
        let senderID = ProcessInfo.processInfo.environment["POLYMATIKS_SENDER_ID"] ?? ""
        let apiKey = ProcessInfo.processInfo.environment["POLYMATIKS_EVENT_API_KEY"] ?? ""
        let projectID = ProcessInfo.processInfo.environment["POLYMATIKS_PROJECT_ID"] ?? ""

        let options = FirebaseOptions(googleAppID: appID, gcmSenderID: senderID)
        options.apiKey = apiKey
        options.projectID = projectID
        options.bundleID = Bundle.main.bundleIdentifier ?? "com.default.bundle"

        FirebaseApp.configure(options: options)
    }

    /// Logs a custom event with customerId and cartId automatically included
    public func logEvent(eventName: String, parameters: [String: Any] = [:]) {
        guard FirebaseApp.app() != nil else { return }

        var enrichedParams = parameters
        enrichedParams["customer_id"] = customerId
        enrichedParams["cart_id"] = cartId

        Analytics.logEvent(eventName, parameters: enrichedParams)
    }

    public func viewProductPageEvent(product: [String: Any]) {
        logEvent(eventName: "view_product_page", parameters: product)
    }

    public func viewProductHomeEvent(product: [String: Any], position: Int) {
        var params = product
        params["position"] = position
        logEvent(eventName: "view_product_home", parameters: params)
    }

    public func viewProductCategoryEvent(product: [String: Any], categoryId: String, page: Int, position: Int) {
        var params = product
        params["category_id"] = categoryId
        params["page"] = page
        params["position"] = position
        logEvent(eventName: "view_product_category", parameters: params)
    }

    public func viewProductSearchEvent(product: [String: Any], term: String, page: Int, position: Int) {
        var params = product
        params["search_term"] = term
        params["page"] = page
        params["position"] = position
        logEvent(eventName: "view_product_search", parameters: params)
    }

    public func viewProductEvent(eventName: String, product: [String: Any], eventData: [String: Any]) {
        var params = product
        params.merge(eventData) { _, new in new }
        logEvent(eventName: eventName, parameters: params)
    }

    public func addProductCartEvent(product: [String: Any], amount: Int) {
        var params = product
        params["amount"] = amount
        logEvent(eventName: "add_product_cart", parameters: params)
    }

    public func removeProductCartEvent(product: [String: Any]) {
        logEvent(eventName: "remove_product_cart", parameters: product)
    }

    public func changeProductCartEvent(product: [String: Any], amount: Int) {
        var params = product
        params["amount"] = amount
        logEvent(eventName: "change_product_cart", parameters: params)
    }
}