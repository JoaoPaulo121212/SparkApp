import SwiftUI

struct CadastroInfos: View {
    @Environment(\.dismiss) var dismiss
    @State private var nome = ""
    @State private var idadeTexto = ""
    @State private var pesoTexto = ""
    @State private var alturaTexto = ""
    @State private var deveNavegar = false
    @AppStorage("cadastroConcluido") var cadastroConcluido = false

    // Add @AppStorage for each piece of user data
    @AppStorage("nomeUsuario") var storedNomeUsuario: String = ""
    @AppStorage("idadeUsuario") var storedIdadeUsuario: Int = 0
    @AppStorage("pesoUsuario") var storedPesoUsuario: Double = 0.0
    @AppStorage("alturaUsuario") var storedAlturaUsuario: Int = 0 // Storing height in cm as Int

    var idade: Int? {
        Int(idadeTexto)
    }

    var peso: Double? {
        Double(pesoTexto.replacingOccurrences(of: ",", with: "."))
    }

    var altura: Double? { // Keep as Double? since input can be decimal
        Double(alturaTexto.replacingOccurrences(of: ",", with: "."))
    }

    var podeConcluir: Bool {
        !nome.isEmpty && idade != nil && peso != nil
    }

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(red: 233/255, green: 9/255, blue: 22/255))
                            .font(.system(size: 28, weight: .bold))
                    }
                    ProgressBarCadastro(currentTela: 2)

                }
                .padding(.horizontal)
                ScrollView {
                    CamposCadastroView(nome: $nome, idadeTexto: $idadeTexto, pesoTexto: $pesoTexto, alturaTexto: $alturaTexto)
                    Spacer()
                    BotaoConcluirCadastro(podeConcluir: podeConcluir) {
                        if idade == nil || peso == nil || (!alturaTexto.isEmpty && altura == nil) {
                        } else {
                            // Store the data when "Concluir" is pressed
                            storedNomeUsuario = nome
                            storedIdadeUsuario = idade ?? 0
                            storedPesoUsuario = peso ?? 0.0
                            // Convert altura (Double?) to Int for storedAlturaUsuario (Int)
                            storedAlturaUsuario = Int(altura ?? 0.0)

                            print("Cadastro Concluído!")
                            print("Nome: \(nome)")
                            print("Idade: \(idade ?? -1)")
                            print("Peso: \(peso ?? -1)")
                            print("Altura : \(altura ?? -1)")
                            cadastroConcluido = true
                            deveNavegar = true
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    NavigationLink(destination: TabViewTeste(), isActive: $deveNavegar) {
                        EmptyView()
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: idadeTexto) {_, newValue in
            if newValue.count > 2 {
                idadeTexto = String(newValue.prefix(2))
            }
        }
        .onChange(of: pesoTexto) {_, newValue in
            if newValue.count > 4 {
                pesoTexto = String(newValue.prefix(4))
            }
        }
        .onChange(of: alturaTexto) {_, newValue in
            if newValue.count > 4 {
                alturaTexto = String(newValue.prefix(4))
            }
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
                    .offset(x: 0, y: 15)
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
            Spacer()
            CampoCadastro(label: "Nome:", placeholder: "Ex: João da Silva", texto: $nome)
            CampoCadastro(label: "Idade:", placeholder: "Ex: 25 anos", texto: $idadeTexto, keyboard: .numberPad)
            CampoCadastro(label: "Peso (em Kg):", placeholder: "Ex: 70,0 Kg", texto: $pesoTexto, keyboard: .decimalPad)
            CampoCadastro(label: "Altura (em cm):", placeholder: "Ex: 170 (Opcional)", texto: $alturaTexto, keyboard: .decimalPad)
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
                    ? Color("CorBotao")
                    : Color(red: 41/255, green: 38/255, blue: 35/255)
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
                        .foregroundColor(.gray)
                        .padding(.leading, 14)
                }

                TextField("", text: $texto)
                    .foregroundColor(.white)
                    .padding()
                    .keyboardType(keyboard)
            }
            .background(Color(red: 41/255, green: 38/255, blue: 35/255))
            .cornerRadius(12)
            .padding(.bottom, 30)
        }
    }
}

#Preview {
    CadastroInfos()
}
