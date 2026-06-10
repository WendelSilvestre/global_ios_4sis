import UIKit

class Mensagem {

    static func alerta(titulo: String,
                       mensagem: String,
                       em viewController: UIViewController,
                       aoFechar: (() -> Void)? = nil) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default) { _ in aoFechar?() })
        viewController.present(alerta, animated: true)
    }

    static func opcoes(titulo: String,
                       mensagem: String,
                       em viewController: UIViewController,
                       acoes: [UIAlertAction]) {
        let folha = UIAlertController(title: titulo, message: mensagem, preferredStyle: .actionSheet)
        acoes.forEach { folha.addAction($0) }
        folha.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        if let popover = folha.popoverPresentationController {
            popover.sourceView = viewController.view
            popover.sourceRect = CGRect(x: viewController.view.bounds.midX,
                                        y: viewController.view.bounds.midY,
                                        width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        viewController.present(folha, animated: true)
    }
}
