//
//  CustomAlertView.swift
//  NNHost
//
//  Created by ly on 2022/1/11.
//

import UIKit

public class CustomAlertView: UIView {
    
    /// 样式配置对象（变更时自动刷新全部样式）
    public var config: LYAlertConfig = LYAlertConfig.shared {
        didSet {
            applyConfig()
        }
    }
    
    /// 确认按钮是否在左侧（影响左/右按钮颜色应用）
    public var isConfirmOnLeft: Bool = false {
        didSet {
            applyConfig()
        }
    }

    lazy var imageView: UIImageView = {
        let tmp = UIImageView.init()
        tmp.isHidden = true
        return tmp
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var subTitleLabel: UILabel = {
        let label = UILabel.init()
        label.font = .pingfang(14.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public lazy var leftBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("取消".localized, for: .normal)
        btn.titleLabel?.font = UIFont.pingfangBold(16)
        btn.layer.masksToBounds = true
        return btn
    }()
    
    public lazy var rightBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("确认".localized, for: .normal)
        btn.titleLabel?.font = UIFont.pingfangBold(16)
        btn.layer.masksToBounds = true
        return btn
    }()
    
    var style: CustomAlertViewController.Style? {
        didSet {
            switch style {
            case .confirmAndCancel:
                self.leftBtn.isHidden = false
                self.rightBtn.snp.remakeConstraints { make in
                    make.top.equalTo(subTitleLabel.snp.bottom).offset(38.0)
                    make.left.equalTo(self.snp.centerX).offset(6.0)
                    make.right.equalTo(self).offset(-22.0)
                    make.height.equalTo(46.0)
                    make.bottom.equalTo(self).offset(-20.0)
                }
            case .confirm:
                self.leftBtn.isHidden = true
                self.rightBtn.snp.remakeConstraints { make in
                    make.top.equalTo(subTitleLabel.snp.bottom).offset(38.0)
                    make.left.equalTo(self).offset(22.0)
                    make.right.equalTo(self).offset(-22.0)
                    make.height.equalTo(46.0)
                    make.bottom.equalTo(self).offset(-20.0)
                }
            case .none:
                break
            }
        }
    }
    
    var result: CustomAlertViewController.Result? {
        didSet {
            switch result {
            case .success:
                self.imageView.isHidden = false
                self.imageView.image = I$("success")
                titleLabel.snp.remakeConstraints { make in
                    make.top.equalTo(32.0)
                    make.centerX.equalToSuperview().offset(11.0)
                    make.left.greaterThanOrEqualTo(self).offset(35.0)
                }
            case .failure:
                self.imageView.isHidden = false
                self.imageView.image = I$("failure")
                titleLabel.snp.remakeConstraints { make in
                    make.top.equalTo(32.0)
                    make.centerX.equalToSuperview().offset(11.0)
                    make.left.greaterThanOrEqualTo(self).offset(35.0)
                }
            case .none:
                self.imageView.isHidden = true
                titleLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self).offset(32.0)
                    make.centerX.equalTo(self)
                    make.left.equalTo(self).offset(24.0)
                    make.right.equalTo(self).offset(-24.0)
                }
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(leftBtn)
        addSubview(rightBtn)
        layer.masksToBounds = true
        
        applyConfig()
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(32.0)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(24.0)
            make.right.equalTo(self).offset(-24.0)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(titleLabel.snp.left).offset(-4.0)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            make.left.equalTo(self).offset(24.0)
            make.right.equalTo(self).offset(-24.0)
        }
        leftBtn.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(38.0)
            make.right.equalTo(self.snp.centerX).offset(-6.0)
            make.left.equalTo(self).offset(22.0)
            make.height.equalTo(46.0)
            make.bottom.equalTo(self).offset(-20.0)
        }
        rightBtn.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(38.0)
            make.left.equalTo(self.snp.centerX).offset(6.0)
            make.right.equalTo(self).offset(-22.0)
            make.height.equalTo(46.0)
            make.bottom.equalTo(self).offset(-20.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 统一应用样式配置
    public func applyConfig() {
        backgroundColor = config.resolveBackgroundColor()
        layer.cornerRadius = config.cornerRadius
        
        titleLabel.textColor = config.resolveTitleColor()
        subTitleLabel.textColor = config.resolveMessageColor()
        
        let confirmTitleColor = config.resolveConfirmTitleColor()
        let confirmBgColor = config.resolveConfirmBackgroundColor()
        let cancelTitleColor = config.resolveCancelTitleColor()
        let cancelBgColor = config.resolveCancelBackgroundColor()
        let btnCornerRadius = config.buttonCornerRadius
        
        if isConfirmOnLeft {
            // 确认按钮在左侧
            leftBtn.setTitleColor(confirmTitleColor, for: .normal)
            leftBtn.backgroundColor = confirmBgColor
            leftBtn.layer.cornerRadius = btnCornerRadius
            leftBtn.layer.masksToBounds = true
            
            rightBtn.setTitleColor(cancelTitleColor, for: .normal)
            rightBtn.backgroundColor = cancelBgColor
            rightBtn.layer.cornerRadius = btnCornerRadius
            rightBtn.layer.masksToBounds = true
        } else {
            // 默认：取消按钮在左，确认按钮在右
            leftBtn.setTitleColor(cancelTitleColor, for: .normal)
            leftBtn.backgroundColor = cancelBgColor
            leftBtn.layer.cornerRadius = btnCornerRadius
            leftBtn.layer.masksToBounds = true
            
            rightBtn.setTitleColor(confirmTitleColor, for: .normal)
            rightBtn.backgroundColor = confirmBgColor
            rightBtn.layer.cornerRadius = btnCornerRadius
            rightBtn.layer.masksToBounds = true
        }
    }
    
    /// 监听系统深浅色切换，实时刷新弹窗颜色
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                applyConfig()
            }
        }
    }
}
