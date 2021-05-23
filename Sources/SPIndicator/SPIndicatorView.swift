// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.by)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

#if os(iOS)

class SPIndicatorView: UIView {
    
    // MARK: - Properties
    
    open var dismissByDrag: Bool = true
    open var completion: (() -> Void)? = nil
    
    // MARK: - Views
    
    open var titleLabel: UILabel?
    open var subtitleLabel: UILabel?
    open var iconView: UIView?
    
    private lazy var backgroundView: UIVisualEffectView = {
        let view: UIVisualEffectView = {
            if #available(iOS 13.0, *) {
                return UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
            } else {
                return UIVisualEffectView(effect: UIBlurEffect(style: .light))
            }
        }()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    weak open var presentWindow: UIWindow? = UIApplication.shared.windows.first
    
    // MARK: - Init
    
    public init(title: String, message: String? = nil, preset: SPIndicatorIconPreset) {
        super.init(frame: CGRect.zero)
        commonInit()
        layout = SPIndicatorLayout(for: preset)
        setTitle(title)
        if let message = message {
            setMessage(message)
        }
        setIcon(for: preset)
    }
    
    public init(message: String) {
        super.init(frame: CGRect.zero)
        commonInit()
        layout = SPIndicatorLayout.message()
        setMessage(message)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        preservesSuperviewLayoutMargins = false
        if #available(iOS 11.0, *) {
            insetsLayoutMarginsFromSafeArea = false
        }
        
        backgroundColor = .clear
        backgroundView.layer.masksToBounds = true
        addSubview(backgroundView)
        
