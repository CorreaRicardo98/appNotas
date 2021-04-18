//
//  ViewController.swift
//  com.correa.appnotas
//
//  Created by Mac17 on 15/04/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var Notas:[String] = ["ir al Gym","Dormir","Comer","Comprar Comida"]
    var fechas:[String] =  ["20/04/2021","20/04/2021","20/04/2021","20/04/2021","20/04/2021","20/04/2021"]
    var index: Int?
    var nota: String?
    
    var defaultBD = UserDefaults.standard
   
    
    @IBOutlet weak var tabla: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //estos dos metodos se implementan de a fuerza
        tabla.delegate = self
        tabla.dataSource = self
        
        if defaultBD.array(forKey:"notas") == nil {
            
        }else{
            Notas = defaultBD.array(forKey: "notas") as! [String]
        }
       
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notas.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notas"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        
        performSegue(withIdentifier: "enviar", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviar" {
            
            let ObjDetalle = segue.destination as! DetallesController
            
            
            nota = Notas[index!]
            
            ObjDetalle.titulo = nota ?? ""
        
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCelda = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        objCelda.textLabel?.text = Notas[indexPath.row]
        objCelda.detailTextLabel?.text = fechas[indexPath.row]
        
        return objCelda
    }
    
    
    //MARK: - boton de agregar
    @IBAction func AgregarNota(_ sender: Any) {
        var textFiel = UITextField()
        let alerta = UIAlertController(
            title: "agregar nueva nota", message: "agregue los datos de la nota", preferredStyle: .alert
        )
        
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default){(_) in
            print("aceptar agregar nota")
            let today = Date()
            let format1 = DateFormatter()
            format1.dateStyle = .short
            self.fechas.append(format1.string(from: today))
            self.Notas.append(textFiel.text ?? "no hay nota")
            print(textFiel.text!)
            
            self.tabla.reloadData()
            
            self.defaultBD.set(self.Notas, forKey: "notas")
        }
        
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        alerta.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = "Nueva Nota..."
            textFiel = textFieldAlert
            
        }
        
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        
        present(alerta, animated: true, completion: nil)
    }
    
}

