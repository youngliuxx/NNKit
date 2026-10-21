//
//  LYAlertViewHelper.swift
//
//  Created by Liu Yang on 26/10/2017.
//

import UIKit
import PanModal

// MARK: - LYAlertConfig
/// 弹窗样式与主题配置模型（支持全局默认配置与单次独立配置，原生支持浅色与深色模式自适应）
public class LYAlertConfig: NSObject, NSCopying {
    
    /// 全局默认配置实例（单例）
    public static var shared = LYAlertConfig()
    
    // MARK: - 暗黑模式开关
    /// 是否开启暗黑模式动态自适应（默认 true）
    public var enableDarkMode: Bool = true
    
    // MARK: - 弹窗背景颜色
    /// 弹窗容器背景色（浅色模式，默认纯白 #FFFFFF）
    public var backgroundColor: UIColor? = .white
    /// 弹窗容器背景色（深色模式，默认深灰 #2C2C2E）
    public var darkBackgroundColor: UIColor? = "#2C2C2E".color()
    
    // MARK: - 标题颜色
    /// 标题文字颜色（浅色模式，默认黑色 #000000）
    public var titleColor: UIColor? = .black
    /// 标题文字颜色（深色模式，默认纯白 #FFFFFF）
    public var darkTitleColor: UIColor? = .white
    
    // MARK: - 内容 / 副标题文字颜色
    /// 内容文字颜色（浅色模式，默认灰色 #808080）
    public var messageColor: UIColor? = k_808080
    /// 内容文字颜色（深色模式，默认浅灰 #E0E0E0）
    public var darkMessageColor: UIColor? = "#E0E0E0".color()
    
    // MARK: - 确认按钮（主按钮 / 右侧按钮）
    /// 确认按钮文字颜色（浅色模式，默认纯白 #FFFFFF）
    public var confirmTitleColor: UIColor? = NNKitConfirmTitleColor
    /// 确认按钮文字颜色（深色模式，默认纯白 #FFFFFF）
    public var darkConfirmTitleColor: UIColor? = NNKitConfirmTitleColor
    /// 确认按钮背景颜色（浅色模式，默认品牌主色 NNKitConfirmBackColor / #FF9B27）
    public var confirmBackgroundColor: UIColor? = NNKitConfirmBackColor
    /// 确认按钮背景颜色（深色模式，默认品牌主色 NNKitConfirmBackColor / #FF9B27）
    public var darkConfirmBackgroundColor: UIColor? = NNKitConfirmBackColor
    
    // MARK: - 取消按钮（次按钮 / 左侧按钮）
    /// 取消按钮文字颜色（浅色模式，默认灰 #B2B2B2）
    public var cancelTitleColor: UIColor? = k_B2B2B2
    /// 取消按钮文字颜色（深色模式，默认浅灰 #A0A0A0）
    public var darkCancelTitleColor: UIColor? = "#A0A0A0".color()
    /// 取消按钮背景颜色（浅色模式，默认浅灰底 #F9F9F9）
    public var cancelBackgroundColor: UIColor? = k_F9F9F9
    /// 取消按钮背景颜色（深色模式，默认深灰底 #3A3A3C）
    public var darkCancelBackgroundColor: UIColor? = "#3A3A3C".color()
    
    // MARK: - 圆角与尺寸微调
    /// 弹窗容器圆角（默认 12.0）
    public var cornerRadius: CGFloat = 12.0
    /// 按钮圆角（默认 6.0）
    public var buttonCornerRadius: CGFloat = 6.0
    
    // MARK: - 初始化
    public override init() {
        super.init()
    }
    
