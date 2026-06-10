import UIKit

class PersonViewController: UIViewController {

    private let nomeField = UITextField()
    private let alturaField = UITextField()
    private let tempCorpoField = UITextField()
    private let tempAmbienteField = UITextField()
    private let resultadoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "AdaptaVest - Cadastro"
        configurarLayout()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    private func configurarLayout() {
        let titulo = UILabel()
        titulo.text = "Recomendação Térmica"
        titulo.font = .boldSystemFont(ofSize: 22)
        titulo.textAlignment = .center

        let subtitulo = UILabel()
        subtitulo.text = "Informe seus dados para descobrir a roupa adaptativa ideal."
        subtitulo.font = .systemFont(ofSize: 14)
        subtitulo.textColor = .secondaryLabel
        subtitulo.numberOfLines = 0
        subtitulo.textAlignment = .center

        configurar(nomeField, placeholder: "Nome completo", teclado: .default)
        configurar(alturaField, placeholder: "Altura (m) - ex.: 1.75", teclado: .decimalPad)
        configurar(tempCorpoField, placeholder: "Temp. corporal (°C) - ex.: 36.5", teclado: .decimalPad)
        configurar(tempAmbienteField, placeholder: "Temp. ambiente (°C) - ex.: 18", teclado: .numbersAndPunctuation)

        let botao = UIButton(type: .system)
        botao.setTitle("Calcular recomendação", for: .normal)
        botao.titleLabel?.font = .boldSystemFont(ofSize: 17)
        botao.addAction(UIAction { [weak self] _ in self?.calcular() }, for: .touchUpInside)

        resultadoLabel.numberOfLines = 0
        resultadoLabel.font = .systemFont(ofSize: 15)
        resultadoLabel.textAlignment = .center
        resultadoLabel.textColor = .label

        let stack = UIStackView(arrangedSubviews: [
            titulo, subtitulo, nomeField, alturaField,
            tempCorpoField, tempAmbienteField, botao, resultadoLabel
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safe.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -24),
        ])
    }

    private func configurar(_ campo: UITextField, placeholder: String, teclado: UIKeyboardType) {
        campo.placeholder = placeholder
        campo.borderStyle = .roundedRect
        campo.keyboardType = teclado
        campo.autocorrectionType = .no
    }

    private func calcular() {
        view.endEditing(true)

        guard let nome = nomeField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !nome.isEmpty else {
            Mensagem.alerta(titulo: "Campo obrigatório",
                            mensagem: "Por favor, informe o seu nome.", em: self)
            return
        }

        guard let altura = Double(numero(alturaField)) else {
            Mensagem.alerta(titulo: "Altura inválida",
                            mensagem: "Informe a altura em metros usando números (ex.: 1.75).", em: self)
            return
        }
        guard altura >= 0.5 && altura <= 2.5 else {
            Mensagem.alerta(titulo: "Altura fora do intervalo",
                            mensagem: "A altura deve estar entre 0,5 m e 2,5 m.", em: self)
            return
        }

        guard let tempCorpo = Double(numero(tempCorpoField)) else {
            Mensagem.alerta(titulo: "Temperatura inválida",
                            mensagem: "Informe a temperatura corporal em números (ex.: 36.5).", em: self)
            return
        }
        guard tempCorpo >= 30 && tempCorpo <= 45 else {
            Mensagem.alerta(titulo: "Temperatura fora do intervalo",
                            mensagem: "A temperatura corporal deve estar entre 30°C e 45°C.", em: self)
            return
        }

        guard let tempAmbiente = Double(numero(tempAmbienteField)) else {
            Mensagem.alerta(titulo: "Temperatura inválida",
                            mensagem: "Informe a temperatura ambiente em números (ex.: 18).", em: self)
            return
        }

        let pessoa = Person(name: nome, height: altura, bodyTemperature: tempCorpo)
        let ideal = pessoa.idealClothTemperature(forAmbient: tempAmbiente)
        let modo = pessoa.recommendedMode(forAmbient: tempAmbiente)

        let texto = """
        Olá, \(nome)!
        Modo recomendado: \(modo.descricao)
        Temperatura ideal da roupa: \(String(format: "%.1f", ideal))°C
        """
        resultadoLabel.text = texto
        Mensagem.alerta(titulo: "Recomendação pronta", mensagem: texto, em: self)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func numero(_ campo: UITextField) -> String {
        return (campo.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ",", with: ".")
    }
}
