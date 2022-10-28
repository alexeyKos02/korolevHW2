import Foundation
import UIKit
final class ColorPalletteView: UIControl{
    private let stackView = UIStackView()
    private(set) var chooseColor: UIColor = .systemGray6
    
    init(){
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView(){
        
    }
}