    public convenience init(
        backgroundColor: UIColor? = .white,
        darkBackgroundColor: UIColor? = "#2C2C2E".color(),
        titleColor: UIColor? = .black,
        darkTitleColor: UIColor? = .white,
        messageColor: UIColor? = k_808080,
        darkMessageColor: UIColor? = "#E0E0E0".color(),
        confirmTitleColor: UIColor? = NNKitConfirmTitleColor,
        darkConfirmTitleColor: UIColor? = NNKitConfirmTitleColor,
        confirmBackgroundColor: UIColor? = NNKitConfirmBackColor,
        darkConfirmBackgroundColor: UIColor? = NNKitConfirmBackColor,
        cancelTitleColor: UIColor? = k_B2B2B2,
        darkCancelTitleColor: UIColor? = "#A0A0A0".color(),
        cancelBackgroundColor: UIColor? = k_F9F9F9,
        darkCancelBackgroundColor: UIColor? = "#3A3A3C".color(),
        cornerRadius: CGFloat = 12.0,
        buttonCornerRadius: CGFloat = 6.0,
        enableDarkMode: Bool = true
    ) {
        self.init()
        self.backgroundColor = backgroundColor
        self.darkBackgroundColor = darkBackgroundColor
        self.titleColor = titleColor
        self.darkTitleColor = darkTitleColor
        self.messageColor = messageColor
        self.darkMessageColor = darkMessageColor
        self.confirmTitleColor = confirmTitleColor
        self.darkConfirmTitleColor = darkConfirmTitleColor
        self.confirmBackgroundColor = confirmBackgroundColor
        self.darkConfirmBackgroundColor = darkConfirmBackgroundColor
        self.cancelTitleColor = cancelTitleColor
        self.darkCancelTitleColor = darkCancelTitleColor
        self.cancelBackgroundColor = cancelBackgroundColor
        self.darkCancelBackgroundColor = darkCancelBackgroundColor
        self.cornerRadius = cornerRadius
        self.buttonCornerRadius = buttonCornerRadius
        self.enableDarkMode = enableDarkMode
    }
    
