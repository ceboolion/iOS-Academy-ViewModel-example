//
//  TableViewCell.swift
//  MVVMExample
//
//  Created by Roman on 08/12/2022.
//

import UIKit

protocol PersonFollowingViewCellDelegate: AnyObject {
    func personFollowingTableViewCell(_ cell: PersonFollowingViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel)
}

class PersonFollowingViewCell: UITableViewCell {
    
    class var reuseIdentifier: String { return "PersonFollowingViewCell" }
    
    weak var delegate: PersonFollowingViewCellDelegate?
    private var viewModel: PersonFollowingTableViewCellViewModel?
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(button)
        contentView.clipsToBounds = true
        button.addTarget(self, action: #selector(didTappedButton), for: .primaryActionTriggered)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTappedButton() {
        guard let viewModel else { return }
        var newViewModel = viewModel
        newViewModel.currentlyFollowing = !viewModel.currentlyFollowing
        delegate?.personFollowingTableViewCell(self, didTapWith: newViewModel)
        prepareForReuse()
        configure(with: newViewModel)
    }
    
    func configure(with viewModel: PersonFollowingTableViewCellViewModel) {
        self.viewModel = viewModel
        userImageView.image = viewModel.image
        nameLabel.text = viewModel.name
        userNameLabel.text = viewModel.userName
        
        if viewModel.currentlyFollowing {
            button.setTitle("Unfollow", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blue.cgColor
        } else {
            button.setTitle("Follow", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.borderWidth = 1
            button.backgroundColor = .link
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageWith = contentView.frame.size.height - 10
        userImageView.frame = CGRect(x: 5, y: 5, width: imageWith, height: imageWith)
        nameLabel.frame = CGRect(x: imageWith + 10, y: 0, width: contentView.frame.size.width - imageWith, height: contentView.frame.size.height / 2)
        userNameLabel.frame = CGRect(x: imageWith + 10, y: contentView.frame.size.height / 2, width: contentView.frame.size.width - imageWith, height: contentView.frame.size.height / 2)
        button.frame = CGRect(x: contentView.frame.size.width - 120, y: 10, width: 110, height: contentView.frame.size.height - 20)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        userNameLabel.text = nil
        userImageView.image = nil
        button.backgroundColor = nil
        button.layer.borderWidth = 0
        button.setTitle(nil, for: .normal)
    }
    
}
