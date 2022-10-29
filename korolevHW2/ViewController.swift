//
//  ViewController.swift
//  korolevHW2
//
//  Created by Yeva on 07.10.2022.
//

import UIKit

class ViewController: UIViewController {
    let incrementButton = UIButton(type: .system)
    let valueLabel = UILabel()
    let commentLabel = UILabel()
    var buttonsSV = UIStackView()
    let colorPaletteView = ColorPalletteView()
    var value:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        _ = setupCommentView()
    }
    
    //MARK: -AllSetup
    private func setupMenuButtons(){
        let colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")
        buttonsSV = UIStackView(arrangedSubviews: [colorsButton,notesButton,newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left, .right], [24, 24])
        buttonsSV.pinButton(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
    private func setupView() {
        view.backgroundColor = .systemGray6
        colorPaletteView.isHidden = true
        setupIncrementButton()
        setupValueLabel()
        setupMenuButtons()
        setupColorControlSV()
    }
    private func setupCommentView()-> UIView{
        let CommentView = UIView()
        CommentView.backgroundColor = .white
        CommentView.layer.cornerRadius = 12
        view.addSubview(CommentView)
        CommentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        CommentView.pin(to: self.view, [.left,.right], [24, 24])
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        CommentView.addSubview(commentLabel)
        commentLabel.pin(to: CommentView, [.top, .left, .bottom, .right], [16,16,16,16])
        return CommentView
    }
    private func setupColorControlSV(){
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        colorPaletteView.addTarget(self, action: #selector(changeColor(_:)), for: .touchDragInside)
        NSLayoutConstraint.activate(
            [colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor,constant: 8),
             colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 24),
             colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -24),
             colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor,constant: -8)
            ]
        )
    }
    
    // MARK: -FuncButton
    private func setupIncrementButton(){
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left, .right],[24, 24])
        incrementButton.layer.shadowRadius = 10
        incrementButton.layer.shadowOpacity = 0.5
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
    @objc
    private func incrementButtonPressed(){
        value+=1
        UIView.transition(with: commentLabel,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations:{self.updateUI()}, completion: nil)
    }
    
    // MARK: -FuncLabel
    private func setupValueLabel(){
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinButton(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view)
    }
    
    //MARK: -AllUpdate
    func updateCommentLabel(value: Int){
        switch value{
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐"
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    private func updateUI(){
        valueLabel.text = "\(value)"
        updateCommentLabel(value: value)
    }
    
    // MARK: -funcMenuButton
    private func makeMenuButton(title: String)-> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: . medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    //MARK: -funcPalette
    @objc
    private func paletteButtonPressed(){
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc
    private func changeColor(_ slider: ColorPalletteView){
        UIView.animate(withDuration: 0.5){
            self.view.backgroundColor = slider.chosenColor
        }
    }
}