    // MARK: - 动态颜色解析方法
    /// 辅助方法：构建根据暗黑模式动态切换的 UIColor
    public static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { trait in
                return trait.userInterfaceStyle == .dark ? dark : light
            }
        }
        return light
    }
    
    /// 解析当前弹窗背景颜色
    public func resolveBackgroundColor() -> UIColor {
        guard enableDarkMode else { return backgroundColor ?? .white }
        if let dark = darkBackgroundColor {
            let light = backgroundColor ?? .white
            return LYAlertConfig.dynamicColor(light: light, dark: dark)
        }
        return backgroundColor ?? UIColor.systemThemeBackgroudColor(darkColor: "#2C2C2E".color())
    }
    
    /// 解析当前标题文字颜色
    public func resolveTitleColor() -> UIColor {
        guard enableDarkMode else { return titleColor ?? .black }
        if let dark = darkTitleColor {
            let light = titleColor ?? .black
            return LYAlertConfig.dynamicColor(light: light, dark: dark)
        }
        return titleColor ?? UIColor.systemThemeTextColor()
    }
    
    /// 解析当前内容/副标题文字颜色
    public func resolveMessageColor() -> UIColor {
        guard enableDarkMode else { return messageColor ?? k_808080 }
        if let dark = darkMessageColor {
            let light = messageColor ?? k_808080
            return LYAlertConfig.dynamicColor(light: light, dark: dark)
        }
        return messageColor ?? UIColor.systemThemeTextColor(darkColor: "#E0E0E0".color())
    }
    
    /// 解析当前确认按钮文字颜色
    public func resolveConfirmTitleColor() -> UIColor {
        guard enableDarkMode else { return confirmTitleColor ?? NNKitConfirmTitleColor }
        if let dark = darkConfirmTitleColor {
            let light = confirmTitleColor ?? NNKitConfirmTitleColor
            return LYAlertConfig.dynamicColor(light: light, dark: dark)
        }
        return confirmTitleColor ?? NNKitConfirmTitleColor
    }
    
    /// 解析当前确认按钮背景颜色
    public func resolveConfirmBackgroundColor() -> UIColor {
        guard enableDarkMode else { return confirmBackgroundColor ?? NNKitConfirmBackColor }
        if let dark = darkConfirmBackgroundColor {
            let light = confirmBackgroundColor ?? NNKitConfirmBackColor
            return LYAlertConfig.dynamicColor(light: light, dark: dark)
        }
        return confirmBackgroundColor ?? NNKitConfirmBackColor
    }
    
    /// 解析当前取消按钮文字颜色
    public func resolveCancelTitleColor() -> UIColor {
        guard enableDarkMode else { return cancelTitleColor ?? k_B2B2B2 }
        if let dark = darkCancelTitleColor {
            let light = cancelTitleColor ?? k_B2B2B2
            return LYAlertConfig.dynamicColor(light: light, dark: dark)
        }
        return cancelTitleColor ?? UIColor.systemThemeTextColor(k_B2B2B2, darkColor: "#A0A0A0".color())
    }
    
    /// 解析当前取消按钮背景颜色
    public func resolveCancelBackgroundColor() -> UIColor {
        guard enableDarkMode else { return cancelBackgroundColor ?? k_F9F9F9 }
        if let dark = darkCancelBackgroundColor {
            let light = cancelBackgroundColor ?? k_F9F9F9
            return LYAlertConfig.dynamicColor(light: light, dark: dark)
        }
        return cancelBackgroundColor ?? UIColor.systemThemeBackgroudColor(k_F9F9F9, darkColor: "#3A3A3C".color())
    }
    
    // MARK: - 链式便捷设置
    @discardableResult
    public func setBackgroundColor(light: UIColor?, dark: UIColor? = nil) -> Self {
        self.backgroundColor = light
        self.darkBackgroundColor = dark ?? light
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        self.darkBackgroundColor = nil
        return self
    }
    
    @discardableResult
    public func setTitleColor(light: UIColor?, dark: UIColor? = nil) -> Self {
        self.titleColor = light
        self.darkTitleColor = dark ?? light
        return self
    }
    
    @discardableResult
    public func setTitleColor(_ color: UIColor?) -> Self {
        self.titleColor = color
        self.darkTitleColor = nil
        return self
    }
    
    @discardableResult
    public func setMessageColor(light: UIColor?, dark: UIColor? = nil) -> Self {
        self.messageColor = light
        self.darkMessageColor = dark ?? light
        return self
    }
    
    @discardableResult
    public func setMessageColor(_ color: UIColor?) -> Self {
        self.messageColor = color
        self.darkMessageColor = nil
        return self
    }
    
    @discardableResult
    public func setConfirmButton(titleColor: UIColor?, backgroundColor: UIColor?, darkTitleColor: UIColor? = nil, darkBackgroundColor: UIColor? = nil) -> Self {
        self.confirmTitleColor = titleColor
        self.darkConfirmTitleColor = darkTitleColor ?? titleColor
        self.confirmBackgroundColor = backgroundColor
        self.darkConfirmBackgroundColor = darkBackgroundColor ?? backgroundColor
        return self
    }
    
    @discardableResult
    public func setCancelButton(titleColor: UIColor?, backgroundColor: UIColor?, darkTitleColor: UIColor? = nil, darkBackgroundColor: UIColor? = nil) -> Self {
        self.cancelTitleColor = titleColor
        self.darkCancelTitleColor = darkTitleColor ?? titleColor
        self.cancelBackgroundColor = backgroundColor
        self.darkCancelBackgroundColor = darkBackgroundColor ?? backgroundColor
        return self
    }
    
    // MARK: - 拷贝
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = LYAlertConfig()
        copy.enableDarkMode = self.enableDarkMode
        copy.backgroundColor = self.backgroundColor
        copy.darkBackgroundColor = self.darkBackgroundColor
        copy.titleColor = self.titleColor
        copy.darkTitleColor = self.darkTitleColor
        copy.messageColor = self.messageColor
        copy.darkMessageColor = self.darkMessageColor
        copy.confirmTitleColor = self.confirmTitleColor
        copy.darkConfirmTitleColor = self.darkConfirmTitleColor
        copy.confirmBackgroundColor = self.confirmBackgroundColor
        copy.darkConfirmBackgroundColor = self.darkConfirmBackgroundColor
        copy.cancelTitleColor = self.cancelTitleColor
        copy.darkCancelTitleColor = self.darkCancelTitleColor
        copy.cancelBackgroundColor = self.cancelBackgroundColor
        copy.darkCancelBackgroundColor = self.darkCancelBackgroundColor
        copy.cornerRadius = self.cornerRadius
        copy.buttonCornerRadius = self.buttonCornerRadius
        return copy
    }
    
    public func duplicate() -> LYAlertConfig {
        return self.copy() as! LYAlertConfig
    }
}

/// 兼容老代码的全局暗黑模式变量（联动 LYAlertConfig.shared.enableDarkMode）
public var EnableAlertViewDarkMode: Bool {
    get {
        return LYAlertConfig.shared.enableDarkMode
    }
    set {
        LYAlertConfig.shared.enableDarkMode = newValue
    }
}

// MARK: - LYAlertViewHelper
public class LYAlertViewHelper: NSObject {
    public typealias RefreshCompletion = (_ succeeded: Bool, _ publicKey: String?, _ state: Int?) -> Void
    public typealias ConfirmCompletion = (_ action: UIAlertAction) -> Void
    public typealias CancelCompletion = (_ action: UIAlertAction) -> Void

