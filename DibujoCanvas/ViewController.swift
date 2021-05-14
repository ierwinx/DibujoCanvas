import UIKit

class ViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var paletaColores: UICollectionView!
    @IBOutlet weak var canvasView: CanvasView!
    
    //MARK: Properties
    private let colores: Array<UIColor> = [
        .black, .blue, .brown, .cyan, .darkGray, .gray, .green, .lightGray, .magenta,
        .orange, .purple, .red, .white, .yellow
    ]
    
    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paletaColores.delegate = self
        paletaColores.dataSource = self
    }
    
    //MARK: Actions
    @IBAction func limpiarAction(_ sender: Any) {
        canvasView.eliminarDibujo()
    }
    
    @IBAction func deshacerAction(_ sender: Any) {
        canvasView.deshacer()
    }
    
    @IBAction func guardarAction(_ sender: Any) {
        let imagen = canvasView.takeScreenShot()
        UIImageWriteToSavedPhotosAlbum(imagen, self, #selector(imagenSave(_:didFinishSavingWithError:contextType:)), nil)
    }
    
    @objc func imagenSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        if error != nil {
            print("Imposible guardar Imagen")
        } else {
            print("Imagen guardada")
        }
    }
    
    @IBAction func opacidadSliderAction(_ sender: UISlider) {
        canvasView.opacity = CGFloat(sender.value)
    }
    
    @IBAction func tamanoSliderAction(_ sender: UISlider) {
        canvasView.ancho = CGFloat(sender.value)
    }
    
}

//MARK: Extension
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "celdaColor", for: indexPath)
        celda.backgroundColor = self.colores[indexPath.row]
        celda.layer.cornerRadius = celda.frame.width / 2
        return celda
    }
    
    //MARK: FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 35, height: 35)
    }
    
    //MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.canvasView.color = self.colores[indexPath.row]
    }
    
}

extension UIView {
    
    func takeScreenShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let imagen = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let image = imagen else {
            return UIImage()
        }
        
        return image
    }
    
}
