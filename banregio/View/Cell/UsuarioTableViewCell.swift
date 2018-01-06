//
//  UsuarioTableViewCell.swift
//  banregio
//
//  Created by Benjamin on 04/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//

import UIKit

class UsuarioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagenUsuario: UIImageView!
    @IBOutlet weak var nombreUsuario: UILabel!
    @IBOutlet weak var direccionUsuario: UILabel!
    @IBOutlet weak var fechaUsuario: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
