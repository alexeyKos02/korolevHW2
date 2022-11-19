import UIKit
import Foundation

struct ShortNote{
    var text: String
}

final class NoteCell: UITableViewCell{
    
    static let reuseIdentifier = "NoteCell"
    private var textlabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        textlabel.font = .systemFont(ofSize: 16, weight: .regular)
        textlabel.textColor = .label
        textlabel.numberOfLines = 0
        textlabel.backgroundColor = .clear
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(textlabel)
        textlabel.pin(to: contentView, [.left,.right,.bottom,.top],[0,0,0,0])
    }
    
    public func configure(_ note: ShortNote){
        textlabel.text = note.text
    }
}