    // MARK: - 全局默认样式配置
    /// 全局默认弹窗配置（修改此配置会作为所有未指定 config 弹窗的默认主题）
    public static var defaultConfig: LYAlertConfig {
        get { return LYAlertConfig.shared }
        set { LYAlertConfig.shared = newValue }
    }

    /// 便捷方法：全局统一配置弹窗样式（支持深浅色模式）
    public static func configure(
        backgroundColor: UIColor? = nil,
        darkBackgroundColor: UIColor? = nil,
        titleColor: UIColor? = nil,
        darkTitleColor: UIColor? = nil,
        messageColor: UIColor? = nil,
        darkMessageColor: UIColor? = nil,
        confirmTitleColor: UIColor? = nil,
        darkConfirmTitleColor: UIColor? = nil,
        confirmBackgroundColor: UIColor? = nil,
        darkConfirmBackgroundColor: UIColor? = nil,
        cancelTitleColor: UIColor? = nil,
        darkCancelTitleColor: UIColor? = nil,
        cancelBackgroundColor: UIColor? = nil,
        darkCancelBackgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        buttonCornerRadius: CGFloat? = nil,
        enableDarkMode: Bool? = nil
    ) {
        let config = LYAlertConfig.shared
        if let bg = backgroundColor { config.backgroundColor = bg }
        if let dbg = darkBackgroundColor { config.darkBackgroundColor = dbg }
        if let tc = titleColor { config.titleColor = tc }
        if let dtc = darkTitleColor { config.darkTitleColor = dtc }
        if let mc = messageColor { config.messageColor = mc }
        if let dmc = darkMessageColor { config.darkMessageColor = dmc }
        if let ctc = confirmTitleColor { config.confirmTitleColor = ctc }
        if let dctc = darkConfirmTitleColor { config.darkConfirmTitleColor = dctc }
        if let cbg = confirmBackgroundColor { config.confirmBackgroundColor = cbg }
        if let dcbg = darkConfirmBackgroundColor { config.darkConfirmBackgroundColor = dcbg }
        if let cnt = cancelTitleColor { config.cancelTitleColor = cnt }
        if let dcnt = darkCancelTitleColor { config.darkCancelTitleColor = dcnt }
        if let cnb = cancelBackgroundColor { config.cancelBackgroundColor = cnb }
        if let dcnb = darkCancelBackgroundColor { config.darkCancelBackgroundColor = dcnb }
        if let r = cornerRadius { config.cornerRadius = r }
        if let br = buttonCornerRadius { config.buttonCornerRadius = br }
        if let dark = enableDarkMode { config.enableDarkMode = dark }
    }

