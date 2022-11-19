import UIKit

protocol DismissNotesViewController{
    func dismissViewController()
}

final class NotesViewController : UIViewController{
    var delegate: DismissNotesViewController?
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource = [
        ShortNote (text: "d"),
        ShortNote(text: "a"),
        ShortNote(text: "c")]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        SetupView()
    }
    
    private func SetupView(){
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar(){
        self.title = "Notes"
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismisViewController(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    private func setupTableView(){
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.pin(to: self.view,[.left,.right,.bottom,.top],[0,0,0,0])
    }
    
    private func handleDelegate(indexPath: IndexPath){
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
}
extension NotesViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView)-> Int{
            return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell{
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell{
                noteCell.configure(note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
    
    private func handleDelete(indexPath: IndexPath){
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    @objc
    func dismisViewController(_ sender: UIButton){
        delegate?.dismissViewController()
    }
}
// Добавление заметки
extension NotesViewController:AddNoteDelegate{
    func newNoteAdded(note: ShortNote){
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
}
extension NotesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)->UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: .none)
        {
            [weak self] (action, view, completion) in self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill",
                                     withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
