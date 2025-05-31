import SwiftUI
import PhotosUI // Necessário para PhotosPicker

struct TelaEditarPerfil: View {
    // Bindings para os dados do usuário (exceto imagem)
    @Binding var nomeUsuario: String
    @Binding var idadeUsuario: Int
    @Binding var alturaUsuarioCm: Int
    @Binding var pesoUsuarioKg: Double

    // Estado local para os campos de texto
    @State private var nomeEdit: String = ""
    @State private var idadeEdit: String = ""
    @State private var pesoEdit: String = ""
    @State private var alturaMetrosEdit: String = ""

    @State private var localSelectedItem: PhotosPickerItem? = nil
    @State private var localProfileImage: Image? = nil // Imagem exibida localmente

    @Environment(\.dismiss) var dismiss
    
    @AppStorage("profileImageData") private var profileImageData: Data?


 
    let corDeFundoPrincipal = Color("BackgroundColor")
    let corTextoPrincipal = Color.white
    let corTextoPlaceHolder = Color.gray
    let corCampoTextoBackground = Color.gray.opacity(0.25)
    let corBotaoSalvar = Color(red: 233/255, green: 9/255, blue: 22/255)

    var body: some View {
        NavigationView {
            ZStack {
                corDeFundoPrincipal.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 25) {
                        // PhotosPicker para a imagem de perfil local
                        PhotosPicker(
                            selection: $localSelectedItem, // Usa o estado local
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            if let imageToDisplay = localProfileImage { // Exibe a imagem local
                                imageToDisplay
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(corTextoPlaceHolder)
                                    .background(Color.gray.opacity(0.3))
                                    .clipShape(Circle())
                            }
                        }
                        .onChange(of: localSelectedItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        self.localProfileImage = Image(uiImage: uiImage)
                                        self.profileImageData = data // ⬅️ SALVA A IMAGEM
                                    }
                                }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nome:")
                                .foregroundColor(corTextoPrincipal)
                                .font(.footnote)
                            TextField("Usuário X", text: $nomeEdit)
                                .padding(12)
                                .background(corCampoTextoBackground)
                                .foregroundColor(corTextoPrincipal)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )

                            Text("Idade:")
                                .foregroundColor(corTextoPrincipal)
                                .font(.footnote)
                                .padding(.top, 10)
                            TextField("X anos", text: $idadeEdit)
                                .keyboardType(.numberPad)
                                .padding(12)
                                .background(corCampoTextoBackground)
                                .foregroundColor(corTextoPrincipal)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )


                            Text("Peso (em kgs):")
                                .foregroundColor(corTextoPrincipal)
                                .font(.footnote)
                                .padding(.top, 10)
                            TextField("X kgs", text: $pesoEdit)
                                .keyboardType(.decimalPad)
                                .padding(12)
                                .background(corCampoTextoBackground)
                                .foregroundColor(corTextoPrincipal)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )


                            Text("Altura (em cm):")
                                .foregroundColor(corTextoPrincipal)
                                .font(.footnote)
                                .padding(.top, 10)
                            TextField("X.Ym", text: $alturaMetrosEdit)
                                .keyboardType(.decimalPad)
                                .padding(12)
                                .background(corCampoTextoBackground)
                                .foregroundColor(corTextoPrincipal)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal, 25)


                        Button(action: {
                            saveChanges()
                        }) {
                            Text("Salvar")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(corBotaoSalvar)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                        .padding(.bottom, 30)

                        Spacer()
                    }
                }
            }
            .navigationTitle("Editar Perfil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(corTextoPrincipal)
                    }
                }
            }
            .onAppear {
                nomeEdit = nomeUsuario
                idadeEdit = idadeUsuario > 0 ? "\(idadeUsuario)" : ""
                pesoEdit = pesoUsuarioKg > 0.0 ? String(format: "%.1f", pesoUsuarioKg).replacingOccurrences(of: ".", with: Locale.current.decimalSeparator ?? ".") : ""
                alturaMetrosEdit = alturaUsuarioCm > 0 ? String(format: "%.2f", Double(alturaUsuarioCm) / 100.0).replacingOccurrences(of: ".", with: Locale.current.decimalSeparator ?? ".") : ""

            }
        }
        .accentColor(corTextoPrincipal)
    }

    func saveChanges() {
        // Salva nome, idade, peso, altura
        nomeUsuario = nomeEdit

        if let age = Int(idadeEdit) {
            idadeUsuario = age
        } else if idadeEdit.isEmpty {
            idadeUsuario = 0
        } else {
            print("Entrada de idade inválida")
        }

        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal

        let trimmedWeightString = pesoEdit.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedWeightString.isEmpty {
            if let weightNum = formatter.number(from: trimmedWeightString) {
                pesoUsuarioKg = weightNum.doubleValue
            } else {
                if let weight = Double(trimmedWeightString.replacingOccurrences(of: ",", with: ".")) {
                    pesoUsuarioKg = weight
                } else {
                    print("Entrada de peso inválida")
                }
            }
        } else {
            pesoUsuarioKg = 0.0
        }

        let trimmedHeightString = alturaMetrosEdit.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedHeightString.isEmpty {
             if let heightNum = formatter.number(from: trimmedHeightString) {
                alturaUsuarioCm = Int(heightNum.doubleValue * 100)
            } else {
                if let heightMeters = Double(trimmedHeightString.replacingOccurrences(of: ",", with: ".")) {
                    alturaUsuarioCm = Int(heightMeters * 100)
                } else {
                     print("Entrada de altura inválida")
                }
            }
        } else {
            alturaUsuarioCm = 0
        }
        dismiss()
    }
}
