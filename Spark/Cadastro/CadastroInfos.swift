import SwiftUI

struct CadastroInfos: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel
    
    @State private var nome = ""
    @State private var idadeTexto = ""
    @State private var pesoTexto = ""
    @State private var alturaTexto = ""
    @State private var deveNavegar = false
    
    @AppStorage("cadastroConcluido") var cadastroConcluido = false
    @AppStorage("objetivoSelecionado") private var objetivoSalvo: String = ""

    @AppStorage("nomeUsuario") var storedNomeUsuario: String = ""
    @AppStorage("idadeUsuario") var storedIdadeUsuario: Int = 0
    @AppStorage("pesoUsuario") var storedPesoUsuario: Double = 0.0
    @AppStorage("alturaUsuario") var storedAlturaUsuario: Int = 0

    var idade: Int? {
        Int(idadeTexto)
    }

    var peso: Double? {
        Double(pesoTexto.replacingOccurrences(of: ",", with: "."))
    }

    var altura: Int? {
        Int(alturaTexto.replacingOccurrences(of: ",", with: ".").split(separator: ".")[0])
    }

    var podeConcluir: Bool {
        !nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        idade != nil && idadeTexto.count <= 2 &&
        peso != nil && !pesoTexto.isEmpty &&
        (alturaTexto.isEmpty || (altura != nil && alturaTexto.count <= 3))
    }

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(red: 233/255, green: 9/255, blue: 22/255))
                            .font(.system(size: 23, weight: .bold))
                    }
                    ProgressBarCadastro(currentTela: 3)
                }
                .padding(.horizontal)

                ScrollView {

                    CamposCadastroView(nome: $nome, idadeTexto: $idadeTexto, pesoTexto: $pesoTexto, alturaTexto: $alturaTexto)
                    Spacer(minLength: 30)
                    
                    BotaoConcluirCadastro(podeConcluir: podeConcluir) {
                        storedNomeUsuario = nome.trimmingCharacters(in: .whitespacesAndNewlines)
                        storedIdadeUsuario = idade ?? 0
                        storedPesoUsuario = peso ?? 0.0
                        storedAlturaUsuario = altura ?? 0

                        print("Dados do usuário salvos em @AppStorage.")
                        print("Nome: \(storedNomeUsuario)")
                        print("Idade: \(storedIdadeUsuario)")
                        print("Peso: \(storedPesoUsuario)")
                        print("Altura: \(storedAlturaUsuario)")
                        
                        if !objetivoSalvo.isEmpty {
                            print("Configurando treinos iniciais para o objetivo: \(objetivoSalvo)")
                            gerenciadorSessoes.configurarTreinosIniciaisParaUsuario(objetivoDoUsuario: objetivoSalvo)
                        } else {
                            print("AVISO: Objetivo do usuário ('objetivoSalvo') está vazio. Treinos iniciais não serão configurados automaticamente.")
                        }

                        print("Cadastro Concluído! Navegando para a tela principal.") //
                        cadastroConcluido = true
                        deveNavegar = true
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .navigationDestination(isPresented: $deveNavegar) {
                        TabViewTeste()
                            .environmentObject(gerenciadorSessoes)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: nome) { _, newValue in
            if newValue.count > 30 {
                nome = String(newValue.prefix(30))
            }
        }
        .onChange(of: idadeTexto) { _, newValue in
            let filtered = newValue.filter { "0123456789".contains($0) }
            if filtered.count > 2 {
                idadeTexto = String(filtered.prefix(2))
            } else {
                idadeTexto = filtered
            }
        }
        .onChange(of: pesoTexto) { _, newValue in //
            let filtered = newValue.filter { "0123456789,.".contains($0) }

            if filtered.count > 5 {
                pesoTexto = String(filtered.prefix(5))
            } else {
                pesoTexto = filtered
            }
        }
        .onChange(of: alturaTexto) { _, newValue in
            let filtered = newValue.filter { "0123456789".contains($0) }
            if filtered.count > 3 {
                alturaTexto = String(filtered.prefix(3))
            } else {
                alturaTexto = filtered
            }
        }
        .onAppear {

        }
    }
}

struct TopBarCadastro: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(red: 233/255, green: 9/255, blue: 22/255))
                    .font(.system(size: 25, weight: .bold))
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct CamposCadastroView: View {
    @Binding var nome: String
    @Binding var idadeTexto: String
    @Binding var pesoTexto: String
    @Binding var alturaTexto: String

    var body: some View {
        VStack {
            CampoCadastro(label: "Nome:", placeholder: "Ex: João da Silva", texto: $nome)
            CampoCadastro(label: "Idade:", placeholder: "Ex: 25", texto: $idadeTexto, keyboard: .numberPad)
            CampoCadastro(label: "Peso (em Kg):", placeholder: "Ex: 70,5", texto: $pesoTexto, keyboard: .decimalPad)
            CampoCadastro(label: "Altura (em cm):", placeholder: "Ex: 170 (Opcional)", texto: $alturaTexto, keyboard: .numberPad)
        }
        .padding(.top)
    }
}

struct BotaoConcluirCadastro: View {
    var podeConcluir: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Concluir")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    podeConcluir
                    ? Color("CorOk")
                    : Color("ColorCard").opacity(0.6)
                )
                .cornerRadius(12)
        }
        .disabled(!podeConcluir)
    }
}

struct CampoCadastro: View {
    var label: String
    var placeholder: String
    @Binding var texto: String
    var keyboard: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .padding(.bottom,10)
                .font(.headline)
                .foregroundColor(.white)
            ZStack(alignment: .leading) {
                if texto.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(.leading, 14)
                }
                TextField("", text: $texto)
                    .foregroundColor(.white)
                    .padding()
                    .keyboardType(keyboard)
            }
            .background(Color("ColorCard"))
            .cornerRadius(12)
            .padding(.bottom, 20)
        }
    }
}
#Preview {
    // Para o Preview, você precisa fornecer o EnvironmentObject
    CadastroInfos() //
        .environmentObject(GerenciadorSessoesViewModel()) // Adicionado
        .preferredColorScheme(.dark) //
}
