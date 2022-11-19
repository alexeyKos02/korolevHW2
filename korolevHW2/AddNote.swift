import UIKit


protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note:ShortNote)
}

final class AddNoteCell: UITableViewCell{
    
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    weak var delegate : AddNoteDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.setHeight(140)
        textView.delegate = self
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.setHeight(44)
        addButton.layer.cornerRadius = 12
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)),for: .touchUpInside)
        addButton.isEnabled = false
        addButton.alpha = 0.5
        
        let stackView = UIStackView(arrangedSubviews: [textView,addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left,.right,.bottom,.top], [10,10,10,0])
        contentView.backgroundColor = .systemGray5
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton){
        let short = ShortNote(text: textView.text)
        delegate?.newNoteAdded(note: short)
        textView.text = ""
    }
}
// Расширение класса для делегата UITextView. Реакция кнопки на текстовую область.
extension AddNoteCell: UITextViewDelegate{
    
    func textViewDidChange(_ sender: UITextView) {
        if(sender.text != ""){
            addButton.alpha = 1
            addButton.isEnabled = true
        } else {
            addButton.alpha = 0.5
            addButton.isEnabled = false
        }
    }
}
