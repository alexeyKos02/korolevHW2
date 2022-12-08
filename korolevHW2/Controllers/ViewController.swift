import UIKit

class ViewController: UIViewController {
    let incrementButton = UIButton(type: .system)
    let valueLabel = UILabel()
    let commentLabel = UILabel()
    var buttonsSV = UIStackView()
    let colorPaletteView = ColorPalletteView()
    let notesViewController = NotesViewController()
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
        notesButton.addTarget(self, action: #selector(ChangeController), for: .touchUpInside)
        let newsButton = makeMenuButton(title: "📰")
        newsButton.addTarget(self, action: #selector(newsButtonPressed), for: .touchUpInside)
        buttonsSV = UIStackView(arrangedSubviews: [colorsButton,notesButton,newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        buttonsSV.layer.shadowRadius = 10
        buttonsSV.layer.shadowOpacity = 0.5
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
        colorPaletteView.layer.shadowRadius = 10
        colorPaletteView.layer.shadowOpacity = 0.5
        colorPaletteView.addTarget(self, action: #selector(changeColor(_:)), for: .touchDragInside)
        NSLayoutConstraint.activate(
            [colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor,constant: 8),
             colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 24),
             colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -24),
             colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor,constant: -8)
            ]
        )
    }
    
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
        incrementButton.addTarget(self, action: #selector(change), for: .touchUpInside)
    }
    // MARK: -FuncButton
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
    @objc
    private func change(){
        self.view.backgroundColor = .white;
        colorPaletteView.change(color: self.view.backgroundColor!)
    }
    // MARK: -funcNotes
    @objc
    private func ChangeController(){
        notesViewController.delegate = self       
        self.present(UINavigationController(rootViewController: notesViewController), animated: true, completion: nil)
    }
}
extension ViewController: DismissNotesViewController{
    func dismissViewController() {
        UINavigationController(rootViewController: notesViewController).popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    // MARK: -funcNews
    @objc
    private func newsButtonPressed() {
        let newsListController = NewsListViewController()
        navigationController?.pushViewController(newsListController, animated: true)
    }
}
