//
//  DetallesController.swift
//  com.correa.appnotas
//
//  Created by Mac17 on 15/04/21.
//

import UIKit

class DetallesController: UIViewController {

    
    var titulo: String?
    var index:Int?
    var notas:[String]?
    var defaultBD = UserDefaults.standard
    
    @IBOutlet weak var notaEditarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        notaEditarTextField.text = titulo
        print(notas!)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func guardarNOtaEditada(_ sender: Any) {
        if let notaEditada:String = notaEditarTextField.text {
            notas![index!] = notaEditada
            print(notas ?? ["nada"])
            defaultBD.set(notas,forKey:"notas")
            navigationController?.popToRootViewController(animated:true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