    // MARK: - 原生 UIAlertController 弹窗
    /*
     * 取消、确认按钮弹窗
     */
    static public func alertViewConfirmAndCancelWithTagert(_ target: UIViewController, _ title: String, _ content: String, _ confirmEvent: (ConfirmCompletion)?, cancelEvent: (CancelCompletion)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确认".localized, style: .default, handler: { (action) in
                confirmEvent?(action)
            }))
            alert.addAction(UIAlertAction.init(title: "取消".localized, style: .cancel, handler: { (action) in
                cancelEvent?(action)
            }))
            presentNormalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 取消、右按钮自定义文本弹窗
     */
    static public func alertViewCustomBtnTextAndCancelWithTagert(_ target: UIViewController, _ title: String, _ content: String, _ confirmTitle: String,_ confirmEvent: (ConfirmCompletion)?, cancelEvent: (CancelCompletion)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: confirmTitle, style: .default, handler: { (action) in
                confirmEvent?(action)
            }))
            alert.addAction(UIAlertAction.init(title: "取消".localized, style: .cancel, handler: { (action) in
                cancelEvent?(action)
            }))
            presentNormalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 确认按钮弹窗
     */
    static public func alertViewConfirmWithTagert(_ target: UIViewController, _ title: String, _ content: String, _ confirmEvent: (ConfirmCompletion)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let alert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确认".localized, style: .default, handler: { (action) in
                confirmEvent?(action)
            }))
            presentNormalVC(target: target, alert: alert)
        }
    }
    
    // MARK: - 自定义 PanModal 弹窗（支持样式配置与暗黑模式）
    
    /*
     * 自定义提示框(自定义确认文本按钮)
     */
    static public func customAlertViewConfirmWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, _ confirmEvent:(() -> Void)? = nil) {
        customAlertViewConfirmWithTarget(target, title, content, contentAliment, confirmButtonStr, config: nil, confirmEvent)
    }
    
    static public func customAlertViewConfirmWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, config: LYAlertConfig?, _ confirmEvent:(() -> Void)? = nil) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController(title: title, message: content, contentAligment:contentAliment, customBtnText: confirmButtonStr, customCancelBtnText: "取消", style: .confirm, confirmEvent: confirmEvent, cancelEvent: nil)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 自定义提示框(确认取消按钮)
     */
    static public func customAlertViewConfirmAndCancelWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        customAlertViewConfirmAndCancelWithTarget(target, title, content, config: nil, confirmEvent, cancelEvent: cancelEvent)
    }
    
    static public func customAlertViewConfirmAndCancelWithTarget(_ target: UIViewController, _ title: String, _ content: String, config: LYAlertConfig?, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, message: content, style: .confirmAndCancel, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 自定义提示框(自定义文本的确认按钮，取消按钮)
     */
    static public func customAlertViewCustomTextAndCancelWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customConfirmBtnText: String, _ customCancleBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        customAlertViewCustomTextAndCancelWithTarget(target, title, content, customConfirmBtnText, customCancleBtnText, config: nil, confirmEvent, cancelEvent: cancelEvent)
    }
    
    static public func customAlertViewCustomTextAndCancelWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customConfirmBtnText: String, _ customCancleBtnText: String, config: LYAlertConfig?, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, message: content, customBtnText: customConfirmBtnText, customCancelBtnText:customCancleBtnText, style: .confirmAndCancel, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 自定义提示框(自定义文本的确认按钮，取消按钮，title文字颜色)
     */
    static public func customAlertViewCustomTextAndCancelWithTitleColorTarget(_ target: UIViewController, _ title: String, _ titleColor: String, _ content: String, _ customBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        customAlertViewCustomTextAndCancelWithTitleColorTarget(target, title, titleColor, content, customBtnText, config: nil, confirmEvent, cancelEvent: cancelEvent)
    }
    
    static public func customAlertViewCustomTextAndCancelWithTitleColorTarget(_ target: UIViewController, _ title: String, _ titleColor: String, _ content: String, _ customBtnText: String, config: LYAlertConfig?, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, titleColor: titleColor, message: content, customBtnText: customBtnText, style: .confirmAndCancel, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 自定义提示框(标题和内容支持富文本)
     */
    static public func customAlertViewCustomAttributedTitleWith(_ target: UIViewController, _ attributedTitle: NSAttributedString?, _ attributedContent: NSAttributedString?, _ customBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)?) {
        customAlertViewCustomAttributedTitleWith(target, attributedTitle, attributedContent, customBtnText, config: nil, confirmEvent, cancelEvent: cancelEvent)
    }
    
    static public func customAlertViewCustomAttributedTitleWith(_ target: UIViewController, _ attributedTitle: NSAttributedString?, _ attributedContent: NSAttributedString?, _ customBtnText: String, config: LYAlertConfig?, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)?) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(attributedTitle: attributedTitle, message: attributedContent, customBtnText: customBtnText, style: .confirmAndCancel, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 自定义提示框(自定义确认文本按钮, 失败)
     */
    static public func customAlertViewConfirmFailureWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, _ confirmEvent:(() -> Void)?) {
        customAlertViewConfirmFailureWithTarget(target, title, content, contentAliment, confirmButtonStr, config: nil, confirmEvent)
    }
    
    static public func customAlertViewConfirmFailureWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, config: LYAlertConfig?, _ confirmEvent:(() -> Void)?) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController(title: title, message: content, contentAligment:contentAliment, customBtnText: confirmButtonStr, style: .confirm, result: .failure, confirmEvent: confirmEvent, cancelEvent: nil)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 自定义提示框(自定义确认文本按钮, 成功)
     */
    static public func customAlertViewConfirmSuccessWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, _ confirmEvent:(() -> Void)?) {
        customAlertViewConfirmSuccessWithTarget(target, title, content, contentAliment, confirmButtonStr, config: nil, confirmEvent)
    }
    
    static public func customAlertViewConfirmSuccessWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ contentAliment: NSTextAlignment? = .center, _ confirmButtonStr:String? = "确认".localized, config: LYAlertConfig?, _ confirmEvent:(() -> Void)?) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController(title: title, message: content, contentAligment:contentAliment, customBtnText: confirmButtonStr, style: .confirm, result: .success, confirmEvent: confirmEvent, cancelEvent: nil)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 自定义提示框(自定义文本的确认按钮，取消按钮，成功)
     */
    static public func customAlertViewCustomTextAndCancelSuccessWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        customAlertViewCustomTextAndCancelSuccessWithTarget(target, title, content, customBtnText, config: nil, confirmEvent, cancelEvent: cancelEvent)
    }
    
    static public func customAlertViewCustomTextAndCancelSuccessWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customBtnText: String, config: LYAlertConfig?, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, message: content, customBtnText: customBtnText, style: .confirmAndCancel, result: .success, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    /*
     * 自定义提示框(自定义文本的确认按钮，取消按钮，失败)
     */
    static public func customAlertViewCustomTextAndCancelFailureWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customBtnText: String, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        customAlertViewCustomTextAndCancelFailureWithTarget(target, title, content, customBtnText, config: nil, confirmEvent, cancelEvent: cancelEvent)
    }
    
    static public func customAlertViewCustomTextAndCancelFailureWithTarget(_ target: UIViewController, _ title: String, _ content: String, _ customBtnText: String, config: LYAlertConfig?, _ confirmEvent:(() -> Void)?, cancelEvent: (() -> Void)? ) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alert = CustomAlertViewController.init(title: title, message: content, customBtnText: customBtnText, style: .confirmAndCancel, result: .failure, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
            if let config = config {
                alert.config = config
            }
            presentPanModalVC(target: target, alert: alert)
        })
    }
    
    // MARK: - 统一快捷展示方法
    /// 统一弹窗展示方法（推荐使用，支持风格、文案、方向与自定义配置）
    @discardableResult
    static public func showAlert(
        target: UIViewController,
        title: String?,
        content: String?,
        style: CustomAlertViewController.Style = .confirmAndCancel,
        confirmTitle: String? = "确认".localized,
        cancelTitle: String? = "取消".localized,
        contentAlignment: NSTextAlignment = .center,
        direction: CustomAlertViewController.ConfirmBtnDirection = .right,
        config: LYAlertConfig? = nil,
        confirmEvent: (() -> Void)? = nil,
        cancelEvent: (() -> Void)? = nil
    ) -> CustomAlertViewController {
        let alert = CustomAlertViewController(
            title: title,
            message: content,
            contentAligment: contentAlignment,
            customBtnText: confirmTitle,
            customCancelBtnText: cancelTitle,
            style: style,
            confirmEvent: confirmEvent,
            cancelEvent: cancelEvent
        )
        if direction == .left {
            alert.alertView.isConfirmOnLeft = true
            alert.alertView.leftBtn.setTitle(confirmTitle, for: .normal)
            alert.alertView.rightBtn.setTitle(cancelTitle, for: .normal)
        }
        if let config = config {
            alert.config = config
        }
        presentPanModalVC(target: target, alert: alert)
        return alert
    }
    
    // MARK: - 内部转场方法
    /// fixbux: ViewController刚加载时，就弹出PanModal弹窗会导致背景图不显示
    private static func presentPanModalVC<T: PanModalPresentable>(target: UIViewController, alert: T) where T: UIViewController {
        let safeTarget: UIViewController = {
            if target.isBeingDismissed || target.view.window == nil {
                return (target.navigationController ?? target.tabBarController ?? target)
            }
            return target
        }()
        if abs(Date.init().timeIntervalSince1970 - recentLoadVCTimeInterval) < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                safeTarget.presentPanModal(alert)
            }
        } else {
            DispatchQueue.main.async(execute: { () in
                safeTarget.presentPanModal(alert)
            })
        }
    }
    
    /// fixbux: ViewController刚加载时，就弹出PanModal弹窗会导致背景图不显示
    private static func presentNormalVC<T: UIViewController>(target: UIViewController, alert: T) where T: UIViewController {
        let safeTarget: UIViewController = {
            if target.isBeingDismissed || target.view.window == nil {
                return (target.navigationController ?? target.tabBarController ?? target)
            }
            return target
        }()
        if abs(Date.init().timeIntervalSince1970 - recentLoadVCTimeInterval) < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                safeTarget.present(alert, animated: true)
            }
        } else {
            DispatchQueue.main.async(execute: { () in
                safeTarget.present(alert, animated: true)
            })
        }
    }
}
