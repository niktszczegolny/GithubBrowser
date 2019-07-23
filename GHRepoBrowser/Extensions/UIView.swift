//
//  UIView.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 21/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

// MARK: Subviews

extension UIView {

    var recursiveSubviews: [UIView] {
        // check if subviews exist
        guard subviews.count > 0 else { return [] }
        // get all subviews and subviews of subviews and [...]
        var subviewsArray = [UIView]()
        subviews.forEach {
            subviewsArray.append($0)
            subviewsArray.append(contentsOf: $0.recursiveSubviews)
        }
        return subviewsArray
    }

    func typedSubviews<T>() -> [T] {
        return recursiveSubviews.compactMap { $0 as? T }
    }

}

// MARK: Shimmering

extension UIView {

    enum ShimmeringStyle {
        case light
        case dark

        var lightColor: UIColor { return backgroundColor.withAlphaComponent(0.3) }
        var darkColor: UIColor { return backgroundColor.withAlphaComponent(0.1) }

        var backgroundColor: UIColor {
            switch self {
            case .light: return .white
            case .dark: return .gray
            }
        }

    }

    private func shimmeringGradient(with style: ShimmeringStyle = .light) -> CAGradientLayer {
        let width = UIApplication.shared.keyWindow?.frame.size.width ?? bounds.width
        let inset = width

        let gradient = CAGradientLayer()
        gradient.colors = [style.darkColor.cgColor, style.lightColor.cgColor, style.darkColor.cgColor]
        gradient.frame = CGRect(x: -inset, y: 0, width: width + 2 * inset, height: bounds.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5225)
        gradient.locations = [0.2, 0.5, 0.8]

        return gradient
    }

    private var shimmeringAnimation: CABasicAnimation {
        get {
            let animation = CABasicAnimation(keyPath: "locations")
            animation.fromValue = [-0.2, -0.1, 0.0]
            animation.toValue = [1.0, 1.1, 1.2]
            animation.duration = 2.0
            animation.repeatCount = Float.infinity

            return animation
        }
    }

    func setShimmering(_ shimmering: Bool, style: ShimmeringStyle = .dark) {
        guard shimmering == true else {
            isUserInteractionEnabled = true
            if let existingShimmerSubview = existingShimmerSubview() {
                UIView.animate(withDuration: 0.2, animations: { [existingShimmerSubview] in
                    existingShimmerSubview.alpha = 0.0
                }) { [existingShimmerSubview] _ in
                    existingShimmerSubview.removeFromSuperview()
                }
            }
            return
        }

        let gradient = shimmeringGradient(with: style)
        let animation = shimmeringAnimation

        isUserInteractionEnabled = false
        gradient.add(animation, forKey: "shimmer")
        shimmerSubview().subviews.first?.layer.mask = gradient
    }

    private var shimmerTag: Int { return 194121 }

    private func existingShimmerSubview() -> UIView? {
        let subviews: [UIView] = typedSubviews()
        return subviews.first { $0.tag == shimmerTag }
    }

    private func shimmerSubview() -> UIView {
        if let shimmerSubview = existingShimmerSubview() {
            return shimmerSubview
        }
        
        let shimmerSubview = UIView()
        shimmerSubview.tag = shimmerTag
        shimmerSubview.translatesAutoresizingMaskIntoConstraints = false
        shimmerSubview.backgroundColor = .white

        let shimmerView = UIView()
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        shimmerView.backgroundColor = .lightGray
        shimmerView.layer.cornerRadius = 4.0
        shimmerView.layer.masksToBounds = true

        [(shimmerSubview, shimmerView), (self, shimmerSubview)].forEach {
            $0.0.addSubview($0.1)
            $0.1.topAnchor.constraint(equalTo: $0.0.topAnchor, constant: 0).isActive = true
            $0.1.bottomAnchor.constraint(equalTo: $0.0.bottomAnchor, constant: 0).isActive = true
            $0.1.leftAnchor.constraint(equalTo: $0.0.leftAnchor, constant: 0).isActive = true
            $0.1.rightAnchor.constraint(equalTo: $0.0.rightAnchor, constant: 0).isActive = true
        }

        return shimmerSubview
    }

}

