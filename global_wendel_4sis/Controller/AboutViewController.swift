import UIKit

class AboutViewController: UIViewController {

    private let participantes: [(nome: String, rm: String)] = [
        ("Wendel Silvestre", "RM000000"),
    ]

    private let pontosEstimados = "10,0"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Sobre"
        configurarLayout()
    }

    private func configurarLayout() {
        let titulo = UILabel()
        titulo.text = "AdaptaVest"
        titulo.font = .boldSystemFont(ofSize: 26)
        titulo.textAlignment = .center

        let subtitulo = UILabel()
        subtitulo.text = "Roupas adaptativas para conforto térmico"
        subtitulo.font = .systemFont(ofSize: 14)
        subtitulo.textColor = .secondaryLabel
        subtitulo.textAlignment = .center
        subtitulo.numberOfLines = 0

        let participantesLabel = UILabel()
        participantesLabel.numberOfLines = 0
        participantesLabel.textAlignment = .center
        participantesLabel.font = .systemFont(ofSize: 17)
        let linhas = participantes.map { "\($0.nome) - \($0.rm)" }.joined(separator: "\n")
        participantesLabel.text = "Desenvolvido por:\n\n\(linhas)"

        let botao = UIButton(type: .system)
        botao.setTitle("Pontuação estimada", for: .normal)
        botao.titleLabel?.font = .boldSystemFont(ofSize: 17)
        botao.addAction(UIAction { [weak self] _ in self?.mostrarPontuacao() }, for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titulo, subtitulo, participantesLabel, botao])
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -24),
        ])
    }

    private func mostrarPontuacao() {
        Mensagem.alerta(
            titulo: "Pontuação estimada",
            mensagem: "Acredito ter alcançado \(pontosEstimados) pontos, pois implementei todos os requisitos solicitados: arquitetura MVC, Model coerente com a solução, classe exclusiva de mensagens, validação de campos, TableView com seleção e exclusão, ícone, LaunchScreen e as 3 telas.",
            em: self)
    }
}
