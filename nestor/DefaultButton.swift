//
//  DefaultButton.swift
//  nestor
//
//  Created by milliere on 04/10/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit

class DefaultButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //coin arrondi
        layer.cornerRadius = 5
        
        //couleur du bouton
        layer.borderColor = UIColor(hex: 0xaf197b).cgColor
        
        //Epaisseur de la bordure
        layer.borderWidth = 2
        
        //color Text
        setTitleColor(UIColor(hex: 0xaf197b), for: UIControlState())
        
        //padding à gauche et droite
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
}
