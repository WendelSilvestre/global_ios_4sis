import UIKit

class ClothListViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let cellID = "ClothCell"

    private var pecas: [Cloth] = [
        Cloth(name: "Jaqueta Térmica",    clothTemperature: 28, mode: .hot,  adaptiveMeasures: ["Tronco", "Braços"]),
        Cloth(name: "Camiseta Ventilada", clothTemperature: 19, mode: .cold, adaptiveMeasures: ["Tronco"]),
        Cloth(name: "Moletom Adaptativo", clothTemperature: 24, mode: .warm, adaptiveMeasures: ["Tronco", "Pescoço"]),
        Cloth(name: "Colete Climático",   clothTemperature: 26, mode: .hot,  adaptiveMeasures: ["Tronco"]),
        Cloth(name: "Calça Reguladora",   clothTemperature: 22, mode: .warm, adaptiveMeasures: ["Pernas"]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Guarda-roupa Adaptativo"
        configurarLayout()
    }

    private func configurarLayout() {
        let titulo = UILabel()
        titulo.text = "Guarda-roupa Adaptativo"
        titulo.font = .boldSystemFont(ofSize: 20)

        let botaoAdicionar = UIButton(type: .system)
        botaoAdicionar.setTitle("Adicionar", for: .normal)
        botaoAdicionar.addAction(UIAction { [weak self] _ in self?.adicionarPeca() }, for: .touchUpInside)

        let botaoEditar = UIButton(type: .system)
        botaoEditar.setTitle("Editar", for: .normal)
        botaoEditar.addAction(UIAction { [weak self] _ in self?.alternarEdicao(botaoEditar) }, for: .touchUpInside)

        let header = UIStackView(arrangedSubviews: [titulo, UIView(), botaoAdicionar, botaoEditar])
        header.axis = .horizontal
        header.spacing = 12
        header.alignment = .center
        header.translatesAutoresizingMaskIntoConstraints = false

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

        view.addSubview(header)
        view.addSubview(tableView)

        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            header.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            header.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func alternarEdicao(_ botao: UIButton) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        botao.setTitle(tableView.isEditing ? "Concluir" : "Editar", for: .normal)
    }

    private func adicionarPeca() {
        let alerta = UIAlertController(title: "Nova peça",
                                       message: "Digite o nome da roupa adaptativa.",
                                       preferredStyle: .alert)
        alerta.addTextField { $0.placeholder = "Ex.: Luva Térmica" }
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alerta.addAction(UIAlertAction(title: "Adicionar", style: .default) { [weak self, weak alerta] _ in
            guard let self else { return }
            let nome = (alerta?.textFields?.first?.text ?? "")
                .trimmingCharacters(in: .whitespacesAndNewlines)

            guard !nome.isEmpty else {
                Mensagem.alerta(titulo: "Nome vazio",
                                mensagem: "Não é possível adicionar uma peça sem nome.", em: self)
                return
            }

            let nova = Cloth(name: nome, clothTemperature: 24, mode: .warm, adaptiveMeasures: ["Tronco"])
            self.pecas.append(nova)
            self.tableView.insertRows(at: [IndexPath(row: self.pecas.count - 1, section: 0)], with: .automatic)
        })
        present(alerta, animated: true)
    }
}

extension ClothListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pecas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let peca = pecas[indexPath.row]
        var conf = cell.defaultContentConfiguration()
        conf.text = peca.name
        conf.secondaryText = "\(peca.mode.descricao) - \(String(format: "%.1f", peca.clothTemperature))°C"
        cell.contentConfiguration = conf
        cell.accessoryType = .detailButton
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let peca = pecas[indexPath.row]
        let medidas = peca.adaptiveMeasures.isEmpty ? "nenhuma" : peca.adaptiveMeasures.joined(separator: ", ")
        Mensagem.alerta(titulo: peca.name,
                        mensagem: """
                        Modo: \(peca.mode.descricao)
                        Temperatura: \(String(format: "%.1f", peca.clothTemperature))°C
                        Ajusta: \(medidas)
                        """,
                        em: self)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let peca = pecas[indexPath.row]
        Mensagem.alerta(titulo: "Sobre a peça",
                        mensagem: "\"\(peca.name)\" funciona no modo \(peca.mode.descricao) e regula a temperatura em torno de \(String(format: "%.1f", peca.clothTemperature))°C.",
                        em: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pecas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
