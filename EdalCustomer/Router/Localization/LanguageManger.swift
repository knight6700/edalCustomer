//
//  LanguageManger.swift

import UIKit

class LanguageManger {
    
    /// Returns the singleton LanguageManger instance.
    static let shared: LanguageManger = LanguageManger()
    
    /// Returns the currnet language
    var currentLanguage: Languages {
        get {
            
            guard let currentLang = UserDefaults.standard.string(forKey: "currentLanguage") else {
                // set selectedLanguage if it is not set yet.
                let localeLanguage = Locale.current.languageCode!
                UserDefaults.standard.set(localeLanguage, forKey: "currentLanguage")
                UserDefaults.standard.synchronize()
                return Languages(rawValue: localeLanguage)!
            }
            return Languages(rawValue: currentLang)!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "currentLanguage")
        }
    }
    
    /// Returns the diriction of the language
    var isRightToLeft: Bool {
        get {
            let lang = currentLanguage.rawValue
            return lang.contains("ar") || lang.contains("he") || lang.contains("ur") || lang.contains("fa")
        }
    }
    
    /// Returns the app locale for use it in dates and currency
    var appLocale: Locale {
        get {
            return Locale(identifier: currentLanguage.rawValue)
        }
    }
    
    ///
    /// Set the current language for the app
    ///
    /// - parameter language: The language that you need from the app to run with
    ///
    func setLanguage(language: Languages) {
        
        // change the dircation of the views
        let semanticContentAttribute:UISemanticContentAttribute = language == .ar ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = semanticContentAttribute
        
        // change app language
        UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        // set current language
        currentLanguage = language
    }
    
    func updateSwipeGesture(of nav: UINavigationController?){
        // this is should be called every time we have a new stack of controllers,
        // else will make the swipe happens in a wrong way when the user change language
        let semanticContentAttribute:UISemanticContentAttribute = currentLanguage == .ar ? .forceRightToLeft : .forceLeftToRight
        nav?.view.semanticContentAttribute = semanticContentAttribute
        nav?.navigationBar.semanticContentAttribute = semanticContentAttribute
    }
}

enum Languages:String {
    case ar,en,nl,ja,ko,vi,ru,sv,fr,es,pt,it,de,da,fi,nb,tr,el,id,ms,th,hi,hu,pl,cs,sk,uk,hr,ca,ro,he
    case enGB = "en-GB"
    case enAU = "en-AU"
    case enCA = "en-CA"
    case enIN = "en-IN"
    case frCA = "fr-CA"
    case esMX = "es-MX"
    case ptBR = "pt-BR"
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
    case zhHK = "zh-HK"
}


// MARK: String extension
extension String {
    
    ///
    /// Localize the current string to the selected language
    ///
    /// - returns: The localized string
    ///
    func localize() -> String {
        guard let bundle = Bundle.main.path(forResource: LanguageManger.shared.currentLanguage.rawValue, ofType: "lproj") else {
            return NSLocalizedString(self, comment: "")
        }
        
        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: "")
    }
    
}


// MARK: Swizzling
extension UIView {
    static func localiz() {
        
        let orginalSelector = #selector(awakeFromNib)
        let swizzledSelector = #selector(swizzledAwakeFromNib)
        
        let orginalMethod = class_getInstanceMethod(self, orginalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod!), method_getTypeEncoding(orginalMethod!))
        } else {
            method_exchangeImplementations(orginalMethod!, swizzledMethod!)
        }
        
    }
    
    @objc func swizzledAwakeFromNib() {
        swizzledAwakeFromNib()
        
        switch self {
        case let txtf as UITextField:
            txtf.text = txtf.text?.localize()
        case let lbl as UILabel:
            lbl.text = lbl.text?.localize()
        case let btn as UIButton:
            btn.setTitle(btn.title(for: .normal)?.localize(), for: .normal)
        default:
            break
        }
    }
    func scale() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
             pulse.fromValue = 1.40
             pulse.toValue = 1.0
             pulse.duration = pulse.settlingDuration
             self.layer.add(pulse, forKey: nil)
    }
}








