//
//  CustomAlertViewController.swift
//  NNHost
//
//  Created by ly on 2022/1/11.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa
//import Alamofire
//import Moya


class ViewName: UIView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    public convenience init(with frame: CGRect) {
        self.init(frame: frame)
    }
    func setupViews() {
        
    }
}

extension CustomAlertViewController {
    public enum Style: Int {
        /// 确认取消按钮
        case confirmAndCancel = 0
        /// 确认按钮
        case confirm = 1
    }
    /// 确认按钮的方向
    public enum ConfirmBtnDirection: Int {
        /// 确认左边
        case left = 0
        /// 确认右边
        case right = 1
    }
    
    public enum Result: Int {
        case failure = 0
        case success = 1
    }
}

public class CustomAlertViewController: UIViewController {
    let disposeBag = DisposeBag()
    public lazy var alertView: CustomAlertView = {
        let tmp = CustomAlertView.init()
        return tmp
    }()
    
    /// 样式配置属性（修改后立即生效）
    public var config: LYAlertConfig {
        get { return alertView.config }
        set { alertView.config = newValue }
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(title: String?, message: String?, style: CustomAlertViewController.Style, direction: ConfirmBtnDirection = .right, confirmEvent:(() -> Void)? , cancelEvent:(() -> Void)? ) {
        self.init()
        // 确认按钮在左边
        if direction == .left {
            alertView.isConfirmOnLeft = true
            alertView.leftBtn.setTitle("确认", for: .normal)
            alertView.rightBtn.setTitle("取消", for: .normal)
            setupEvent(confirmEvent: cancelEvent, cancelEvent: confirmEvent)
        } else {
            alertView.isConfirmOnLeft = false
            setupEvent(confirmEvent: confirmEvent, cancelEvent: cancelEvent)
        }
        alertView.titleLabel.text = title
        alertView.subTitleLabel.text = message
        alertView.style = style
    }
    
    public convenience init(title: String?, message: String?, style: CustomAlertViewController.Style, direction: ConfirmBtnDirection = .right, config: LYAlertConfig, confirmEvent:(() -> Void)?, cancelEvent:(() -> Void)?) {
        self.init(title: title, message: message, style: style, direction: direction, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
        self.config = config
    }
    
    public convenience init(title: String?, message: String?,contentAligment:NSTextAlignment? = .center , customBtnText: String?, customCancelBtnText: String?, style: CustomAlertViewController.Style, confirmEvent:(() -> Void)?, cancelEvent:(() -> Void)?) {
        self.init()
        alertView.isConfirmOnLeft = false
        setupEvent(confirmEvent: confirmEvent, cancelEvent: cancelEvent)
        alertView.titleLabel.text = title
        alertView.subTitleLabel.text = message
        if let contentAligment = contentAligment {
            alertView.subTitleLabel.textAlignment = contentAligment
        }
        alertView.style = style
        alertView.rightBtn.setTitle(customBtnText, for: .normal)
        alertView.leftBtn.setTitle(customCancelBtnText, for: .normal)
    }
    
    public convenience init(title: String?, message: String?,contentAligment:NSTextAlignment? = .center , customBtnText: String?, customCancelBtnText: String?, style: CustomAlertViewController.Style, config: LYAlertConfig, confirmEvent:(() -> Void)?, cancelEvent:(() -> Void)?) {
        self.init(title: title, message: message, contentAligment: contentAligment, customBtnText: customBtnText, customCancelBtnText: customCancelBtnText, style: style, confirmEvent: confirmEvent, cancelEvent: cancelEvent)
        self.config = config
    }
    
    public convenience init(title: String?, titleColor: String?, message: String?,contentAligment:NSTextAlignment? = .center , customBtnText: String?, style: CustomAlertViewController.Style, confirmEvent:(() -> Void)?, cancelEvent:(() -> Void)?) {
        self.init()
        alertView.isConfirmOnLeft = false
        setupEvent(confirmEvent: confirmEvent, cancelEvent: cancelEvent)
        alertView.titleLabel.text = title
        if let colorStr = titleColor, !colorStr.isEmpty {
            alertView.titleLabel.textColor = colorStr.color()
        }
        alertView.subTitleLabel.text = message
        if let contentAligment = contentAligment {
            alertView.subTitleLabel.textAlignment = contentAligment
        }
        alertView.style = style
        alertView.rightBtn.setTitle(customBtnText, for: .normal)
    }
    
    public convenience init(attributedTitle: NSAttributedString?, message: NSAttributedString?, contentAligment:NSTextAlignment? = .center , customBtnText: String?, style: CustomAlertViewController.Style, confirmEvent:(() -> Void)?, cancelEvent:(() -> Void)?) {
        self.init()
        alertView.isConfirmOnLeft = false
        setupEvent(confirmEvent: confirmEvent, cancelEvent: cancelEvent)
        alertView.titleLabel.attributedText = attributedTitle
        alertView.subTitleLabel.attributedText = message
        if let contentAligment = contentAligment {
            alertView.subTitleLabel.textAlignment = contentAligment
        }
        alertView.style = style
        alertView.rightBtn.setTitle(customBtnText, for: .normal)
    }
    
    public convenience init(title: String?, message: String?,contentAligment:NSTextAlignment? = .center , customBtnText: String?, style: CustomAlertViewController.Style, result: CustomAlertViewController.Result, confirmEvent:(() -> Void)?, cancelEvent:(() -> Void)?) {
        self.init()
        alertView.isConfirmOnLeft = false
        setupEvent(confirmEvent: confirmEvent, cancelEvent: cancelEvent)
        alertView.titleLabel.text = title
        alertView.subTitleLabel.text = message
        alertView.subTitleLabel.textAlignment = contentAligment!
        alertView.style = style
        alertView.result = result
        alertView.rightBtn.setTitle(customBtnText, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(alertView)
        alertView.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.left.equalTo(self.view).offset(38.0)
            make.right.equalTo(self.view).offset(-38.0)
        }
    }
    func setupEvent(confirmEvent: (() -> Void)?, cancelEvent: (() -> Void)? ) {
        alertView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            confirmEvent?()
        }).disposed(by: disposeBag)
        alertView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            cancelEvent?()
        }).disposed(by: disposeBag)
    }
}
extension CustomAlertViewController: PanModalPresentable {
    public var panScrollable: UIScrollView? {
        return nil
    }
    public var shortFormHeight: PanModalHeight {
        return .contentHeight(UIConstant.screenHeight())
    }
    public var showDragIndicator: Bool {
        return false
    }
    public func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return false
    }
}
