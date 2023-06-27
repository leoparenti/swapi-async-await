extension HomeTableViewCell {
    func configure(from item: Figure, action: (() -> Void)? = nil){
        titleLabel.text = "Name"
        nameLabel.text = item.name
        titleCloseLabel.text = "Mass"
        statusLabel.text = item.mass
        statusIcon.text = item.iconText
        statusIcon.layer.backgroundColor = item.iconColor
        self.action = action
    }
}

/*
 cell.textLabel?.text = "\(data.name) - \(data.skinColor) - \(data.mass)"
 cell.textLabel?.textAlignment = .left
 */
