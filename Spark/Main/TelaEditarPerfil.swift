import SwiftUI
import PhotosUI

struct TelaEditarPerfil: View {
    @Binding var nomeUsuario: String
    @Binding var idadeUsuario: Int
    @Binding var alturaUsuarioCm: Int
    @Binding var pesoUsuarioKg: Double

    @State private var nomeEdit: String = ""
    @State private var idadeEdit: String = ""
    @State private var pesoEdit: String = ""
    @State private var alturaMetrosEdit: String = ""
    @State private var localSelectedItem: PhotosPickerItem? = nil
    @State private var localProfileImage: Image? = nil
    @State private var showingPhotoOptionsDialog = false
    @State private var showPhotoPicker = false

    @AppStorage("profileImageData") private var profileImageData: Data?
    
    @Environment(\.dismiss) var dismiss
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
                        Button(action: {
                            if localProfileImage != nil || profileImageData != nil {
                                showingPhotoOptionsDialog = true
                            } else {
                                showPhotoPicker = true
                            }
                        }) {
                            if let imageToDisplay = localProfileImage {
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
                        .buttonStyle(PlainButtonStyle())
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nome:")
                                .foregroundColor(corTextoPrincipal)
                                .font(.footnote)
                            TextField("Ex: João Silva", text: $nomeEdit)
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
                            TextField("Ex: 25 anos", text: $idadeEdit)
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
                            TextField("Ex: 70.0 kgs", text: $pesoEdit)
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
                            TextField("Ex: 170", text: $alturaMetrosEdit)
                                .keyboardType(.numberPad)
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
            .photosPicker(
                isPresented: $showPhotoPicker,
                selection: $localSelectedItem,
                matching: .images,
                photoLibrary: .shared()
            )
            .onChange(of: localSelectedItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        self.profileImageData = data
                        if let uiImage = UIImage(data: data) {
                            self.localProfileImage = Image(uiImage: uiImage)
                        }
                    }
                }
            }
            .confirmationDialog(
                "Modificar Foto",
                isPresented: $showingPhotoOptionsDialog,
                titleVisibility: .visible
            ) {
                Button("Trocar Foto") {
                    showPhotoPicker = true
                }
                Button("Remover Foto", role: .destructive) {
                    profileImageData = nil
                    localProfileImage = nil
                    localSelectedItem = nil
                }
                Button("Cancelar", role: .cancel) {}
            } message: {
                Text("Selecione uma opção para sua foto de perfil.")
            }
            .onAppear {
                nomeEdit = nomeUsuario
                idadeEdit = idadeUsuario > 0 ? "\(idadeUsuario)" : ""
                pesoEdit = pesoUsuarioKg > 0.0 ? String(format: "%.1f", pesoUsuarioKg).replacingOccurrences(of: ".", with: Locale.current.decimalSeparator ?? ".") : ""
                alturaMetrosEdit = alturaUsuarioCm > 0 ? "\(alturaUsuarioCm)" : ""


                if localProfileImage == nil, let data = profileImageData, let uiImage = UIImage(data: data) {
                    self.localProfileImage = Image(uiImage: uiImage)
                }
            }
        }
        .accentColor(corTextoPrincipal)
    }
    func saveChanges() {
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
        if let height = Int(alturaMetrosEdit) {
            alturaUsuarioCm = height
        } else if alturaMetrosEdit.isEmpty {
            alturaUsuarioCm = 0
        } else {
            print("Entrada de altura inválida (esperado cm)")
        }
        dismiss()
    }
}
