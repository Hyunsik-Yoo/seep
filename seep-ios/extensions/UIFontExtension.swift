import UIKit

extension UIFont {
    
    static func appleLight(size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeo-Light", size: size)
    }
    
    static func appleRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeo-Regular", size: size)
    }
    
    /// Weight: 500
    static func appleMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeo-Medium", size: size)
    }
    
    static func appleSemiBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeo-SemiBold", size: size)
    }
    
    static func appleBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeo-Bold", size: size)
    }
    
    /// Weight: 800
    static func appleExtraBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeoEB00", size: size)
    }
    
    static func appleUltraLight(size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeo-UltraLight", size: size)
    }
}
