//
//  Extensions and Protocols.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import Foundation
import SwiftUI
public enum LoadingState: Equatable {
    public static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case let (.failure(error1), .failure(error2)):
                return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
    
    case none
    case loading
    case success
    case failure(Error)
}

extension View {
    func getScreenBounds() -> CGRect {
        let bounds = UIScreen.main.bounds
        let width = min(bounds.width, bounds.height)
        let height = max(bounds.width, bounds.height)
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}

protocol APIServiceProtocol {
    func fetch(request: URLRequest?) async -> Result<Data, NetworkError>
}

extension Data {
    func printJSON(debugTitle: String) {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print("------\(debugTitle)")
            print(JSONString)
            print("------\(debugTitle)")
        }
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
            // Get connected scenes
        return self.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}

public extension UIFont {
    static func textStyleSize(_ style: UIFont.TextStyle) -> CGFloat {
        UIFont.preferredFont(forTextStyle: style).pointSize
    }
}