        updateShadow()
    }
    
    // MARK: - Configure
    
    private func setTitle(_ text: String) {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold, addPoints: 0)
        label.numberOfLines = 1
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byTruncatingTail
        style.lineSpacing = 3
        label.attributedText = NSAttributedString(
            string: text, attributes: [.paragraphStyle: style]
        )
        label.textAlignment = .center
        label.textColor = UIColor.Compability.label.withAlphaComponent(0.5)
        titleLabel = label
        addSubview(label)
    }
    
    private func setMessage(_ text: String) {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold, addPoints: 0)
        label.numberOfLines = 1
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byTruncatingTail
        style.lineSpacing = 2
        label.attributedText = NSAttributedString(
            string: text, attributes: [.paragraphStyle: style]
        )
        label.textAlignment = .center
        label.textColor = UIColor.Compability.label.withAlphaComponent(0.2)
        subtitleLabel = label
        addSubview(label)
    }
    
    private func setIcon(for preset: SPIndicatorIconPreset) {
        let view = preset.createView()
        self.iconView = view
        addSubview(view)
    }
    
    private func updateShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.22
        layer.shadowOffset = .init(width: 0, height: 7)
        layer.shadowRadius = 40
        
        // Not use render shadow becouse backgorund is visual effect.
        // If turn on it, background will hide.
        // layer.shouldRasterize = true
    }
    
    // MARK: - Layout
    
    open var layout: SPIndicatorLayout = .init()
    
    private var areaHeight: CGFloat = 50
    private var minimumAreaWidth: CGFloat = 196
    private var maximumAreaWidth: CGFloat = 260
    private var spaceBetweenTitles: CGFloat = 1
    private var spaceBetweenTitlesAndImage: CGFloat = 16
    
    private var titlesCompactWidth: CGFloat {
        if let iconView = self.iconView {
            let space = iconView.frame.maxY + spaceBetweenTitlesAndImage
            return frame.width - space * 2
        } else {
            return frame.width - layoutMargins.left - layoutMargins.right
        }
    }
    
    private var titlesFullWidth: CGFloat {
        if let iconView = self.iconView {
            let space = iconView.frame.maxY + spaceBetweenTitlesAndImage
            return frame.width - space - layoutMargins.right
        } else {
            return frame.width - layoutMargins.left - layoutMargins.right
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        titleLabel?.sizeToFit()
        let titleWidth: CGFloat = titleLabel?.frame.width ?? 0
        subtitleLabel?.sizeToFit()
        let subtitleWidth: CGFloat = subtitleLabel?.frame.width ?? 0
        var width = (max(titleWidth, subtitleWidth) * 2.5).rounded()
        
        if width < minimumAreaWidth { width = minimumAreaWidth }
        if width > maximumAreaWidth { width = maximumAreaWidth }
        
        return .init(width: width, height: areaHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutMargins = layout.margins
        
        layer.cornerRadius = frame.height / 2
        backgroundView.frame = bounds
        backgroundView.layer.cornerRadius = layer.cornerRadius
        
        if let iconView = self.iconView {
            iconView.frame = .init(
                origin: .init(x: layoutMargins.right, y: iconView.frame.origin.y),
                size: layout.iconSize
            )
            iconView.center.y = bounds.midY
        }
        
        if let titleLabel = self.titleLabel {
            titleLabel.sizeToFit()
            if titleLabel.frame.width > titlesCompactWidth {
                titleLabel.textAlignment = UIApplication.shared.userInterfaceRightToLeft ? .right : .left
                titleLabel.layoutDynamicHeight(width: titlesFullWidth)
                titleLabel.frame.origin.x = layoutMargins.left + (iconView?.frame.width ?? 0) + spaceBetweenTitlesAndImage
            } else {
                titleLabel.textAlignment = .center
                titleLabel.layoutDynamicHeight(width: titlesCompactWidth)
                titleLabel.center.x = frame.width / 2
            }
        }
        
        if let subtitleLabel = self.subtitleLabel {
            subtitleLabel.sizeToFit()
            if subtitleLabel.frame.width > titlesCompactWidth {
                subtitleLabel.textAlignment = UIApplication.shared.userInterfaceRightToLeft ? .right : .left
                subtitleLabel.layoutDynamicHeight(width: titlesFullWidth)
                subtitleLabel.frame.origin.x = layoutMargins.left + (iconView?.frame.width ?? 0) + spaceBetweenTitlesAndImage
            } else {
                subtitleLabel.textAlignment = .center
                subtitleLabel.layoutDynamicHeight(width: titlesCompactWidth)
                subtitleLabel.center.x = frame.width / 2
            }
        }
        
        if (titleLabel != nil) && (subtitleLabel == nil) {
            titleLabel?.center.y = bounds.midY
        }
        
        if (titleLabel != nil) && (subtitleLabel != nil) {
            let allHeight = (titleLabel?.frame.height ?? 0) + (subtitleLabel?.frame.height ?? 0) + spaceBetweenTitles
            titleLabel?.frame.origin.y = (frame.height - allHeight) / 2
            subtitleLabel?.frame.origin.y = (titleLabel?.frame.maxY ?? 0) + spaceBetweenTitles
        }
    }
    
    // MARK: - Present
    
    fileprivate var presentAndDismissDuration: TimeInterval = 0.6
    
    fileprivate var startPresentPosition: CGFloat {
        -((UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + 50)
    }
    
    fileprivate var endPresentPosition: CGFloat {
        var topSafeAreaInsets = (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
        if topSafeAreaInsets < 20 { topSafeAreaInsets = 20 }
        return topSafeAreaInsets - 3
    }
    
    open func present(duration: TimeInterval = 1.5, haptic: SPIndicatorHaptic = .success, completion: (() -> Void)? = nil) {
        guard let window = self.presentWindow else { return }
        
        window.addSubview(self)
        
        // Prepare for present
        
        self.completion = completion
        
        isHidden = true
        sizeToFit()
        layoutSubviews()
        center.x = window.frame.midX
        transform = CGAffineTransform.identity.translatedBy(x: 0, y: startPresentPosition)
        
        // Present
        
        isHidden = false
        haptic.impact()
        UIView.animate(withDuration: presentAndDismissDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
            self.transform = CGAffineTransform.identity.translatedBy(x: 0, y: self.endPresentPosition)
        }, completion: { finished in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                self.dismiss()
            }
        })
        
        if let iconView = self.iconView as? SPIndicatorIconAnimatable {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + presentAndDismissDuration / 3) {
                iconView.animate()
            }
        }
    }
    
    @objc open func dismiss() {
        UIView.animate(withDuration: presentAndDismissDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.beginFromCurrentState, .curveEaseIn], animations: {
            self.transform = CGAffineTransform.identity.translatedBy(x: 0, y: self.startPresentPosition)
        }, completion: { finished in
            self.removeFromSuperview()
            self.completion?()
        })
    }
}

#endif
